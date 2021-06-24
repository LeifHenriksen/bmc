CC=gcc
CFLAGS= -Wall -O3 -g -pedantic -Wextra
LIBS= -lm -lpthread


client: client.o random.o
	$(CC) -o client $(CFLAGS) client.o random.o $(LIBS)

random.o: random.c random.h
	$(CC) -o random.o $(CFLAGS) -c random.c

client.o: client.c client.h
	$(CC) -o client.o $(CFLAGS) -c client.c

clean:
	rm -f client *.o
