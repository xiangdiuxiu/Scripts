
//v0.01
//Author: ZhangYet

#include "identify.h"
extern void getGeneSet(set<int> &res, mat & data, double thes)
{
  mat cor_res;
  for(int i = 0; i < data.n_cols; i++)
    for(int j = i+1; j < data.n_cols; j++)
      {
	cor_res = cor(data.col(i),data.col(j));
	if(cor_res(0)>thes){
	  res.insert(i);
	  res.insert(j);
	}
	cout<<res.size()<<endl;
      }
}
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

extern mat makeNetwork(mat &data, double alpha)
{
  
  cout<<"begin make"<<endl;
  mat net = cor(data);
  uvec indices_0 = find(net<alpha);
  uvec indices_1 = find(net>=alpha);

  net.elem(indices_0) = zeros<vec>(indices_0.n_elem);
  net.elem(indices_1) = ones<vec>(indices_1.n_elem);
  return net;
}

extern int getRow(int index, int collen)
{
  return (index % collen==0)?1:(index % collen);
}
extern int getCol(int index, int collen)
{
  if(index/collen == 0)
    return 1;
  else
    return getRow(index-collen,collen)+1;
}

extern set<int> getGeneSet(uvec & v, int collen)
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

extern mat mergeNetwork(mat &net1, mat &net2)
{
  mat res = zeros<mat>(net1.size());
  res = net1 + net2;//Of course we should have made a test to make sure net1.size()==net2.size()
  uvec indices = find(net1==net2);
  res.elem(indices) = zeros<vec>(indices.n_elem);
  uvec indices2 = find(res>0);
  res.elem(indices2) = ones<vec>(indices2.n_elem);
  return res;

}

extern vector<int> randomSample(int m, int seed, int min, int max)
{
  vector<int> res;
  const gsl_rng_type *T;
  gsl_rng *r;

  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc(T);
  gsl_rng_set(r,seed);
  set<int> temp;

  while(temp.size()<m)
  {

    double u=gsl_rng_uniform(r);
    int j=min+int((max-min)*u);
    temp.insert(j);

  }
  set<int>::iterator it = temp.begin();
  while(it != temp.end())
  {
    res.push_back((*it));
    it++;
  }
  gsl_rng_free(r);
  return res;
}

extern void randomSample(uvec& res, int seed, int min, int max)
{
  int m = res.n_elem;
  const gsl_rng_type *T;
  gsl_rng *r;

  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc(T);
  gsl_rng_set(r,seed);
  set<int> temp;

  while(temp.size()<m)
  {
    double u=gsl_rng_uniform(r);
    int j=min+int((max-min)*u);
    temp.insert(j);

  }
  set<int>::iterator it = temp.begin();
  gsl_rng_free(r);
  for(int i=0; i<m; i++){
    res(i) = (*it);
    it++;
  }
}

/*
extern uvec new_randomSample(int m, int min, int max, int seed)
{
  uvec res(m);
  const gsl_rng_type *T;
  gsl_rng *r;
  gsl_rng_set(r,seed);
  gsl_rng_env_setup();
  T = gsl_rng_default;
  r = gsl_rng_alloc(T);
  set<int> temp;

  while(temp.size()<m)
  {
    cout<<temp.size()<<endl;
    double u=gsl_rng_uniform(r);
    int j=min+int((max-min)*u);
    temp.insert(j);

  }
  set<int>::iterator it = temp.begin();
  gsl_rng_free(r);
  for(int i=0; i<m; i++){
    res(i) = (*it);
    it++;
  }
  return(res);
}
*/
