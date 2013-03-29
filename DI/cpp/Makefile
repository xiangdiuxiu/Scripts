
LIBINCLUDE=~/tools/armadillo/usr/include/
LIBPATH=~/tools/armadillo/usr/lib64/
GSLPATH=~/GSL/lib/
GSLINCLUDE=~/GSL/include/

all:UnitTest

UnitTest: main.o identify.o
	g++ main.o identify.o -o UniTest -L $(LIBPATH) -L $(GSLPATH) -I $(LIBINCLUDE) -I $(GSLINCLUDE) -lgsl -lm -lgslcblas

main.o: main.cpp main.h
	g++ -c main.cpp -L $(LIBPATH) -L $(GSLPATH) -I $(LIBINCLUDE) -I $(GSLINCLUDE) -lgsl -lm -lgslcblas

identify.o: identify.cpp identify.h
	g++ -c identify.cpp -L $(LIBPATH) -L $(GSLPATH) -I $(LIBINCLUDE) -I $(GSLINCLUDE) -lgsl -lm -lgslcblas

clean: 
	rm *.o