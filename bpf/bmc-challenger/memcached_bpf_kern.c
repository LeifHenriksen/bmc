#define KBUILD_MODNAME "bpf"

#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <linux/tcp.h>
#include "bpf_helpers.h"

#include "memcached_bpf_common.h"

#define ADJUST_HEAD_LEN 128

#define KEY_HOTNESS_OFFSET 29
#define KEY_HOTNESS_SIZE 4

#ifndef memset
# define memset(dest, chr, n)   __builtin_memset((dest), (chr), (n))
#endif

#ifndef memcpy
# define memcpy(dest, src, n)   __builtin_memcpy((dest), (src), (n))
#endif

#ifndef memmove
# define memmove(dest, src, n)  __builtin_memmove((dest), (src), (n))
#endif

#define log_error(fmt, ...)                                     \
({                                                              \
    char ____fmt[] = "Error: "fmt;                              \
    bpf_trace_printk(____fmt, sizeof(____fmt), ##__VA_ARGS__);  \
})

#define log_info(fmt, ...)                                      \
({                                                              \
    char ____fmt[] = "Info: "fmt;                               \
    bpf_trace_printk(____fmt, sizeof(____fmt), ##__VA_ARGS__);  \
})

#define log_test(fmt, ...)                                      \
({                                                              \
    char ____fmt[] = "TEST: "fmt;                               \
    bpf_trace_printk(____fmt, sizeof(____fmt), ##__VA_ARGS__);  \
})

struct memcached_udp_header {
    __be16 request_id;
    __be16 seq_num;
    __be16 num_dgram;
    __be16 unused;
    char data[];
} __attribute__((__packed__));


/*
 * eBPF maps
 */

/* cache */
struct {
	__uint(type, BPF_MAP_TYPE_ARRAY);
	__type(key, u32);
	__type(value, struct memcached_cache_entry);
	__uint(max_entries, CACHE_ENTRY_COUNT);
} map_kcache SEC(".maps");


/* keys */
struct memcached_key {
	u32 hash;
	char data[MAX_KEY_LENGTH];
	unsigned int len;
};

struct {
	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
	__type(key, unsigned int);
	__type(value, struct memcached_key);
	__uint(max_entries, MAX_KEY_IN_PACKET);
} map_keys SEC(".maps");

/* context */
struct parsing_context {
	unsigned int key_count;
	unsigned int current_key;
	unsigned short read_pkt_offset;
	unsigned short write_pkt_offset;
};
struct bpf_map_def SEC("maps") map_parsing_context = {
	.type = BPF_MAP_TYPE_PERCPU_ARRAY,
	.key_size = sizeof(unsigned int),
	.value_size = sizeof(struct parsing_context),
	.max_entries = 1,
};

/* stats */
struct bpf_map_def SEC("maps") map_stats = {
	.type = BPF_MAP_TYPE_PERCPU_ARRAY,
	.key_size = sizeof(unsigned int),
	.value_size = sizeof(struct memcached_bpf_stats),
	.max_entries = 1,
};

/* program maps */
struct bpf_map_def SEC("maps") map_progs_xdp = {
	.type = BPF_MAP_TYPE_PROG_ARRAY,
	.key_size = sizeof(u32),
	.value_size = sizeof(u32),
	.max_entries = PROG_MEMCACHED_XDP_MAX,
};

struct bpf_map_def SEC("maps") map_progs_tc = {
	.type = BPF_MAP_TYPE_PROG_ARRAY,
	.key_size = sizeof(u32),
	.value_size = sizeof(u32),
	.max_entries = PROG_MEMCACHED_TC_MAX,
};


static inline u16 compute_ip_checksum(struct iphdr *ip)
{
    u32 csum = 0;
    u16 *next_ip_u16 = (u16 *)ip;

    ip->check = 0;

#pragma clang loop unroll(full)
    for (int i = 0; i < (sizeof(*ip) >> 1); i++)
        csum += *next_ip_u16++;

	return ~((csum & 0xffff) + (csum >> 16));
}

SEC("xdp_memcached_rx")
int xdp_memcached_rx_main(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct ethhdr *eth = data;
	struct iphdr *ip = data + sizeof(*eth);
	void *transp = data + sizeof(*eth) + sizeof(*ip);
	struct udphdr *udp;
	struct tcphdr *tcp;
	char *payload;
	__be16 dport;
	if (ip + 1 > data_end)
		return XDP_PASS;

	switch (ip->protocol) {
		case IPPROTO_UDP:
			udp = (struct udphdr *) transp;
			if (udp + 1 > data_end)
				return XDP_PASS;
			dport = udp->dest;
			payload = transp + sizeof(*udp) + sizeof(struct memcached_udp_header);
			break;
		case IPPROTO_TCP:
			tcp = (struct tcphdr *) transp;
			if (tcp + 1 > data_end)
				return XDP_PASS;
			dport = tcp->dest;
			payload = transp + sizeof(*tcp);
			break;
		default:
			return XDP_PASS;
	}

	if (dport == htons(11211) && payload+4 <= data_end) {

		if (ip->protocol == IPPROTO_UDP && payload[0] == 'g' && payload[1] == 'e' && payload[2] == 't' && payload[3] == ' ') { // is this a GET request
			unsigned int zero = 0;
			struct memcached_bpf_stats *stats = bpf_map_lookup_elem(&map_stats, &zero);
			if (!stats) {
				return XDP_PASS;
			}
			stats->get_recv_count++;

			struct parsing_context *pctx = bpf_map_lookup_elem(&map_parsing_context, &zero);
			if (!pctx) {
				return XDP_PASS;
			}
			pctx->key_count = 0;
			pctx->current_key = 0;
			pctx->write_pkt_offset = 0;

			unsigned int off;
#pragma clang loop unroll(disable)
			for (off = 4; off < MAX_PACKET_LENGTH && payload+off+1 <= data_end && payload[off] == ' '; off++) {} // move offset to the start of the first key
			if (off < MAX_PACKET_LENGTH) {
				pctx->read_pkt_offset = off; // save offset
				if (bpf_xdp_adjust_head(ctx, sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(struct memcached_udp_header) + off)) // push headers + 'get ' keyword
					return XDP_PASS;
				bpf_tail_call(ctx, &map_progs_xdp, PROG_MEMCACHED_XDP_GET_PARSE);
			}
		}
		else if (ip->protocol == IPPROTO_TCP) {
			bpf_tail_call(ctx, &map_progs_xdp, PROG_MEMCACHED_XDP_SET_PARSE);
		}
	}

	return XDP_PASS;
}


SEC("xdp_memcached_rx_get_parse")
int xdp_memcached_rx_get_parse_main(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	char *payload = (char *) data;
	unsigned int zero = 0;

	if (payload >= data_end)
		return XDP_PASS;

	struct parsing_context *pctx = bpf_map_lookup_elem(&map_parsing_context, &zero);
	if (!pctx) {
		return XDP_PASS;
	}

	struct memcached_key *key = bpf_map_lookup_elem(&map_keys, &pctx->key_count);
	if (!key) {
		return XDP_PASS;
	}
	key->hash = FNV_OFFSET_BASIS_32;

	unsigned int off, done_parsing = 0, key_len = 0;

	// compute the key hash
#pragma clang loop unroll(disable)
	for (off = 0; off < MAX_KEY_LENGTH+1 && payload+off+1 <= data_end; off++) {
		if (payload[off] == '\r') {
			done_parsing = 1;
			break;
		}
		else if (payload[off] == ' ') {
			break;
		}
		else if (payload[off] != ' ') {
			key->hash ^= payload[off];
			key->hash *= FNV_PRIME_32;
			key_len++;
		}
	}

	if (key_len == 0 || key_len > MAX_KEY_LENGTH) {
		bpf_xdp_adjust_head(ctx, 0 - (sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr) + sizeof(struct memcached_udp_header) + pctx->read_pkt_offset)); // unexpected key, let the netstack handle it
		return XDP_PASS;
	}

	u32 cache_idx = key->hash % CACHE_ENTRY_COUNT;
	struct memcached_cache_entry *entry = bpf_map_lookup_elem(&map_kcache, &cache_idx);
	if (!entry) { // should never happen since cache map is of type BPF_MAP_TYPE_ARRAY
		return XDP_PASS;
	}

	bpf_spin_lock(&entry->lock);
	if (entry->valid && entry->hash == key->hash) { // potential cache hit
		bpf_spin_unlock(&entry->lock);
		unsigned int i = 0;
#pragma clang loop unroll(disable)
		for (; i < key_len && payload+i+1 <= data_end; i++) { // copy the request key to compare it with the one stored in the cache later
			key->data[i] = payload[i];
		}
		key->len = key_len;
		pctx->key_count++;
	} else { // cache miss
		bpf_spin_unlock(&entry->lock);
		struct memcached_bpf_stats *stats = bpf_map_lookup_elem(&map_stats, &zero);
		if (!stats) {
			return XDP_PASS;
		}
		stats->miss_count++;
	}

	if (done_parsing) { // the end of the request has been reached
		bpf_xdp_adjust_head(ctx, 0 - (sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr) + sizeof(struct memcached_udp_header) + pctx->read_pkt_offset)); // pop headers + 'get ' + previous keys
		if (pctx->key_count > 0) {
			bpf_tail_call(ctx, &map_progs_xdp, PROG_MEMCACHED_XDP_GET_ADJUST_PKT);
		}
	} else { // more keys to process
		off++; // move offset to the start of the next key
		pctx->read_pkt_offset += off;
		if (bpf_xdp_adjust_head(ctx, off)) // push the previous key
			return XDP_PASS;
		bpf_tail_call(ctx, &map_progs_xdp, PROG_MEMCACHED_XDP_GET_PARSE);
	}

	return XDP_PASS;
}

SEC("xdp_memcached_rx_get_adjust_pkt")
int xdp_memcached_rx_get_adjust_pkt_main(struct xdp_md *ctx)
{
	if (bpf_xdp_adjust_head(ctx, -ADJUST_HEAD_LEN)) // // pop empty packet buffer memory to increase the available packet size
		return XDP_PASS;

	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct ethhdr *eth = data;
	struct iphdr *ip = data + sizeof(*eth);
	struct udphdr *udp = data + sizeof(*eth) + sizeof(*ip);
	struct memcached_udp_header *memcached_udp_hdr = data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp);
	char *payload = (char *) (memcached_udp_hdr + 1);
	void *old_data = data + ADJUST_HEAD_LEN;
	char *old_payload = (char *) (old_data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*memcached_udp_hdr));

	if (payload >= data_end || old_payload+1 >= data_end)
		return XDP_PASS;

	// use old headers as a base; then update addresses and ports to create the new headers
	memmove(eth, old_data, sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*memcached_udp_hdr));

	unsigned char tmp_mac[ETH_ALEN];
	__be32 tmp_ip;
	__be16 tmp_port;

	memcpy(tmp_mac, eth->h_source, ETH_ALEN);
	memcpy(eth->h_source, eth->h_dest, ETH_ALEN);
	memcpy(eth->h_dest, tmp_mac, ETH_ALEN);

	tmp_ip = ip->saddr;
	ip->saddr = ip->daddr;
	ip->daddr = tmp_ip;

	tmp_port = udp->source;
	udp->source = udp->dest;
	udp->dest = tmp_port;

	if (bpf_xdp_adjust_head(ctx, sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(*memcached_udp_hdr))) // push new headers
		return XDP_PASS;

	bpf_tail_call(ctx, &map_progs_xdp, PROG_MEMCACHED_XDP_GET_WRITE_PKT);

	return XDP_PASS;
}

