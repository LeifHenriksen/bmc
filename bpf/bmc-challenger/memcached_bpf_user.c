#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <time.h>
#include <assert.h>
#include <errno.h>
#include <sys/resource.h>
#include <linux/if_link.h>
#include <linux/limits.h>

#include <linux/bpf.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include "memcached_bpf_common.h"

#define BPF_SYSFS_ROOT "/sys/fs/bpf"

#define STATS_PATH "/tmp/Memcached-bpf/memcached_bpf_stats.txt"
#define STATS_INTERVAL_PATH "/tmp/Memcached-bpf/memcached_bpf_stats_interval.txt"
#define CACHE_DUMP_PATH "/tmp/Memcached-bpf/cache_dump.txt"

#define DUMP_CACHE_VALUE 1

static int nr_cpus = 0;

struct bpf_progs_desc {
	char name[256];
	enum bpf_prog_type type;
	unsigned char pin;
	int map_prog_idx;
	struct bpf_program *prog;
};

static struct bpf_progs_desc progs[] = {
	{"xdp_memcached_rx", BPF_PROG_TYPE_XDP, 0, UNCALLABLE, NULL},
	{"xdp_memcached_rx_get_parse", BPF_PROG_TYPE_XDP, 0, PROG_MEMCACHED_XDP_GET_PARSE, NULL},
	{"xdp_memcached_rx_get_adjust_pkt", BPF_PROG_TYPE_XDP, 0, PROG_MEMCACHED_XDP_GET_ADJUST_PKT, NULL},
	{"xdp_memcached_rx_get_write_pkt", BPF_PROG_TYPE_XDP, 0, PROG_MEMCACHED_XDP_GET_WRITE_PKT, NULL},
	{"xdp_memcached_rx_set_parse", BPF_PROG_TYPE_XDP, 0, PROG_MEMCACHED_XDP_SET_PARSE, NULL},

	{"tc_memcached_tx", BPF_PROG_TYPE_SCHED_CLS, 1, UNCALLABLE, NULL},
	{"tc_memcached_tx_get_parse", BPF_PROG_TYPE_SCHED_CLS, 0, PROG_MEMCACHED_TC_GET_PARSE, NULL},
};

uint32_t fnv1a_hash32(char *key, size_t length, uint32_t hash)
{
	for (int i = 0; i < length; i++) {
		hash ^= key[i];
		hash *= FNV_PRIME_32;
	}
	return hash;
}

int write_stats_to_file(char *filename, int map_fd)
{
	struct memcached_bpf_stats *stats = malloc(nr_cpus * sizeof(struct memcached_bpf_stats));
	struct memcached_bpf_stats aggregate_stats;
	__u32 key = 0;
	FILE *fp;

	memset(&aggregate_stats, 0, sizeof(struct memcached_bpf_stats));

	assert(bpf_map_lookup_elem(map_fd, &key, stats) == 0);
	for (int i = 0; i < nr_cpus; i++) {
		aggregate_stats.get_recv_count += stats[i].get_recv_count;
		aggregate_stats.set_recv_count += stats[i].set_recv_count;
		aggregate_stats.get_resp_count += stats[i].get_resp_count;
		aggregate_stats.hit_misprediction += stats[i].hit_misprediction;
		aggregate_stats.hit_count += stats[i].hit_count;
		aggregate_stats.miss_count += stats[i].miss_count;
		aggregate_stats.update_count += stats[i].update_count;
		aggregate_stats.invalidation_count += stats[i].invalidation_count;
		aggregate_stats.hot_replace_hot += stats[i].hot_replace_hot;
		aggregate_stats.cold_replace_cold += stats[i].cold_replace_cold;
		aggregate_stats.hot_replace_cold += stats[i].hot_replace_cold;
		aggregate_stats.cold_replace_hot += stats[i].cold_replace_hot;
	}

	fp = fopen(STATS_PATH, "w+");
	if (fp == NULL) {
		fprintf(stderr, "Error: failed to write stats to file '%s'\n", filename);
		return -1;
	}

	fprintf(fp, "STAT get_recv_count %u\n", aggregate_stats.get_recv_count);
	fprintf(fp, "STAT set_recv_count %u\n", aggregate_stats.set_recv_count);
	fprintf(fp, "STAT get_resp_count %u\n", aggregate_stats.get_resp_count);
	fprintf(fp, "STAT get_key_count %u\n", aggregate_stats.hit_misprediction);
	fprintf(fp, "STAT hit_count %u\n", aggregate_stats.hit_count);
	fprintf(fp, "STAT miss_count %u\n", aggregate_stats.miss_count);
	fprintf(fp, "STAT update_count %u\n", aggregate_stats.update_count);
	fprintf(fp, "STAT invalidation_count %u\n", aggregate_stats.invalidation_count);
	fprintf(fp, "STAT hot_replace_hot %u\n", aggregate_stats.hot_replace_hot);
	fprintf(fp, "STAT cold_replace_cold %u\n", aggregate_stats.cold_replace_cold);
	fprintf(fp, "STAT hot_replace_cold %u\n", aggregate_stats.hot_replace_cold);
	fprintf(fp, "STAT cold_replace_hot %u\n", aggregate_stats.cold_replace_hot);

	fclose(fp);
	free(stats);
	return 0;
}

