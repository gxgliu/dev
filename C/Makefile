CC = gcc
CFLAGS = -g

all: gets echo2

gets: gets.o
	$(CC) -o $@ gets.c

echo2: echo2.o
	$(CC) -o $@ echo2.c

clean:
	/bin/rm *.o gets echo2
