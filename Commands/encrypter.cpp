#include <iostream>
#include <string>
#include <fstream>

using namespace std;

char pseudo_rand_char()
{
  return char(rand() % 256);
}


int main ()
{
    srand (13);
    ifstream infile;
    infile.open ("/Users/Anuj/Desktop/testQuote");
    
    ofstream outfile;
    outfile.open ("/Users/Anuj/Desktop/encryptedQuote");
    
    while (true)
    {
          char const c = (infile.get());
          if (infile.eof())
          {
              break;
          }

          outfile << char(c ^ pseudo_rand_char());
    }
    
    cout << "Finished" << endl;
}

