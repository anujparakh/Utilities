#include <iostream>
#include <fstream>

using namespace std;

int main ()
{
    const int numberOfQuotes = 84;
    // seed the rand
    srand (time (NULL));
    // get the random number of quote
    int randomNo = rand() % numberOfQuotes + 1;
    //open a file for the command
    ofstream outfile;
    outfile.open ("/Users/Anuj/Commands/shower");
    outfile << "echo \"Showing Quote Number : " << randomNo << "\" ; cat /Users/Anuj/Documents/Quotes/" << randomNo << endl;
    outfile.close();
}
    