SEC("xdp_memcached_rx_get_write_pkt")
int xdp_memcached_rx_get_write_pkt_main(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	char *payload = (char *) data;
	unsigned int zero = 0;

	if (payload >= data_end)
		return XDP_PASS;

	struct parsing_context *pctx = bpf_map_lookup_elem(&map_parsing_context, &zero);
	if (!pctx) {
		return XDP_PASS;
	}

	struct memcached_key *key = bpf_map_lookup_elem(&map_keys, &pctx->current_key);
	if (!key) {
		return XDP_PASS;
	}

	unsigned int cache_hit = 1, written = 0;
	u32 cache_idx = key->hash % CACHE_ENTRY_COUNT;
	struct memcached_cache_entry *entry = bpf_map_lookup_elem(&map_kcache, &cache_idx);
	if (!entry) {
		return XDP_DROP;
	}

	bpf_spin_lock(&entry->lock);
	if (entry->valid && key->hash == entry->hash) { // if saved key still matches its corresponding cache entry
#pragma clang loop unroll(disable)
		for (int i = 0; i < MAX_KEY_LENGTH && i < key->len; i++) { // compare the saved key with the one stored in the cache entry
			if (key->data[i] != entry->data[6+i]) {
				cache_hit = 0;
			}
		}
		if (cache_hit) { // if cache HIT then copy cached data
			unsigned int off;
#pragma clang loop unroll(disable)
			for (off = 0; off+sizeof(unsigned long long) < MAX_CACHE_DATA_SIZE && off+sizeof(unsigned long long) <= entry->len && payload+off+sizeof(unsigned long long) <= data_end; off++) {
				*((unsigned long long *) &payload[off]) = *((unsigned long long *) &entry->data[off]);
				off += sizeof(unsigned long long)-1;
				written += sizeof(unsigned long long);
			}
#pragma clang loop unroll(disable)
			for (; off < MAX_CACHE_DATA_SIZE && off < entry->len && payload+off+1 <= data_end; off++) {
				payload[off] = entry->data[off];
				written += 1;
			}
			//if (entry->valid < CACHE_ENTRY_BASE_LIFEPOINTS) {
			//	entry->valid++;
			//}
			entry->valid = CACHE_ENTRY_BASE_LIFEPOINTS;
			entry->challenger = 0;
		}
	}
	bpf_spin_unlock(&entry->lock);

	struct memcached_bpf_stats *stats = bpf_map_lookup_elem(&map_stats, &zero);
	if (!stats) {
		return XDP_PASS;
	}
	if (cache_hit) {
		stats->hit_count++;
	} else {
		stats->miss_count++;
	}

	pctx->current_key++;

	if (pctx->current_key == pctx->key_count && (pctx->write_pkt_offset > 0 || written > 0)) { // if all saved keys have been processed and a least one cache HIT
		if (payload+written+5 <= data_end) {
			payload[written++] = 'E';
			payload[written++] = 'N';
			payload[written++] = 'D';
			payload[written++] = '\r';
			payload[written++] = '\n';

			if (bpf_xdp_adjust_head(ctx, 0 - (int) (sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr)
													+ sizeof(struct memcached_udp_header) + pctx->write_pkt_offset))) { // pop headers + previously written data
				return XDP_DROP;
			}

			void *data_end = (void *)(long)ctx->data_end;
			void *data = (void *)(long)ctx->data;
			struct iphdr *ip = data + sizeof(struct ethhdr);
			struct udphdr *udp = data + sizeof(struct ethhdr) + sizeof(*ip);
			payload = data + sizeof(struct ethhdr) + sizeof(*ip) + sizeof(*udp) + sizeof(struct memcached_udp_header);

			if (udp + 1 > data_end)
				return XDP_PASS;

			ip->tot_len = htons((payload+pctx->write_pkt_offset+written) - (char*)ip);
			ip->check = compute_ip_checksum(ip);
			udp->check = 0; // computing udp checksum is not required
			udp->len = htons((payload+pctx->write_pkt_offset+written) - (char*)udp);

			bpf_xdp_adjust_tail(ctx, 0 - (int) ((long) data_end - (long) (payload+pctx->write_pkt_offset+written))); // try to strip additional bytes

			return XDP_TX;
		}
	} else if (pctx->current_key == pctx->key_count) { // else if all saved keys have been processed but got no cache HIT; either because of a hash colision or a race with a cache update
		stats->hit_misprediction += pctx->key_count;
		bpf_xdp_adjust_head(ctx, ADJUST_HEAD_LEN - (sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr) + sizeof(struct memcached_udp_header))); // pop to the old headers and transmit to netstack
		return XDP_PASS;
	} else if (pctx->current_key < MAX_KEY_IN_PACKET) { // else if there are still keys to process
		pctx->write_pkt_offset += written; // save packet write offset
		if (bpf_xdp_adjust_head(ctx, written)) // push written data
			return XDP_DROP;
		bpf_tail_call(ctx, &map_progs_xdp, PROG_MEMCACHED_XDP_GET_WRITE_PKT);
	}

	return XDP_DROP;
}

