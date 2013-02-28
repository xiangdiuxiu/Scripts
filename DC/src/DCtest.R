true<-read.csv("../data/SynTren/diag_0_matrix",header=F)
true<-as.matrix(true)

library(minet)
library(energy)

dc<-read.csv("res/dc.csv",header=T)
dc<-as.matrix(dc)

mr<-mrnet(dc)
clr<-clr(dc)

mr.tbl<-validate(mr,true)
clr.tbl<-validate(clr,true)
dc.tbl<-validate(dc,true)

auc.roc(mr.tbl)
auc.roc(clr.tbl)
auc.roc(dc.tbl)