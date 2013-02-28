dat<-read.table("clean_ecoli_data.txt",header=F)
rownames(dat)<-dat[,1]
dat<-dat[,-1]
dat<-t(dat)
p<-ncol(dat)
dat<-as.matrix(dat)

true<-read.csv("diag_0_matrix.csv",header=F)
true<-as.matrix(true)

library(minet);library(energy)

# Inference
#### mrnet method ####
MI<-build.mim(dat,"mi.shrink","equalwidth",sqrt(nrow(dat)))
mr <- mrnet(MI)
#### aracne method ####
ar <- aracne(MI)
#### clr method ####
clr<- clr(MI)

##MRNET Validation###
mr.tbl <- validate(mr,true)
##CLR Validation##
clr.tbl<- validate(clr,true)
## Releveance Network using Mutual information ##
MI.tbl <- validate(MI,true)

write.csv(mr.tbl,"mr.csv")
write.csv(clr.tbl,"clr.csv")
write.csv(MI.tbl,"MI.csv")

auc.pr(clr.tbl)
auc.pr(mr.tbl)
auc.pr(MI.tbl)

auc.roc(clr.tbl)
auc.roc(mr.tbl)
auc.roc(MI.tbl)
