source("pca_cmi.R")
source("pca_dc.R")
Y50<-read.csv(file="../data/Yeast50",header=T,sep=" ")
Y50<-Y50[,-1]
alphas<-seq(0.5,0.9,by=0.1)
ROCs<-c()

true_net<-read.table(file="../data/true_net",header=F,sep=",")
true_net<-as.matrix(true_net)
library(minet)
dfor(alpha in alphas){
  dc_net<-pca_dc(t(Y50),alpha,2)
  dc_net<-dc_net[[1]]
  test_dc.tbl<-validate(dc_net,true_net)
  roc<-auc.roc(test_dc.tbl)
  show(roc)
  ROCs<-c(ROCs,roc)
}
cmi_net<-pca_cmi(t(Y50),0.75)
cmi_net<-cmi_net[[1]]
test_cmi.tbl<-validate(cmi_net,true_net)
cmiRoc<-auc.roc(test_cmi.tbl)
show(ROCs)
show(cmiRoc)