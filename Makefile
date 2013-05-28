CC=gcc
LEX=flex

CFLAGS= -std=gnu99 -Wall -Wextra -pedantic -O3 -lfl

all: dumb

dumb: dumb.o dumb.l 
	$(CC) $(CFLAGS) dumb.o -o dumb

clean:
	rm -f *.o dumb 
