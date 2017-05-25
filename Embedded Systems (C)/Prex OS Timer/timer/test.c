// Mavrodis Konstantinos 7922


#include <sys/prex.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/types.h>
#include <errno.h>
#include <sys/time.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <unistd.h>


int minutes, hours, seconds, stopwatch_minutes, stopwatch_seconds, 
  stopwatch_hours, stopwatch_dseconds;
int hoursMargin, minutesMargin, secondsMargin;
int stopwatch_running, pause_;
u_long time_now, stopwatch_counter, start_time, end_time;
  
u_long get_time() 
{
  device_t rtc_dev;
	u_long sec;

	device_open("rtc", 0, &rtc_dev);
  	device_ioctl(rtc_dev, RTCIOC_GET_TIME, &sec);
	device_close(rtc_dev);
	return sec;
}

struct __timeval get_timeWithuSecs() {
    device_t rtc_dev;
    struct __timeval tm;
  
    device_open("rtc", 0, &rtc_dev);
    device_ioctl(rtc_dev, RTCIOC_GET_TIME, &tm);
    device_close(rtc_dev);
  
    return tm;
}


int show_clock()
{
	time_now = get_time() + secondsMargin +minutesMargin*60 +
	  hoursMargin*3600;
  seconds = (int)time_now%60;
	minutes = (int)(time_now/60)%60;
	hours = (int)(time_now/3600)%24;
	printf("%02d:%02d:%02d   \r", hours, minutes, seconds);

  return 1;
}

int show_stopwatch()
{
  if (stopwatch_running && !pause_)
  {
    u_long timer = get_time()-start_time+stopwatch_counter;
    stopwatch_seconds = (int)(timer)%60;
	  stopwatch_minutes = (int)(timer/60)%60;
	  stopwatch_hours = (int)(timer/3600)%24;
	  stopwatch_dseconds = (int)(get_timeWithuSecs().tv_usec/10000);
	}
	
	printf("%02d:%02d:%02d.%02d\r", stopwatch_hours, stopwatch_minutes,
	  stopwatch_seconds, stopwatch_dseconds);
  return 1;
}

int tcsetattr(int fd, int opt, const struct termios *t)
{
	struct termios localterm;
	device_t dev;
	 	
	if (opt & TCSASOFT) 
	{
		localterm = *t;
		localterm.c_cflag |= CIGNORE;
		t = &localterm;
	}
	
	int temp;
	switch (opt & ~TCSASOFT) 
	{
	case TCSANOW:
			device_open("tty", 2, &dev);
			temp = device_ioctl( dev, TIOCSETA, t);
			device_close(dev);
			return  temp;			
			break;
					
	case TCSADRAIN:
			device_open("tty", 2, &dev);
			temp = device_ioctl( dev, TIOCSETAW, t);
			device_close(dev);
			return  temp;				
			break;
				
	case TCSAFLUSH:
			device_open("tty", 2, &dev);
			temp = device_ioctl( dev, TIOCSETAF, t);
			device_close(dev);
			return  temp;	
			break;
				
	default:
		errno = EINVAL;
		return (-1);
	}
}
 
int tcgetattr(int fd, struct termios *t)
{
  device_t dev;  
  device_open("tty", 2, &dev);
  
  int temp;
  temp = device_ioctl( dev, TIOCGETA, t);
  
  device_close(dev);  
  return  temp;
}



int main(void)
{
  int clock_flag = 1;
  stopwatch_running = pause_ = 0;
  
  hoursMargin = 0;
  minutesMargin = 0;
  secondsMargin = 0;
  
  stopwatch_minutes=stopwatch_hours=stopwatch_seconds = 0;
  
  device_t dev;
  char c;
  int device_out;

  static struct termios oldt, newt;
  tcgetattr(STDIN_FILENO,&oldt);
  newt=oldt;
  newt.c_lflag &= ~( ICANON | ECHO );
  tcsetattr(STDIN_FILENO,TCSANOW,&newt);
    
    
  while(1)
  {
    device_open( "tty", 0, &dev );
    device_ioctl( dev, TIOCINQ, &device_out);
    device_close( dev);
    
      if( device_out > 0 )
      {
        c = getchar();
        
        if( c == 'r' )
        { if (!clock_flag)
          {
            stopwatch_counter = 0;
            if (stopwatch_running)
              start_time = get_time();
            else
              start_time = stopwatch_minutes = stopwatch_hours = 
                stopwatch_seconds = stopwatch_dseconds = 0;
            pause_ = 0;
          }
        }
        if( c == 's' )
        { if (!clock_flag)
            stopwatch_running = !stopwatch_running;
            if(stopwatch_running)
            {
              start_time = get_time();                          
            }
            else
            {
              stopwatch_counter += get_time() - start_time;
            }            
        }
        if( c == 'p' )
        { if (!clock_flag)
            
            if(stopwatch_running)
            {
              pause_ = !pause_;                          
            }
            else
            {
              pause_ = 0;
            }            
        }
        if( c == 't' )
        { 
          clock_flag = !clock_flag;
        }
        if( c == 'h' )
        { 
          if (clock_flag)
            hoursMargin++;
        }
        if( c == 'm' )
        { 
          if (clock_flag)
            minutesMargin++;
        }
        if( c == 'z' )
        { 
          if (clock_flag)
            secondsMargin = - (int)get_time()%60;
        }
      }
      
      if (clock_flag)
      {
        show_clock();
      }
      if(!clock_flag)
      {
        show_stopwatch();
      }
      timer_sleep(10,0);
  }
}
 

