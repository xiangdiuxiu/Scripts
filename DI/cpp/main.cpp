#include "main.h"

int main(int argc, char** argv)
{
  ifstream fin(argv[1],ios::in);
  int ngenes = 133772;
  int nsamples = 160;
  cout<<"make matrix"<<endl;
  mat Data = makeMatrix(fin, ngenes, nsamples);
  cout<<"finish making matrix"<<endl;
  uvec tumor(80), ctrl(80);
  for(int i=0; i<80; i++){
    tumor(i) = 2*i;
    ctrl(i) = 2*i+1;
  }
  cout<<ctrl(79)<<endl;
  mat tumorData = Data.cols(tumor);
  mat ctrlData = Data.cols(ctrl);
  tumorData = tumorData.t();
  ctrlData = ctrlData.t();
  
  //init boostup
  int nb = 100;
  int iter = 0;
  set<int> res;
  uvec sample(10);
  randomSample(sample, 10000+iter, 0, 79);
  sample.print();
  mat tumorSample = tumorData.rows(sample);
  mat ctrlSample = ctrlData.rows(sample);
  
  getGeneSet(res, tumorSample, 0.75);
  //到makeNetwork才会出现问题;
  /*
  double thes = 0.75;
  mat net1 = makeNetwork(tumorSample, thes);
  mat net2 = makeNetwork(ctrlSample, thes);
  cout<<"first statage"<<endl;
 
  mat resnet = mergeNetwork(net1, net2);
  uvec indices = find(resnet==1);
  res = getGeneSet(indices, 10);
  iter++;
  set<int>::iterator it_test = res.begin();
  for(;it_test != res.end(); it_test++)
    cout<<*it_test<<" ";
  cout<<endl;
  while(iter < nb){
    randomSample(sample, 10000+iter, 0,79);
    tumorSample = tumorData.rows(sample);
    ctrlSample = ctrlData.rows(sample);
    net1 = makeNetwork(tumorSample, thes);
    net2 = makeNetwork(ctrlSample, thes);
    resnet = mergeNetwork(net1, net2);
    indices = find(resnet==1);
    set<int> tmpset = getGeneSet(indices, 10);
    set_intersection(tmpset.begin(),tmpset.end(),res.begin(),res.end(), inserter(res, res.end()));
    iter++;
  }
  cout<<"after boostrap:"<<endl;
  for(it_test=res.begin();it_test!=res.end();it_test++)
    cout<<*it_test<<" ";
  cout<<endl;
  */
  return 0;
}
