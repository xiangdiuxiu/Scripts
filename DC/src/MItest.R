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

mr_1.tbl<-validate(mr,true_1)
clr_1.tbl<-validate(clr,true_1)
ar_1.tbl<-validate(ar,true_1)

#write.csv(mr,"mr.csv")
#write.csv(clr,"clr.csv")
#write.csv(ar,"ar.csv")

write.csv(MI,"res/mi.csv")

auc.roc(mr_0.tbl)
auc.roc(mr_1.tbl)
auc.roc(clr_0.tbl)
auc.roc(clr_1.tbl)
auc.roc(ar_0.tbl)
auc.roc(ar_1.tbl)