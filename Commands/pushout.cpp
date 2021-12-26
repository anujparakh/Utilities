#include <iostream>
#include <ctime>
#include <fstream>

using namespace std;

int main()
{
  time_t currentTime;
  struct tm *localTime;

  ofstream f ("/Users/anujparakh/log.csv", ios::app);
  
  time( &currentTime );                   // Get the current time
  localTime = localtime( &currentTime );  // Convert the current time to the local time

  int Day    = localTime->tm_mday;
  int Month  = localTime->tm_mon + 1;
  int Year   = localTime->tm_year + 1900;
  int Hour   = localTime->tm_hour;
  int Min    = localTime->tm_min;
  int Sec    = localTime->tm_sec;

  f  << Hour << ":" << Min << ":" << Sec << std::endl;

  f.close ();
  
  return 0;
}
 
