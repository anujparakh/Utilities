#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main ()
{
    for (int i (0); i < 11; ++i)
    {
        ofstream outStream;
        string name = "/Users/Anuj/Commands/v" ;
        name += to_string( i );
        outStream.open (name.c_str());
        outStream << "osascript -e \"set volume " << i << "\"";
        outStream.close ();
    }
}
