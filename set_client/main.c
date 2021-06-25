#include <stdlib.h>
#include "client.h"

unsigned long key_count = KEY_COUNT;

int main(int argc, char **argv)
{
    if(argc != 2){
        printf("Usage : %s key_count\n", argv[0]);
        exit(-1);

    } else if(argc == 2) {
        char *end_ptr;
        key_count = strtoul(argv[1], &end_ptr, 10);

        if(strlen(end_ptr) > 0 || key_count == 0) {
            printf("Wrong key count format, unsigned long expected.\n");
            exit(-1);
        }
    }
    printf("Populating memcached server at %s:%d\n", MC_IP, MC_PORT);
    printf("===============================================\n");
    printf("Key count : %lu\n", key_count);
    printf("Key size  : %u\n", KEY_SIZE);
    printf("Zipf skew : %f\n", ZIPF_SKEW);
    printf("===============================================\n");

    

    srand(RAND_INIT);
    send_set();
}
