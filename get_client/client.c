#include "client.h"

int main(int argc, char **argv)
{
    int nproc, ret, thread_count, delta;
    struct zipf_distribution zipf;
    char *keys;
    struct thread_wrapper *threads;

    nproc = get_nprocs();
    threads = (struct thread_wrapper *) malloc(sizeof(struct thread_wrapper) * nproc);
    
    srand(RAND_INIT);

    printf("Zipf init...\n");
    random_init_seed(RAND_INIT);
    zipf_distribution_init(&zipf, KEY_COUNT, 0.99f);

    printf("Generating keys...\n");
    keys = generate_strings(KEY_COUNT, KEY_SIZE);

    nproc = 2;
    delta = (float)KEY_COUNT / nproc;
    thread_count = 0;
    
    /*
    threads[0].start = 0;
    threads[0].stop = KEY_COUNT;
    threads[0].keys = &keys;
    threads[0].zipf = &zipf;
    populate_memcd((void*)threads);
    */
    for(size_t i = 0; i < nproc; ++i) {
        threads[i].keys = &keys;
        threads[i].zipf = &zipf;
        threads[i].start = i * delta;
        threads[i].stop = threads[i].start + delta;
        
        ret = pthread_create(&threads[i].t, NULL, populate_memcd, (void *) &threads[i]);
        if(ret != 0) {
            perror("pthread_create");
            threads[i].stop = KEY_COUNT;

            // If we can't create any other thread, remaining range will be handled by the main one.
            if(i == 0) threads[i].start = 0;
            populate_memcd((void *) &threads[i]);
            break;
        }
        thread_count++;
    }
    printf("%d threads started\n", nproc);
    for(size_t i = 0; i < thread_count; ++i) {
        pthread_join(threads[i].t, NULL);
    }

    send_set_requests(&keys, &zipf);
    free(keys);
}

void *populate_memcd(void *arg)
{
    struct thread_wrapper *cfg = (struct thread_wrapper *) arg;
    int sfd, ret, chr_printed;   
    struct sockaddr_in addr = {0};
    char *keys;
    char buffer[64] = {0};

    keys = (char*) *(cfg->keys);
    printf("Connecting to memcached server...\n");
    if((sfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }
    
    addr.sin_family = AF_INET;
    addr.sin_port = htons(MC_PORT);

    if(inet_pton(AF_INET, MC_IP, &addr.sin_addr) < 0) {
        fprintf(stderr, "Error while converting IP: %s", MC_IP);
    }

    if(connect(sfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        fprintf(stderr, "Error while connecting to %s:%u failed.\n", MC_IP, MC_PORT);
    }

    for(size_t i = cfg->start; i < cfg->stop - 1; ++i) {
        // unsigned int id = zipf_distribution_next(cfg->zipf);
        char *curr_key = &keys[i * KEY_SIZE];
        
        chr_printed = sprintf(buffer, "set %.16s 0 0 32\r\n%.32s\r\n", curr_key, curr_key);
        if((ret = send(sfd, buffer, chr_printed, 0)) == -1) {
            perror("send");
        }
        ret = recv(sfd, buffer, 64, 0);
        if(!strncmp(buffer, "ERROR", 5)) {
            fprintf(stderr, "Error while sending key : %.16s with value %.32s\n.\n Request rank : %lu.\n", curr_key, curr_key, i);
        }
    }
    close(sfd);
    printf("Thread range : %u-%u. Donen", cfg->start, cfg->stop);
    return NULL;
}

void send_set_requests(char **keys, struct zipf_distribution *zipf)
{
    int sfd, ret;
    unsigned int id;
    struct sockaddr_in addr = {0};
    socklen_t sock_len;
    char buffer[1024];
    char *key;
    uint16_t chr_printed;

    if((sfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("socket");
        return;
    }

    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_port = htons(MC_PORT);
    
    if(inet_pton(AF_INET, MC_IP, &(addr.sin_addr)) < 0) {
        fprintf(stderr, "Error while converting IP %s", MC_IP);
        return;
    }

    printf("Sending requests...\n");
    for(size_t i = 0; i < SEND_COUNT; ++i) {
        id = zipf_distribution_next(zipf);
        key = &(*keys)[TRANSLATE_ID(id)];
        printf("key : %.16s\n", key);
        chr_printed = sprintf(buffer, "get %.16s\r\n", key);
        buffer[chr_printed] = '\0';
        printf("buf:%s\n", buffer);
        if(sendto(sfd, (const char*) buffer, chr_printed, MSG_CONFIRM, (const struct sockaddr *) &addr, sizeof(addr)) == -1) {
            perror("sendto");
            return;
        }
        
        if((ret = recvfrom(sfd, (char *) buffer, 1024 - 8, MSG_WAITALL, (struct sockaddr *) &addr, &sock_len)) == -1) {
            perror("recvfrom");
            return;
        }

        if(strncmp(buffer, "END", 3) == 0) {
            printf("Miss :)\n");
        }
        printf("\r%lu", i);
    }

}
