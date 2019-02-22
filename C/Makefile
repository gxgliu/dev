CC = gcc
CFLAGS = -g -O3

all: gets echo2 prime

gets: gets.o
	$(CC) -o $@ gets.c

echo2: echo2.o
	$(CC) -o $@ echo2.c

prime: prime.o
	$(CC) -o $@ prime.c

clean:
	/bin/rm -f *.o gets echo2 prime
