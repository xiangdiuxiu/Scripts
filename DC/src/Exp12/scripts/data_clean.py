#/usr/bin/python
#coding:utf-8

import sys

infile = open(sys.argv[1])
mofile = open(sys.argv[2])
outfile = open(sys.argv[3],"w")

geneNames = infile.readline().strip().split(' ')
geneNum = len(geneNames)

geneDict = dict(zip(geneNames,range(1,geneNum+1)))

for line in mofile:
    sline = line.strip().split(' ')
    sline[0] = str(geneDict[sline[0]])
    sline[2] = str(geneDict[sline[2]])
    sline[1] = str(1)
    outfile.write('\t'.join(sline)+'\n')

infile.close()
mofile.close()
outfile.close()
