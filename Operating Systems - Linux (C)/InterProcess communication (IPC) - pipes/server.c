/*
  server.c

  Author: <Konstantinos Mavrodis>
  Contact: <mavrkons@auth.gr>
*/


#include <fcntl.h>
#include <sys/stat.h>
#include <stdio.h>


#define SIZE_OF_BUFFER 100

int main2()
{
  printf("Server: I am running.\n");

  int fd;  
  char * namedPipe = "/tmp/namedPipe";  
  char buffer[SIZE_OF_BUFFER];


  fd = open(namedPipe, O_RDONLY);

  read(fd, buffer, SIZE_OF_BUFFER);  
  printf("Server: %s\n", buffer);

  close(fd);

  return 0;
}