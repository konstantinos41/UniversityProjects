/*
  client.c

  Author: <Konstantinos Mavrodis>
  Contact: <mavrkons@auth.gr>
*/

#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>

int main()
{
    printf("Client: I am running.\n");

    if (fork() == 0) 
        main2();

    int fd;
    char * namedPipe = "/tmp/namedPipe";

    mkfifo(namedPipe, 0666);

    fd = open(namedPipe, O_WRONLY);

    char greeting[] = "Hello from Client";
    write(fd, greeting, sizeof(greeting));
    close(fd);

    unlink(namedPipe);

    return 0;
}
