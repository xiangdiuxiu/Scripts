#读入数据
TotalData<-matrix(0,nrow=1005,ncol=331)
inx<-1
cname<-c()
for(i in 1:571){
      filename<-paste0("clean",i)
      if(file.exists(filename)){
	data<-read.table(filename)
	tmp<-data$V5[1:1005]
	if(i==72) {A=inx}
	TotalData[,inx]<-tmp
	inx<-inx+1
	cname<-c(cname,i)
      }
}


colnames(TotalData)<-cname


#计算correlation
rel<-cor(TotalData)
rel<-rel-diag(ncol(rel))

#选出与A股指数相关性较高的指数数据
hr<-which(abs(rel[A,])>0.957)
nhr<-names(hr)
typeof(nhr)
