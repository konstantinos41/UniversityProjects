all: client.o server.o
	gcc -o all client.o server.o

client: client.c
	gcc -o client client.c

server: server.c
	gcc -o server server.c

clean:
	rm client.o server.o all