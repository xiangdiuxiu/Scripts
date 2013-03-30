#include "main.h"

int main(int argc, char** argv)
{
  ifstream fin(argv[1],ios::in);
  int ngenes = 133772;
  int nsamples = 160;
  mat Data = makeMatrix(fin, ngenes, nsamples);
  uvec tumor(80), ctrl(80);
  for(int i=0; i<80; i++){
    tumor(i) = 2*i;
    ctrl(i) = 2*i+1;
  }
  mat tumorData = Data.cols(tumor);
  mat ctrlData = Data.cols(ctrl);
  tumorData = tumorData.t();
  ctrlData = ctrlData.t();
  for(int i=0; i<3; i++){
    uvec test(5);
    vector<int> rtest = randomSample(5,10000+i,0,1000);
    int j=0;
    for(vector<int>::iterator it = rtest.begin(); it!=rtest.end();it++)
      test(j++) = (*it);
    cout<<i<<" test:"<<endl;
    test.print();
  }
  return 0;
}
