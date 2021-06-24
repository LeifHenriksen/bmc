#ifndef CLIENT_H
#define CLIENT_H

#include <sys/socket.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string>

struct Client
{
  int sockfd;
  struct sockaddr_in servaddr;
  Client(const char ip[], int port);
  ~Client();
  void get(const std::string &key);
};

#endif