SEC("xdp_memcached_rx_set_parse")
int xdp_memcached_rx_set_parse_main(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct ethhdr *eth = data;
	struct iphdr *ip = data + sizeof(*eth);
	struct tcphdr *tcp = data + sizeof(*eth) + sizeof(*ip);
	char *payload = (char *) (tcp + 1);
	unsigned int zero = 0;

	if (payload >= data_end)
		return XDP_PASS;

	struct memcached_bpf_stats *stats = bpf_map_lookup_elem(&map_stats, &zero);
	if (!stats) {
		return XDP_PASS;
	}

	u32 hash;
	int set_found = 0, key_found = 0;

#pragma clang loop unroll(disable)
	for (unsigned int off = 0; off < MAX_PACKET_LENGTH && payload+off+1 <= data_end; off++) {

		if (set_found == 0 && payload[off] == 's' && payload+off+3 <= data_end && payload[off+1] == 'e' && payload[off+2] == 't') {
			set_found = 1;
			off += 3; // move offset after the set keywork, at the next iteration 'off' will either point to a space or the start of the key
			stats->set_recv_count++;
		}
		else if (key_found == 0 && set_found == 1 && payload[off] != ' ') {
			if (payload[off] == '\r') { // end of packet
				set_found = 0;
				key_found = 0;
			} else { // found the start of the key
				hash = FNV_OFFSET_BASIS_32;
				hash ^= payload[off];
				hash *= FNV_PRIME_32;
				key_found = 1;
			}
		}
		else if (key_found == 1) {
			if (payload[off] == ' ') { // found the end of the key
				u32 cache_idx = hash % CACHE_ENTRY_COUNT;
				struct memcached_cache_entry *entry = bpf_map_lookup_elem(&map_kcache, &cache_idx);
				if (!entry) {
					return XDP_PASS;
				}
				bpf_spin_lock(&entry->lock);
				if (entry->valid && entry->hash == hash) {
					/*if (entry->valid == 1) {
						stats->unused_count++;
					}*/
					entry->valid = 0;
					stats->invalidation_count++;
				}
				bpf_spin_unlock(&entry->lock);
				set_found = 0;
				key_found = 0;
			}
			else { // still processing the key
				hash ^= payload[off];
				hash *= FNV_PRIME_32;
			}
		}
	}

	if (set_found == 1 || key_found == 1) {
		log_error("SET found but it couldn't be used to invalidate the cache entry\n");
	}

	return XDP_PASS;
}

