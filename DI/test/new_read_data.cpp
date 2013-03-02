#include <iostream>
#include <fstream>
#include <string>
#include "armadillo"

using namespace arma;
using namespace std;

int main(int argc, char** argv)
{
  ifstream fin;
  fin.open(argv[1], ios::in);

  std::istringstream istr;
  string str;
  double tmp;

  mat A = zeros<mat>(17000,160);
  for (int i = 1 ; i < 10000; i++){
    getline(fin,str);
    mat B(str);
    A.row(i) = B;
  }
  cout<<A.n_rows<<endl;
  A = A.t();
  for (int i = 0 ; i < 100 ; i++)
    cout<<A.row(i)<<endl;
  
  return 0;
}
