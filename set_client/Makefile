CC=gcc
CFLAGS= -Wall -O3 -g -pedantic -Wextra
LIBS= -lm -lpthread
OUT=populate

all: client.o random.o
	$(CC) -o $(OUT) $(CFLAGS) main.c client.o random.o $(LIBS)

# main.o: client.o random.omain.c
# 	$(CC) -o main.o $(CFLAGS) client.o random.o $(LIBS)

random.o: random.c random.h
	$(CC) -o random.o $(CFLAGS) -c random.c

client.o: client.c client.h
	$(CC) -o client.o $(CFLAGS) -c client.c

clean:
	rm -f client *.o
