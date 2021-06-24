#ifndef RANDOM_H
#define RANDOM_H

struct zipf_distribution {
	unsigned int item_count;
	double alpha, zetan, eta, theta;
};

void random_init_seed(unsigned int seed);
int random_weighted_choice(double *weights, double sum_of_weight, unsigned int num_choices);

void zipf_distribution_init(struct zipf_distribution *zipf, unsigned int n, double skew);
unsigned int zipf_distribution_next(struct zipf_distribution *zipf);

char *generate_strings(size_t count, size_t str_length);
#endif