int write_stat_line(FILE *fp, int map_fd)
{
	struct memcached_bpf_stats *stats = malloc(nr_cpus * sizeof(struct memcached_bpf_stats));
	struct memcached_bpf_stats aggregate_stats;
	__u32 key = 0;

	memset(&aggregate_stats, 0, sizeof(struct memcached_bpf_stats));

	assert(bpf_map_lookup_elem(map_fd, &key, stats) == 0);

	for (int i = 0; i < nr_cpus; i++) {
		aggregate_stats.get_recv_count += stats[i].get_recv_count;
		aggregate_stats.set_recv_count += stats[i].set_recv_count;
		aggregate_stats.get_resp_count += stats[i].get_resp_count;
		aggregate_stats.hit_misprediction += stats[i].hit_misprediction;
		aggregate_stats.hit_count += stats[i].hit_count;
		aggregate_stats.miss_count += stats[i].miss_count;
		aggregate_stats.update_count += stats[i].update_count;
		aggregate_stats.invalidation_count += stats[i].invalidation_count;
	}

	fprintf(fp, "%lu,%u,%u,%u,%u,%u,%u,%u,%u\n", (unsigned long)time(NULL), aggregate_stats.get_recv_count,
		aggregate_stats.set_recv_count, aggregate_stats.get_resp_count, aggregate_stats.hit_misprediction,
		aggregate_stats.hit_count, aggregate_stats.miss_count, aggregate_stats.update_count, aggregate_stats.invalidation_count);

	free(stats);
	return 0;
}

