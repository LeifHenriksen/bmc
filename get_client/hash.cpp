#include "hash.h"
#include <stdlib.h>
#include <stdio.h>
#include <unordered_map>

#define FNV_OFFSET_BASIS_32             2166136261
#define FNV_PRIME_32                    16777619
#define FNV_PRIME_2_32                  83227
#define MAX_KEY_SIZE 16

unsigned int get_hash(const char *key)
{
  unsigned int hash = FNV_OFFSET_BASIS_32;
  for(unsigned int i = 0; i < MAX_KEY_SIZE; i++)
    {
      hash ^= key[i];
      hash *= FNV_PRIME_32;
    }
  return hash;
}

unsigned int get_hash2(const char *key)
{
  unsigned int hash = FNV_OFFSET_BASIS_32;
  for(unsigned int i = 0; i < MAX_KEY_SIZE; i++)
    {
      hash ^= key[i];
      hash *= FNV_PRIME_2_32;
    }
  return hash;
}

#include "random.h"
#define RAND_INIT 42
//#define KEY_COUNT 60000000
#define KEY_COUNT   10000000
#define ZIPF_SKEW .99
#define KEY_SIZE 16

void test()
{
  struct zipf_distribution zipf;
  char *keys;

  srand(RAND_INIT);

  printf("Zipf init...\n");
  random_init_seed(RAND_INIT);
  zipf_distribution_init(&zipf, KEY_COUNT, 0.99f);

  printf("Generating keys...\n");
  keys = generate_strings(KEY_COUNT, KEY_SIZE);

  printf("hash  = %u, %u\n",  get_hash("macallums0123456"),  get_hash("declinate0123456"));
  printf("hash2 = %u, %u\n", get_hash2("macallums0123456"), get_hash2("declinate0123456"));
  
  unsigned int hash  = FNV_OFFSET_BASIS_32;
  unsigned int hash2 = FNV_OFFSET_BASIS_32;
  std::unordered_map<unsigned int, int> collisions;
  std::unordered_map<unsigned int, int> collisions2;
  printf("Calculating hashs...\n");
  for(size_t i = 0; i < KEY_COUNT; ++i)
    {
      unsigned int id = zipf_distribution_next(&zipf);
      char *curr_key = &keys[id * KEY_SIZE];
      hash = get_hash(curr_key);
      hash2 = get_hash2(curr_key);
      collisions[hash]++;
      collisions2[hash2]++;
    }

  unsigned int collision_count_hash = 0;
  for(const auto& h : collisions)
    {
      collision_count_hash += h.second - 1;
    }

  unsigned int collision_count_hash2 = 0;
  for(const auto& h : collisions2)
    {
      collision_count_hash2 += h.second - 1;
    }

  printf("Collisions with hash = %u, collisions with hash2 = %u\n", collision_count_hash, collision_count_hash2);
}
