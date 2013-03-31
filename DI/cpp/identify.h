#include <iostream>
#include <iostream>
#include <fstream>
#include <string>
#include "armadillo"
#include <set>
#include <gsl/gsl_rng.h>

using namespace arma;
using namespace std;

mat makeMatrix(ifstream &, int, int);
extern mat makeNetwork(mat &, double);
extern int getRow(int, int);
extern int getCol(int, int);
extern set<int> getGeneSet(uvec &, int);
extern mat mergeNetwork(mat &, mat&);
extern vector<int> randomSample(int, int, int, int);
//extern uvec new_randomeSample(int, int, int, int);
extern void randomSample(uvec&, int, int, int);
extern void getGeneSet(set<int> &, mat &, double thes);
