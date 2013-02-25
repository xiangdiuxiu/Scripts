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
  /*
  getline(fin,str);
  mat A(str);
  while(getline(fin,str))
    {
      istr.str(str);
      mat B(str);
      A = join_cols(A,B);
      //B.print("B:");
      //cout<<B.n_elem;
    }
  */
  mat A = zeros<mat>(17000,160);
  for (int i = 1 ; i < 10000; i++){
    getline(fin,str);
    mat B(str);
    A.row(i) = B;
  }
  cout<<A.n_rows<<endl;
  mat C = cov(A.t());
  cout<<C.n_rows<<endl;
  return 0;
}
