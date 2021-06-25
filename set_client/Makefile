CC=gcc
CFLAGS= -Wall -O3 -g -pedantic -Wextra
LIBS= -lm -lpthread
OUT=populate

all: client.o
	$(CC) -o $(OUT) $(CFLAGS) main.c client.o $(LIBS)

client.o: client.c client.h
	$(CC) -o client.o $(CFLAGS) -c client.c

clean:
	rm -f $(OUT) *.o