SEC("tc_memcached_tx")
int tc_memcached_tx_main(struct __sk_buff *skb)
{
	void *data_end = (void *)(long)skb->data_end;
	void *data     = (void *)(long)skb->data;
	struct ethhdr *eth = data;
	struct iphdr *ip = data + sizeof(*eth);
	struct udphdr *udp = data + sizeof(*eth) + sizeof(*ip);
	char *payload = data + sizeof(*eth) + sizeof(*ip) + sizeof(*udp) + sizeof(struct memcached_udp_header);
	unsigned int zero = 0;

	// if the size exceeds the size of a cache entry do not bother going further
	if (skb->len > MAX_CACHE_DATA_SIZE + sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr) + sizeof(struct memcached_udp_header))
		return TC_ACT_OK;

	if (ip + 1 > data_end)
		return XDP_PASS;

	if (ip->protocol != IPPROTO_UDP)
		return TC_ACT_OK;

	if (udp + 1 > data_end)
		return TC_ACT_OK;

	__be16 sport = udp->source;

	if (sport == htons(11211) && payload+5+1 <= data_end && payload[0] == 'V' && payload[1] == 'A' && payload[2] == 'L'
		&& payload[3] == 'U' && payload[4] == 'E' && payload[5] == ' ') { // if this is a GET reply

		struct memcached_bpf_stats *stats = bpf_map_lookup_elem(&map_stats, &zero);
		if (!stats) {
			return XDP_PASS;
		}
		stats->get_resp_count++;

		bpf_tail_call(skb, &map_progs_tc, PROG_MEMCACHED_TC_GET_PARSE);
	}

	return TC_ACT_OK;
}

