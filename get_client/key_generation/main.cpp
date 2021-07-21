#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <unordered_map>
#include <algorithm>
#include <vector>
#include "random.h"
#include <errno.h>

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
#define _CONCAT(x,y) x#y
#define CONCAT(x,y) _CONCAT(x,y)

int main(int argc, char **argv)
{
	if(argc < 5)
	{
		printf("Error in arguments : Usage ./test GET_COUNT KEY_COUNT START_KEY FILE_NAME\n");
		exit(0);
	}

	size_t GET_COUNT = atoi(argv[1]);	
	size_t KEY_COUNT = atoi(argv[2]);
	size_t START_KEY = atoi(argv[3]);
	char * FILE_NAME = argv[4];
	struct zipf_distribution zipf;

	srand(RAND_INIT);

	printf("test : GET_COUNT = %li, KEY_COUNT = %li, START_KEY = %li\n", GET_COUNT, KEY_COUNT, START_KEY);
	printf("Zipf init...\n");
	random_init_seed(RAND_INIT);
	zipf_distribution_init(&zipf, KEY_COUNT, 0.99f);

	FILE *output_file = fopen(FILE_NAME, "w");
	if(output_file == NULL) {
		perror("Error : output_file");
		return 0;
	}
	//fprintf(output_file, "[");

	for(size_t i = 0; i < START_KEY; ++i) {
		zipf_distribution_next(&zipf);
	}

	for(size_t i = 0; i < GET_COUNT; ++i) {
		unsigned int id = zipf_distribution_next(&zipf);
		char curr_key[KEY_SIZE + 1];
		memcached_gen_key(curr_key, KEY_SIZE, id);
		//fprintf(output_file, CONCAT("\"%.", KEY_SIZE)"s\",", curr_key);
		fprintf(output_file, CONCAT("%.", KEY_SIZE)"s\n", curr_key);
		if(!(i % 50000))
			progress_bar(i, GET_COUNT);
	}
/*	
	unsigned int id = zipf_distribution_next(&zipf);
	char curr_key[KEY_SIZE + 1];
	memcached_gen_key(curr_key, KEY_SIZE, id);
	fprintf(output_file, CONCAT("\"%.", KEY_SIZE)"s\"", curr_key);
	fprintf(output_file, "]");
*/
	printf("\n");
	fclose(output_file);	
	return 0;
}
