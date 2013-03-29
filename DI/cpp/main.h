#include <iostream>
#include <fstream>
#include <string>
#include <set>
#include "armadillo"
#include "identify.h"


using namespace std;
using namespace arma;

extern mat makeNetwork(mat &,double);
extern int getCol(int,int);  
extern int getRow(int,int);
extern std::set<int> getGeneSet(uvec &, int);
