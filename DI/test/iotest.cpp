#include <iostream>
#include <fstream>
#include <string>
#include "armadillo"

using namespace arma;
using namespace std;

int main(int argc, char** argv)
{
  ifstream fin(argv[1],ios::in);
  if(!fin){
    cerr<<"error:unable to open inputfile:"<< argv[1]<<endl;
    return -1;
  }
  
  mat A = zeros<mat>(200,161);
  string line;
  int id = 1;
  mat::row_iterator a = A.begin_row(1);
  while(getline(fin,line)){
    A.row(id) =  mat(line);
    id++;
  }
  A.print();
  fin.close();
  return 0;
}
