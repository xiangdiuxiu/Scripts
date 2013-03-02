true<-read.csv("../data/SynTren/diag_0_matrix",header=F)
true<-as.matrix(true)

library(minet)
library(energy)

dc<-read.csv("res/dc.csv",header=T)
dc<-as.matrix(dc)
dc<-dc[,-1]

mr<-mrnet(dc)
clr<-clr(dc)

mr.tbl<-validate(mr,true)
clr.tbl<-validate(clr,true)
dc.tbl<-validate(dc,true)

write.csv(dc,"tbl/dc_dc.csv",row.names=F,col.names=F,quote=F)
write.csv(mr,"tbl/mr_dc.csv",row.names=F,col.names=F,quote=F)
write.csv(clr,"tbl/clr_dc.csv",row.names=F,col.names=F,quote=F)

auc.roc(mr.tbl)
auc.roc(clr.tbl)
auc.roc(dc.tbl)

auc.pr(mr.tbl)
auc.pr(clr.tbl)
auc.pr(dc.tbl)
