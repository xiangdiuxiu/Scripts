#include <iostream>
#include <fstream>
#include <string>
#include <set>
#include <map>
#include <vector>
#include "armadillo"
#include <gsl/gsl_rng.h>

using namespace arma;
using namespace std;
/*
void randSampleTest(vector<int> &res,int m, int min, int max)
{
  const gsl_rng_type *T;
  gsl_rng *r;
  gsl_rng_env_setup();
  T = gsl_rng_default;
  set<int> tmp;
  while(tmp.size()<m){
    double u = gsl_rng_uniform(r);
    int sp = min + int((max-min)*u);
    tmp.insert(sp);
  }
  
  set<int>::iterator it1=tmp.begin();
  while(it1!=tmp.end())
    {
      res.push_back(*it1);
      it1++;
    }
  gsl_rng_free(r);
}
*/

vector<int> RandomSampleTest(int m, int min, int max)
{
  vector<int> res;
  const gsl_rng_type *T;
  gsl_rng * r;
  gsl_rng_env_setup();
  T=gsl_rng_default;
  r=gsl_rng_alloc(T);
  for(int i=0;i<m;i++)
    {
      double u=gsl_rng_uniform(r);
      int j=min+int((max-min)*u);
      res.push_back(j);
    }
  gsl_rng_free(r);
  return res;
}

int getRow(int index, int collen)
{
  return (index % collen==0)?1:(index % collen);
}
int getCol(int index, int collen)
{
  if(index/collen == 0)
    return 1;
  else
    return getRow(index-collen,collen)+1;
}

set<int> getGeneSet(uvec & v, int collen)
{
  set<int> res;
  int col,row;
  for(int i=0; i<v.n_elem; i++)
    {
      col = getCol(v(i), collen);
      res.insert(col);
      row = getRow(v(i), collen);
      res.insert(row);
    }
  return res;

}

 

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
  //A.print();
  mat X = randu<mat>(5,6);
  X.print();
  uvec indices = find(X<0.2);
  indices.print();
  int t=0;
  X.row(0).print();
  cout<<"index:"<<indices(t)<<'\t'<<X(indices(t))<<endl;
  cout<<"Row:"<<getRow(indices(t),5)<<endl;
  cout<<"Col:"<<getCol(indices(t),5)<<endl;
  vector<int> res=RandomSampleTest(4,1,100); 

  vector<int>::iterator it;
  for(it=res.begin();it!=res.end();it++)
    cout<<*it<<" ";
  cout<<endl;

  fin.close();
  return 0;
}
