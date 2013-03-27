#include <iostream>
#include <fstream>
#include <string>
#include "armadillo"
#include "identify.h"

using namespace std;
using namespace arma;

extern mat makeNetwork(mat &,double);

int main(int argc, char** argv)
{
  ifstream fin(argv[1], ios::in);
  if(!fin){
    cerr<<"error: unable to open inputfile: "<< argv[1]<<endl;
    return -1;
  }
  //m,n are nrow and ncol of the matrix we make
  int m = 100; 
  int n = 160;
  
  mat matData = makeMatrix(fin, m, n);
  mat matNetwork = makeNetwork(matData, 0.75);
  matNetwork.print();
  fin.close();
  return 0;
}
