#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "random.h"
#include "client.h"

#define RAND_INIT 42
#define KEY_COUNT 50000
#define ZIPF_SKEW .99
#define KEY_SIZE 16

int main(int argc, char **argv)
{
  if(argc < 3)
    {
      printf("Error in arguments : Usage ./get_client IP PORT\n");
      exit(0);
    }
  
  Client c(argv[1], atoi(argv[2]));
  struct zipf_distribution zipf;
  char *keys;

  srand(RAND_INIT);

  printf("Zipf init...\n");
  random_init_seed(RAND_INIT);
  zipf_distribution_init(&zipf, KEY_COUNT, 0.99f);

  printf("Generating keys...\n");
  keys = generate_strings(KEY_COUNT, KEY_SIZE);

  printf("Sending requests...\n");
  for(size_t i = 0; i < KEY_COUNT; ++i)
    {
      unsigned int id = zipf_distribution_next(&zipf);
      char *curr_key = &keys[id * KEY_SIZE];
      c.get(std::string(curr_key, KEY_SIZE));
    }
  
  return 0;
}
