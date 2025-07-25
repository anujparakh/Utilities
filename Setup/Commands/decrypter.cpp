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
    ifstream infile;
    infile.open ("/Users/Anuj/Desktop/encryptedQuote");
    
    
    for (int i(0); i < 21; ++i)
    {
        srand (i);
        ofstream outfile;
        string outfilename = "/Users/Anuj/Desktop/quote";
        outfilename += to_string (i);
        outfile.open (outfilename.c_str());
        while (true)
        {
            char const c = (infile.get());
            if (infile.eof())
            {
                break;
            }
            
            outfile << char(c ^ pseudo_rand_char());
        }
        cout << "File " << i << " done " << endl;
    }
    
        cout << "Finished" << endl;
}