int dump_cache_to_file(char *filename, int map_fd)
{
	struct memcached_cache_entry entry;
	char data_fmt[MAX_CACHE_DATA_SIZE+1];

	FILE *fp = fopen(CACHE_DUMP_PATH, "w+");
	if (fp == NULL) {
		fprintf(stderr, "Error: failed to open cache dump file '%s'\n", filename);
		return -1;
	}

	fprintf(fp, "{\n");
	fprintf(fp, "  \"cache_entry_count\": %u,\n", CACHE_ENTRY_COUNT);
	fprintf(fp, "  \"max_key_length\": %u,\n", MAX_KEY_LENGTH);
	fprintf(fp, "  \"max_val_length\": %u,\n", MAX_VAL_LENGTH);
	fprintf(fp, "  \"max_additional_payload_bytes\": %u,\n", MAX_ADDITIONAL_PAYLOAD_BYTES);
	fprintf(fp, "  \"max_cache_data_size\": %u,\n", MAX_CACHE_DATA_SIZE);
	fprintf(fp, "  \"max_packet_size\": %u,\n", MAX_PACKET_LENGTH);
	fprintf(fp, "  \"hot_data_limit\": %u,\n", HOT_DATA_LIMIT);
	fprintf(fp, "  \"cache\": [\n");

	memset(&entry, 0, sizeof(struct memcached_cache_entry));

	unsigned int hot_data_in_cache = 0;

	for (int key = 0; key < CACHE_ENTRY_COUNT; key++) {
		assert(bpf_map_lookup_elem(map_fd, &key, &entry) == 0);
		__u32 hotness = 0xFFFFFFFF;
		if (entry.len > 0 && entry.len <= MAX_CACHE_DATA_SIZE) {
			memcpy(data_fmt, entry.data, entry.len);
			data_fmt[entry.len] = '\0';

			if (data_fmt[27] == '\r') {
				data_fmt[27] = ' ';
			}
			if (data_fmt[28] == '\n') {
				data_fmt[28] = ' ';
			}
			if (data_fmt[61] == '\r') {
				data_fmt[61] = ' ';
			}
			if (data_fmt[62] == '\n') {
				data_fmt[62] = ' ';
			}

			hotness = ((__u32)data_fmt[29] << 24) + ((__u32)data_fmt[29+1] << 16) + ((__u32)data_fmt[29+2] << 8) + ((__u32)data_fmt[29+3]);
			if (hotness < HOT_DATA_LIMIT) {
				hot_data_in_cache++;
			}
		} else {
			data_fmt[0] = '\0';
		}

#if DUMP_CACHE_VALUE > 0
		fprintf(fp, "    {\n"
					"      \"valid\": %d,\n"
					"      \"length\": %u,\n"
					"      \"hash\": %u,\n"
					"      \"hotness\": %u,\n"
					"      \"data\": \"%s\"\n"
					"    }\n", entry.valid, entry.len, entry.hash, hotness, data_fmt);
#else
		fprintf(fp, "    {\n"
					"      \"valid\": %d,\n"
					"      \"length\": %u,\n"
					"      \"hash\": %u,\n"
					"      \"hotness\": %u\n"
					"    }\n", entry.valid, entry.len, entry.hash, hotness);
#endif

		if (key < CACHE_ENTRY_COUNT-1) {
			fprintf(fp, "    ,\n");
		}
	}

	fprintf(fp, "  ],\n");
	fprintf(fp, "  \"hot_data_in_cache\": %u\n", hot_data_in_cache);
	fprintf(fp, "}\n");

	fclose(fp);
	return 0;
}

static int print_bpf_verifier(enum libbpf_print_level level,
							const char *format, va_list args)
{
	//if (level == LIBBPF_DEBUG)
	//	return 0;
	return vfprintf(stdout, format, args);
}


