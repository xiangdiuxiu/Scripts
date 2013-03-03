dat<-read.table("../data/SynTren/syn_data",header=T)
p<-ncol(dat)
dat<-as.matrix(dat)

true_0<-read.csv("../data/SynTren/diag_0_matrix",header=F)
true_0<-as.matrix(true_0)
true_1<-read.csv("../data/SynTren/diag_1_matrix",header=F)
true_1<-as.matrix(true_1)

library(minet)
library(energy)

MI<-build.mim(dat,"mi.shrink","equalwidth",sqrt(nrow(dat)))

mr<-mrnet(MI)
ar<-aracne(MI)
clr<-clr(MI)

mr_0.tbl<-validate(mr,true_0)
clr_0.tbl<-validate(clr,true_0)
ar_0.tbl<-validate(ar,true_0)
mi.tbl<-validate(MI,true_0)

write.csv(mr,"tbl/mi_mr.csv",row.names=F,col.names=F,quote=F)
write.csv(clr,"tbl/mi_clr.csv",row.names=F,col.names=F,quote=F)
write.csv(ar,"tbl/mi_ar.csv",row.names=F,col.names=F,quote=F)
write.csv(MI,"tbl/mi_mi.csv",row.names=F,col.names=F,quote=F)



auc.roc(mr_0.tbl)
auc.roc(clr_0.tbl)
auc.roc(mi.tbl)

auc.pr(mr_0.tbl)
auc.pr(clr_0.tbl)
auc.pr(mi.tbl)