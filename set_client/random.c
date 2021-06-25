#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <stdio.h>

#include "random.h"

static __thread unsigned int _th_seed;

void random_init_seed(unsigned int seed)
{
	_th_seed = seed;
}

int random_weighted_choice(double *weights, double sum_of_weight, unsigned int num_choices)
{
	assert(weights);

	int random_int;
	do {
		random_int = rand_r(&_th_seed);
	} while (random_int == RAND_MAX);
	double rnd = ((double) random_int / (double) RAND_MAX) * sum_of_weight;
	for (size_t i = 0; i < num_choices; i++) {
	 	if (rnd < weights[i])
	 		return i;
	 	rnd -= weights[i];
 	}
 	return 0;
}

void zipf_distribution_init(struct zipf_distribution *zipf, unsigned int n, double skew)
{
	assert(zipf);

	double zetan = 0.0;
	double zeta2theta = 0.0;
	double alpha = 0.0;
	double eta = 0.0;
	double theta = skew;

	for (size_t i = 0; i < n; i++) {
		zetan += 1 / pow(i+1, theta);
	}

	for (int i = 0; i < 2; i++) {
		zeta2theta += 1 / pow(i+1, theta);
	}

	alpha = 1.0 / (1.0 - theta);
	eta = (1 - pow(2.0 / n, 1 - theta)) / (1 - zeta2theta / zetan);

	zipf->item_count = n;
	zipf->alpha = alpha;
	zipf->zetan = zetan;
	zipf->eta = eta;
	zipf->theta = theta;
}

unsigned int zipf_distribution_next(struct zipf_distribution *zipf)
{
	assert(zipf);

	double u = (double) (rand_r(&_th_seed) % RAND_MAX) / ((double) RAND_MAX);
	double uz = u * zipf->zetan;

	if (uz < 1.0) {
		return 0;
	}
	if (uz < 1.0 + pow(0.5, zipf->theta)) {
		return 1;
	}

	return (unsigned int)(zipf->item_count * pow(zipf->eta*u - zipf->eta + 1, zipf->alpha));
}

void memcached_gen_key(char *buffer, size_t key_length, unsigned int key_num)
{
	char padding = 0;
	unsigned int written = 0;

	written = snprintf(buffer, key_length+1, "%u", key_num);
	while (written < key_length) {
		buffer[written] = 'A' + (padding % 58);
		padding++;
		written++;
	}
}