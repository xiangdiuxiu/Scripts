#include "main.h"
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
  
  mat matData = makeMatrix(fin, m,n);
  matData = matData.t();
  mat matNetwork = makeNetwork(matData, 0.75);
  mat matNetwork2 = makeNetwork(matData, 0.55);
  matNetwork = mergeNetwork(matNetwork, matNetwork2);
  uvec indices = find(matNetwork==1.0);
  set<int> res = getGeneSet(indices, m);
  
  cout<<res.size()<<endl;
  set<int>::iterator it = res.begin();
  for(;it!=res.end();it++)
    cout<<*it<<" ";
  cout<<endl;
  //matNetwork.print();
  fin.close();
  return 0;
}
