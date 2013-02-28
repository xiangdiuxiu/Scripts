dat<-read.table("../data/SynTren/syn_data",header=T)
p<-ncol(dat)

library(snowfall)
sfInit(parallel=T,cpus=8)
sfLibrary(energy)
sfExport("dat")
sfExport("p")

dcor2<-function(i){
	dis<-matrix(0,ncol=p)
	for(j in (i+1):p){
	      dis[j]<-dcor(dat[,i],dat[,j])
	}
	return(dis)
}

res<-sfSapply(1:(p-1),dcor2)
res<-cbind(res,rep(0,p))
res<-res+t(res)
write.csv(res,"res/csv")

sfStop()