SEC("tc_memcached_tx_get_parse")
int tc_memcached_tx_get_parse_main(struct __sk_buff *skb)
{
	void *data_end = (void *)(long)skb->data_end;
	void *data = (void *)(long)skb->data;
	char *payload = (data + sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr) + sizeof(struct memcached_udp_header));
	unsigned int zero = 0;

	u32 hash  = FNV_OFFSET_BASIS_32;
	u32 hash2 = FNV_OFFSET_BASIS_32;

#pragma clang loop unroll(disable)
	for (unsigned int off = 6; off-6 < MAX_KEY_LENGTH && payload+off+1 <= data_end && payload[off] != ' '; off++) {
		hash ^= payload[off];
		hash *= FNV_PRIME_32;
		hash2 ^= payload[off];
		hash2 *= FNV_PRIME_2_32;
	}
	
	u32 cache_idx = hash % CACHE_ENTRY_COUNT;
	struct memcached_cache_entry *entry = bpf_map_lookup_elem(&map_kcache, &cache_idx);
	if (!entry) {
		return TC_ACT_OK;
	}

	//u32 new_key_hotness = 0xFFFFFFFF;
	//if (payload+KEY_HOTNESS_OFFSET+KEY_HOTNESS_SIZE <= data_end) {
	//	new_key_hotness = ((u32)payload[KEY_HOTNESS_OFFSET] << 24) + ((u32)payload[KEY_HOTNESS_OFFSET+1] << 16) + ((u32)payload[KEY_HOTNESS_OFFSET+2] << 8) + ((u32)payload[KEY_HOTNESS_OFFSET+3]);
	//}

	bpf_spin_lock(&entry->lock);
	if (entry->valid && entry->hash == hash) { // cache is up-to-date; no need to update
		int diff = 0;
		// loop until both bytes are spaces ; or break if they are different
#pragma clang loop unroll(disable)
		for (unsigned int off = 6; off-6 < MAX_KEY_LENGTH && payload+off+1 <= data_end && off < entry->len && (payload[off] != ' ' || entry->data[off] != ' '); off++) {
			if (entry->data[off] != payload[off]) {
				diff = 1;
				break;
			}
		}
		if (diff == 0) {
			bpf_spin_unlock(&entry->lock);
			return TC_ACT_OK;
		}
	}

	unsigned int old_valid = entry->valid;
	
	
	if(entry->valid > 1 && entry->challenger != hash2) { // New challenger
		entry->challenger = hash2;
		bpf_spin_unlock(&entry->lock);
		//log_info("New challeger : entry->hash = %u, entry->valid = %u, hash2 = %u", entry->hash, entry->valid, hash2);
		//log_info("entry->challenger = %u, hash = %u, entry->data = %i\n", entry->challenger, hash, entry->data[6]);
		return TC_ACT_OK;
	}
	else if (entry->challenger == hash2 && (--entry->valid) > 1) { // I am the challenger, I can decrease entry->valid
		bpf_spin_unlock(&entry->lock);
		//log_info("valid--: entry->hash = %u, entry->valid = %u, hash2 = %u", entry->hash, entry->valid, hash2);
		//log_info("entry->challenger = %u, hash = %u, entry->data = %i\n", entry->challenger, hash, entry->data[6]);
		return TC_ACT_OK;
	}
	

	//u32 old_key_hotness = 0xFFFFFFFF;
	//if (entry->valid > 0 && KEY_HOTNESS_OFFSET+KEY_HOTNESS_SIZE < MAX_CACHE_DATA_SIZE) {
	//	old_key_hotness = ((u32)entry->data[KEY_HOTNESS_OFFSET] << 24) + ((u32)entry->data[KEY_HOTNESS_OFFSET+1] << 16) + ((u32)entry->data[KEY_HOTNESS_OFFSET+2] << 8) + ((u32)entry->data[KEY_HOTNESS_OFFSET+3]); 
	//}

	unsigned int count = 0;
	entry->len = 0;
	// store the reply from start to the '\n' that follows the data
