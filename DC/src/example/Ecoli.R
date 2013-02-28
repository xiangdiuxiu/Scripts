#dat<-read.table(file.choose(),header=T)
dat<-read.table("clean_ecoli_data.txt")
rownames(dat)<-dat[,1]
dat<-dat[,-1]
dat<-t(dat)
p<-ncol(dat)
### Build distance correlation matrix ###

library(snowfall)
sfInit(parallel=T,cpus=15)

sfLibrary(energy)

sfExport("dat")
sfExport("p")

dcor2<-function(i) {
           dis<-matrix(0,ncol=p)
           for(j in (i+1):p) {
                              dis[j]<-dcor(dat[,i],dat[,j]) }
           return(dis)
}

res<-sfSapply(1:(p-1),dcor2)
res<-cbind(res,rep(0,p))
res<-res+t(res)
write.csv(res,"res.csv")

sfStop()