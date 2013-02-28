true<-read.csv("diag_0_matrix.csv",header=F)
true<-as.matrix(true)

library(minet);library(energy)

#DC
dc<-read.csv("res.csv",header=T)
dc<-as.matrix(dc)
dc<-dc[,-1]

## Mrnet using
mr <- mrnet(dc)
#### clr method ####
clr<- clr(dc)

##MRNET Validation###
mr.tbl <- validate(mr,true)
dev<-show.pr(mr.tbl,col="green",type="l")
##CLR Validation##
clr.tbl<- validate(clr,true)
show.pr(clr.tbl,col="red",type="l",device=dev)
## Releveance Network using Distance correlation ##
dc.tbl <- validate(dc,true)
show.pr(dc.tbl,col="blue",type="l",device=dev)
dev.off()

write.csv(mr.tbl,"mrdc.csv")
write.csv(clr.tbl,"clrdc.csv")
write.csv(dc.tbl,"dc.csv")

auc.pr(clr.tbl)
auc.pr(mr.tbl)
auc.pr(dc.tbl)

auc.roc(clr.tbl)
auc.roc(mr.tbl)
auc.roc(dc.tbl)