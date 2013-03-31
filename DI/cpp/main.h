#include <iostream>
#include <fstream>
#include <string>
#include <set>
#include <vector>
#include "armadillo"
#include "identify.h"


using namespace std;
using namespace arma;

extern mat makeNetwork(mat &,double);
extern int getCol(int,int);  
extern int getRow(int,int);
extern std::set<int> getGeneSet(uvec &, int);
extern void randomSample(uvec&, int, int, int);
extern vector<int> randomSample(int, int, int, int);
