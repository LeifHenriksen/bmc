#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "random.h"
#include "client.h"

#define RAND_INIT 42
#define ZIPF_SKEW .99
#define KEY_SIZE 16

int main(int argc, char **argv)
{
  if(argc < 5)
    {
      printf("Error in arguments : Usage ./get_client IP PORT GET_COUNT KEY_COUNT\n");
      exit(0);
    }

  Client c(argv[1], atoi(argv[2]));
  size_t GET_COUNT = atoi(argv[3]);	
  size_t KEY_COUNT = atoi(argv[4]); 
  struct zipf_distribution zipf;

  srand(RAND_INIT);

  printf("get_client : GET_COUNT = %li, KEY_COUNT = %li\n", GET_COUNT, KEY_COUNT);
  printf("Zipf init...\n");
  random_init_seed(RAND_INIT);
  zipf_distribution_init(&zipf, KEY_COUNT, 0.99f);

  printf("Sending requests...\n");
  for(size_t i = 0; i < GET_COUNT; ++i)
    {
      unsigned int id = zipf_distribution_next(&zipf);
      char curr_key[KEY_SIZE + 1];
      memcached_gen_key(curr_key, KEY_SIZE, id);
      //printf("id = %u, i = %li, GET key %.16s\n", id, i, curr_key);
      c.get(std::string(curr_key, KEY_SIZE));
    }
  
  return 0;
}