int main(int argc, char *argv[])
{
	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
	int map_progs_xdp_fd, xdp_main_prog_fd, map_progs_tc_fd, map_progs_fd, map_stats_fd, map_cache_fd;
	struct bpf_object_load_attr load_attr;
	struct bpf_object *obj;
	char filename[PATH_MAX];
	int err, prog_count;
	__u32 xdp_flags = 0;
	int *interfaces_idx;
	int ret = 0;

	int opt;
	int stats_poll_count = 0, stats_poll_interval = 0;
	int interface_count = 0;
	while ((opt = getopt(argc, argv, "c:i:")) != -1) {
		switch (opt) {
			case 'c':
				stats_poll_count = atoi(optarg);
				break;
			case 'i':
				stats_poll_interval = atoi(optarg);
				break;
			case '?':
			default:
				fprintf(stderr, "Usage: %s [-c stats_count] [-i stats_interval] <interface_idx...>\n", argv[0]);
				fprintf(stderr, "\t\t stats_count: collect X times memcached_bpf stats\n");
				fprintf(stderr, "\t\t stats_interval: collect memcached_bpf stats after X seconds, and every X seconds afterwards\n");
				exit(EXIT_FAILURE);
		}
	}

	if (stats_poll_count < 0) {
		fprintf(stderr, "-c stats_count must be greater than 0 (got %d)\n", stats_poll_count);
		exit(EXIT_FAILURE);
	} else if (stats_poll_interval < 0) {
		fprintf(stderr, "-i stats_interval must be greater than 0 (got %d)\n", stats_poll_interval);
		exit(EXIT_FAILURE);
	} else if (stats_poll_count > 0 && stats_poll_interval == 0) {
		fprintf(stderr, "-c stats_count requires stats_interval (-i) option\n");
		exit(EXIT_FAILURE);
	} else if (stats_poll_interval > 0 && stats_poll_count == 0) {
		fprintf(stderr, "-c stats_interval requires stats_count (-c) option\n");
		exit(EXIT_FAILURE);
	}

	interface_count = argc - optind;
	if (interface_count <= 0) {
		fprintf(stderr, "Missing at least one required interface index\n");
		exit(EXIT_FAILURE);
	}

	interfaces_idx = calloc(sizeof(int), interface_count);
	if (interfaces_idx == NULL) {
		fprintf(stderr, "Error: failed to allocate memory\n");
		return 1;
	}

	for (int i = 0; i < interface_count && optind < argc; optind++, i++) {
		interfaces_idx[i] = atoi(argv[optind]);
	}
	xdp_flags |= XDP_FLAGS_SKB_MODE;
	nr_cpus = libbpf_num_possible_cpus();

	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);

	sigset_t signal_mask;
	sigemptyset(&signal_mask);
	sigaddset(&signal_mask, SIGINT);
	sigaddset(&signal_mask, SIGTERM);
	if (stats_poll_count > 0 && stats_poll_interval > 0)
		sigaddset(&signal_mask, SIGALRM);
	sigaddset(&signal_mask, SIGUSR1);
	sigaddset(&signal_mask, SIGUSR2);

	if (setrlimit(RLIMIT_MEMLOCK, &r)) {
		perror("setrlimit failed");
		return 1;
	}
	libbpf_set_print(print_bpf_verifier);

	obj = bpf_object__open(filename);
	if (!obj) {
		fprintf(stderr, "Error: bpf_object__open failed\n");
		return 1;
	}

	prog_count = sizeof(progs) / sizeof(progs[0]);

	for (int i = 0; i < prog_count; i++) {
		progs[i].prog = bpf_object__find_program_by_title(obj, progs[i].name);
		if (!progs[i].prog) {
			fprintf(stderr, "Error: bpf_object__find_program_by_title failed\n");
			return 1;
		}
		bpf_program__set_type(progs[i].prog, progs[i].type);
	}

	load_attr.obj = obj;
	load_attr.log_level = 4;

	err = bpf_object__load_xattr(&load_attr);
	if (err) {
		fprintf(stderr, "Error: bpf_object__load_xattr failed\n");
		return 1;
	}

	map_progs_xdp_fd = bpf_object__find_map_fd_by_name(obj, "map_progs_xdp");
	if (map_progs_xdp_fd < 0) {
		fprintf(stderr, "Error: bpf_object__find_map_fd_by_name failed\n");
		return 1;
	}

	map_progs_tc_fd = bpf_object__find_map_fd_by_name(obj, "map_progs_tc");
	if (map_progs_tc_fd < 0) {
		fprintf(stderr, "Error: bpf_object__find_map_fd_by_name failed\n");
		return 1;
	}

	for (int i = 0; i < prog_count; i++) {
		int prog_fd = bpf_program__fd(progs[i].prog);

		if (prog_fd < 0) {
			fprintf(stderr, "Error: Couldn't get file descriptor for program %s\n", progs[i].name);
			return 1;
		}

		if (progs[i].map_prog_idx != UNCALLABLE) {
			unsigned int map_prog_idx = progs[i].map_prog_idx;
			if (map_prog_idx < 0) {
				fprintf(stderr, "Error: Cannot get prog fd for bpf program %s\n", progs[i].name);
				return 1;
			}

			switch (progs[i].type) {
			case BPF_PROG_TYPE_XDP:
				map_progs_fd = map_progs_xdp_fd;
				break;
			case BPF_PROG_TYPE_SCHED_CLS:
				map_progs_fd = map_progs_tc_fd;
				break;
			default:
				fprintf(stderr, "Error: Program type doesn't correspond to any prog array map\n");
				return 1;
			}

			err = bpf_map_update_elem(map_progs_fd, &map_prog_idx, &prog_fd, 0);
			if (err) {
				fprintf(stderr, "Error: bpf_map_update_elem failed for prog array map\n");
				return 1;
			}
		}

		if (progs[i].pin) {
			int len = snprintf(filename, PATH_MAX, "%s/%s", BPF_SYSFS_ROOT, progs[i].name);
			if (len < 0) {
				fprintf(stderr, "Error: Program name '%s' is invalid\n", progs[i].name);
				return -1;
			} else if (len >= PATH_MAX) {
				fprintf(stderr, "Error: Program name '%s' is too long\n", progs[i].name);
				return -1;
			}
retry:
			if (bpf_program__pin_instance(progs[i].prog, filename, 0)) {
				fprintf(stderr, "Error: Failed to pin program '%s' to path %s\n", progs[i].name, filename);
				if (errno == EEXIST) {
					fprintf(stdout, "BPF program '%s' already pinned, unpinning it to reload it\n", progs[i].name);
					if (bpf_program__unpin_instance(progs[i].prog, filename, 0)) {
						fprintf(stderr, "Error: Fail to unpin program '%s' at %s\n", progs[i].name, filename);
						return -1;
					}
					goto retry;
				}
				return -1;
			}
		}
	}

	map_stats_fd = bpf_object__find_map_fd_by_name(obj, "map_stats");
	if (map_stats_fd < 0) {
		fprintf(stderr, "Error: bpf_object__find_map_fd_by_name failed\n");
		return 1;
	}

	map_cache_fd = bpf_object__find_map_fd_by_name(obj, "map_kcache");
	if (map_cache_fd < 0) {
		fprintf(stderr, "Error: bpf_object__find_map_fd_by_name failed\n");
		return 1;
	}

	xdp_main_prog_fd = bpf_program__fd(progs[0].prog);
	if (xdp_main_prog_fd < 0) {
		fprintf(stderr, "Error: bpf_program__fd failed\n");
		return 1;
	}

	for (int i = 0; i < interface_count; i++) {
		if (bpf_set_link_xdp_fd(interfaces_idx[i], xdp_main_prog_fd, xdp_flags) < 0) {
			fprintf(stderr, "Error: bpf_set_link_xdp_fd failed for interface %d\n", interfaces_idx[i]);
			return 1;
		} else {
			printf("Main BPF program attached to XDP on interface %d\n", interfaces_idx[i]);
		}
	}


	int sig, cur_poll_count = 0, quit = 0;
	FILE *fp = NULL;

	err = sigprocmask(SIG_BLOCK, &signal_mask, NULL);
	if (err != 0) {
		fprintf(stderr, "Error: Failed to set signal mask\n");
		exit(EXIT_FAILURE);
	}

	if (stats_poll_count > 0 && stats_poll_interval > 0) {
		fp = fopen(STATS_INTERVAL_PATH, "w+");
		if (fp == NULL) {
			fprintf(stderr, "Error: failed to open file '%s'\n", STATS_INTERVAL_PATH);
			return -1;
		}

		alarm(stats_poll_interval);
	}

	while (!quit) {
		err = sigwait(&signal_mask, &sig);
		if (err != 0) {
			fprintf(stderr, "Error: Failed to wait for signal\n");
			exit(EXIT_FAILURE);
		}

		switch (sig) {
			case SIGINT:
			case SIGTERM:
				ret = write_stats_to_file(STATS_PATH, map_stats_fd);
				quit = 1;
				break;

			case SIGALRM:
				ret |= write_stat_line(fp, map_stats_fd);
				if (++cur_poll_count < stats_poll_count) {
					alarm(stats_poll_interval);
				} else {
					ret |= write_stats_to_file(STATS_PATH, map_stats_fd);
					if (fp != NULL) {
						fclose(fp);
					}
					quit = 1;
				}
				break;

			case SIGUSR1:
				ret = write_stats_to_file(STATS_PATH, map_stats_fd);
				quit = ret;
				break;

			case SIGUSR2:
				ret = dump_cache_to_file(CACHE_DUMP_PATH, map_cache_fd);
				quit = ret;
				break;

			default:
				fprintf(stderr, "Unknown signal\n");
				break;
		}
	}

	for (int i = 0; i < interface_count; i++) {
		bpf_set_link_xdp_fd(interfaces_idx[i], -1, xdp_flags);
	}

	return ret;
}
