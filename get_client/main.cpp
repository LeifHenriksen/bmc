#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <unordered_map>
#include <algorithm>
#include <vector>
#include "random.h"
#include "client.h"
#include "hash.h"

#define RAND_INIT 42
#define ZIPF_SKEW .99
#define KEY_SIZE 16
#define KGRN  "\x1B[32m"
#define KNRM  "\x1B[37m"

void progress_bar(size_t prog, size_t end)
{
	static unsigned char alive = 0;
	static char bars[] = {'|','/','-','\\'};
	int percent = (prog * 100) / end;
	printf("\r[" KGRN);
	for(int i = 0; i < 70; i++) {
		if(i < ((percent * 70) / 100) + 1) 
			printf("#");
		else
			printf(" ");
	}
	printf(KNRM "] %i%% %c", percent + 1, bars[alive % sizeof(bars)]);
	fflush(stdout);
	alive++;
}

int test_collisions(size_t KEY_COUNT)
{
	size_t HOT = (5 * KEY_COUNT) / 100;
	char curr_key[KEY_SIZE + 1];
	unsigned int hash;
	const size_t CACHE_SIZE = 3250000;
	unsigned int *cache = new unsigned int[CACHE_SIZE];
	size_t taken = 0;

	memset(cache, 0, HOT);

	for(size_t i = 0; i < HOT; i++) {
		memcached_gen_key(curr_key, KEY_SIZE, i);
		hash = get_hash(curr_key);
		cache[hash % CACHE_SIZE]++;
	}

	for(size_t i = 0; i < CACHE_SIZE; i++) {
		if(cache[i] > 0) taken++;
	}
	
	printf("HOT = %li, taken = %li, collisions = %li, last_key = %.16s\n", 
			HOT, taken, HOT - taken, curr_key);

	delete[] cache;
	return 0;
}

int main(int argc, char **argv)
{
	if(argc < 6)
	{
		printf("Error in arguments : Usage ./get_client IP PORT GET_COUNT KEY_COUNT START_KEY\n");
		exit(0);
	}

	Client c(argv[1], atoi(argv[2]));
	size_t GET_COUNT = atoi(argv[3]);	
	size_t KEY_COUNT = atoi(argv[4]);
	size_t START_KEY = atoi(argv[5]);
	struct zipf_distribution zipf;

	srand(RAND_INIT);

	printf("get_client : GET_COUNT = %li, KEY_COUNT = %li\n", GET_COUNT, KEY_COUNT);
	printf("Zipf init...\n");
	random_init_seed(RAND_INIT);
	zipf_distribution_init(&zipf, KEY_COUNT, 0.99f);

	printf("Sending requests...\n");

	for(size_t i = 0; i < START_KEY; ++i) {
		zipf_distribution_next(&zipf);
	}

	for(size_t i = 0; i < GET_COUNT; ++i) {
		unsigned int id = zipf_distribution_next(&zipf);
		char curr_key[KEY_SIZE + 1];
		memcached_gen_key(curr_key, KEY_SIZE, id);
		c.get(std::string(curr_key, KEY_SIZE));
		if(!(i % 50000))
			progress_bar(i, GET_COUNT);
	}

	//test_collisions(KEY_COUNT);

	return 0;
}
