source("pca_cmi.R")
source("pca_dc.R")
Y50<-read.csv(file="../data/Yeast50",header=T,sep=" ")
Y50<-Y50[,-1]
alphas<-seq(0.1,0.9,by=0.1)
ROCs<-c()

true_net<-read.table(file="../data/DataMatrix.txt",header=F)
true_net<-as.matrix(true_net)
library(minet)
for(alpha in alphas){
  dc_net<-pca_dc(t(Y50),alpha,2)
  test_dc.tbl<-validate(dc_net,true_net)
  roc<-auc.roc(test_dc.tbl)
  ROCs<-c(ROCs,roc)
}
cmi_net<-pca_cmi(t(Y50),0.75,2)
test_cmi.tbl<-validate(cmi_net,true_net)
cmiRoc<-auc.roc(test_cmi.tbl)
show(ROCs)
show(cmiRoc)