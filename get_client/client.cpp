#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include "random.h"
#include "client.h"

#define KEY_SIZE 16
#define MAXLINE (2 << 16)

Client::Client(const char ip[], int port)
{
  // Creating socket file descriptor
  if ( (sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0 ) {
    perror("socket creation failed");
    exit(EXIT_FAILURE);
  }
  
  memset(&servaddr, 0, sizeof(servaddr));
  
  // Filling server information
  servaddr.sin_family = AF_INET;
  servaddr.sin_port = htons(port);
  inet_pton(AF_INET, ip, &(servaddr.sin_addr));   
}

Client::~Client()
{
  close(sockfd);
}

void Client::get(const std::string &key)
{
  int n;
  socklen_t len;
  char buffer[MAXLINE];
  int buff_cursor = 0;
  char head[] = "\x00\x00\x00\x00\x00\x01\x00\x00get ";  
  char tail[] = "\r\n";
  char msg[(sizeof(head) - 1) + (sizeof(tail) - 1) + KEY_SIZE];

  memcpy(msg                                , head       , sizeof(head) - 1);
  memcpy(&msg[sizeof(head) - 1]             , key.c_str(), key.size());
  memcpy(&msg[sizeof(head) - 1 + key.size()], tail       , sizeof(tail) - 1);

  n = sendto(sockfd, (const char *)msg, sizeof(msg), MSG_CONFIRM,
	     (const struct sockaddr *) &servaddr, sizeof(servaddr));

  if(n == -1) {
    perror("Error sendoto : ");
    exit(EXIT_FAILURE);
  }
  
  n = recvfrom(sockfd, (char *)buffer, MAXLINE, MSG_WAITALL, (struct sockaddr *) &servaddr, &len);

  if(n == -1) {
    perror("Error recvfrom : ");
    exit(EXIT_FAILURE);
  }
  
  buff_cursor = 8;
  
  if(strncmp("VALUE", &buffer[buff_cursor], 5) == 0)
    return;
  else if(strncmp("END", &buffer[buff_cursor], 3) == 0)
    printf("Key %s not found\n", key.c_str());
  else if(strncmp("ERROR", &buffer[buff_cursor], 5) == 0)
    printf("Error in get request %s\n", key.c_str());
  else
    printf("Unknown response from server %.15s\n", &buffer[buff_cursor]);
}

