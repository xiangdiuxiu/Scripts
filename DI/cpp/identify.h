#include <iostream>
#include <iostream>
#include <fstream>
#include <string>
#include "armadillo"

using namespace arma;
using namespace std;

mat makeMatrix(ifstream &, int, int);
mat makeNetwrok(mat &, double);
