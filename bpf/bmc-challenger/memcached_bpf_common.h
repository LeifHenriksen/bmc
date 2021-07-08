#ifndef _MEMCACHED_BPF_COMMON_H
#define _MEMCACHED_BPF_COMMON_H

#define MAX_KEY_LENGTH 250
#define MAX_VAL_LENGTH 100 //max: 2729 when cache contains only 1 entry
#define MAX_ADDITIONAL_PAYLOAD_BYTES 53
#define MAX_CACHE_DATA_SIZE MAX_KEY_LENGTH+MAX_VAL_LENGTH+MAX_ADDITIONAL_PAYLOAD_BYTES
#define MAX_KEY_IN_MULTIGET 31
#define CACHE_ENTRY_COUNT 3250000 //old 2777777 //max: 4194299, 12201599 for 32-byte values, 2777777 is a tenth of memcached, 6944444 for 25%
#define MAX_PACKET_LENGTH 1500
#define MAX_KEY_IN_PACKET MAX_KEY_IN_MULTIGET

//#define CACHE_ENTRY_LIFEPOINTS 1
//#define CACHE_ENTRY_BASE_LIFEPOINTS CACHE_ENTRY_LIFEPOINTS+1
#define CACHE_ENTRY_BASE_LIFEPOINTS 2 
#define HOT_DATA_LIMIT 3500000

#define UNCALLABLE -1

#define FNV_OFFSET_BASIS_32		2166136261
#define FNV_PRIME_32			16777619
#define FNV_PRIME_2_32                  83227

enum {
	PROG_MEMCACHED_XDP_GET_PARSE = 0,
	PROG_MEMCACHED_XDP_GET_ADJUST_PKT,
	PROG_MEMCACHED_XDP_GET_WRITE_PKT,
	PROG_MEMCACHED_XDP_SET_PARSE,

	PROG_MEMCACHED_XDP_MAX
};

enum {
	PROG_MEMCACHED_TC_GET_PARSE = 0,

	PROG_MEMCACHED_TC_MAX
};


struct memcached_cache_entry {
	struct bpf_spin_lock lock;
	unsigned int len;
	char valid;
	unsigned int hash;
	unsigned int challenger;
	char data[MAX_CACHE_DATA_SIZE];
};

struct memcached_bpf_stats {
	unsigned int get_recv_count; 		// Number of GET command received
	unsigned int set_recv_count; 		// Number of SET command received
	unsigned int get_resp_count; 		// Number of GET command response analyzed
	unsigned int hit_misprediction;  	// Number of keys that were expected to hit but did not (either because of a hash colision or a race with an invalidation/update)
	unsigned int hit_count;			// Number of HIT in kernel cache
	unsigned int miss_count;     		// Number of MISS in kernel cache
	unsigned int update_count;		// Number of kernel cache updates
	unsigned int invalidation_count; 	// Number of kernel cache entry invalidated
	unsigned int hot_replace_hot;		// Number of cache entries that have never been read before eviction
	unsigned int cold_replace_cold;
	unsigned int hot_replace_cold;
	unsigned int cold_replace_hot;
};

#endif
