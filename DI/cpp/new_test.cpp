
//v0.01
//Author: ZhangYet
//
#include <iostream>
#include <fstream>
#include <string>
#include "armadillo"
using namespace std;
using namespace arma;

#include "identify.h"

mat makeMatrix(ifstream &fin, int m, int n)
{
  if(!fin){
    cerr<<"error:unable to open inputfile"<<endl;
    return mat();
  }
  mat A = zeros<mat>(m,n);
  string line;
  int id = 0;
  while(getline(fin, line)){
    A.row(id)=mat(line);
    id++;
  }
  return A;
}

mat makeNetwork(mat &data, double alpha)
{
  mat net = cor(data);
  uvec indices_0 = find(net<alpha);
  uvec indices_1 = find(net>=alpha);
  net.elem(indices_0) = zeros<vec>(indices_0.n_elem);
  net.elem(indices_1) = ones<vec>(indices_1.n_elem);
  return net;
}


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
