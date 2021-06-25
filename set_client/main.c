#include "client.h"


int main()
{
    printf("Populating memcached server at %s:%d\n", MC_IP, MC_PORT);
    printf("===============================================\n");
    printf("Key count : %u\n", KEY_COUNT);
    printf("Key size  : %u\n", KEY_SIZE);
    printf("Zipf skew :%f\n", ZIPF_SKEW);
    printf("===============================================\n");
    send_set();
}