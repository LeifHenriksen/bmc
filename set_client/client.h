#ifndef CLIENT_H
#define CLIENT_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/sysinfo.h>
#include <pthread.h>

#include "random.h"

#define MC_IP "127.0.0.1"
#define MC_PORT 11211

#define RAND_INIT 42
#define KEY_COUNT 50000
#define ZIPF_SKEW 0.99f
#define KEY_SIZE 16

#define SEND_COUNT 100000

#define TRANSLATE_ID(i) ((i) * KEY_SIZE)

struct thread_wrapper {
    pthread_t t;
    struct zipf_distribution *zipf;
    char **keys;
    uint32_t start;
    uint32_t stop;
};

void *populate_memcd(void *arg);

#endif