#pragma clang loop unroll(disable)
	for (unsigned int j = 0; j < MAX_CACHE_DATA_SIZE && payload+j+1 <= data_end && count < 2; j++) {
		entry->data[j] = payload[j];
		entry->len++;
		if (payload[j] == '\n')
			count++;
	}

	/*if (new_key_hotness == old_key_hotness) {
		bpf_spin_unlock(&entry->lock);
		return TC_ACT_OK;
	}*/

	//unsigned int not_used = 0;
	if (count == 2) { // copy OK
		/*if (entry->valid == 1) {
			not_used = 1;
		}*/
		entry->valid = CACHE_ENTRY_BASE_LIFEPOINTS;
		entry->hash  = hash;
		entry->challenger = 0;
		bpf_spin_unlock(&entry->lock);
		struct memcached_bpf_stats *stats = bpf_map_lookup_elem(&map_stats, &zero);
		if (!stats) {
			return XDP_PASS;
		}
		stats->update_count++;
		if(old_valid > 0) {
			stats->hot_replace_cold++;
		}
		//stats->unused_count += not_used;
		/*
		if (old_key_hotness < HOT_DATA_LIMIT && new_key_hotness < HOT_DATA_LIMIT) {
			stats->hot_replace_hot++;
		} else if (old_key_hotness >= HOT_DATA_LIMIT && new_key_hotness >= HOT_DATA_LIMIT) {
			stats->cold_replace_cold++;
		} else if (old_key_hotness >= HOT_DATA_LIMIT && new_key_hotness < HOT_DATA_LIMIT) {
			stats->hot_replace_cold++;
		} else if (old_key_hotness < HOT_DATA_LIMIT && new_key_hotness >= HOT_DATA_LIMIT) {
			stats->cold_replace_hot++;
		}
		*/
	} else {
		bpf_spin_unlock(&entry->lock);
	}

	//log_info("entry->hash = %u, entry->valid = %u, hash2 = %u", entry->hash, entry->valid, hash2);
	//log_info("entry->challenger = %u, hash = %u, entry->data = %i\n", entry->challenger, hash, entry->data[6]);
	/* if (old_key_hotness < 0xFFFFFFFF && new_key_hotness < 0xFFFFFFFF) {
		log_info("new_key_hotness: %u / old_key_hotness: %u\n", new_key_hotness, old_key_hotness);
	} */

	return TC_ACT_OK;
}

char _license[] SEC("license") = "GPL";

/*
https://github.com/memcached/memcached/blob/master/memcached.h#L491
https://github.com/memcached/memcached/blob/master/memcached.c#L3808
	Format r??ponse aux commandes get:
	(VALUE <key> <flags> <bytes> [<cas unique>]\r\n
	<data block>\r\n)*
	END\r\n

	Avec:
	- flags: eniter 32-bits pour Memcached >= 1.2.1
	- bytes: entier 32-bits
	- cas: 	 entier 64-bits

*/

// to test colisions: keys declinate0123456 and macallums0123456 have hash colision
