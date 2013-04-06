Smooth<-function(v, window){
    res<-vector(mode="double", length=length(v)-window)
    for(i in 1:length(res)){
    	  b5<-mean(v[i:(i+window-1)])
	  a5<-mean(v[(i+1):(i+window)])
	  res[i]<-(b5-a5)/a5
    }
    return(res)
}



TotalData<-matrix(0,nrow=1000,ncol=333)
inx<-1
cname<-c()
s<-c(226,256,324,328)
for(i in 1:571){
      filename<-paste0("clean",i)
      if(file.exists(filename)){
	data<-read.table(filename)
	TotalData[,inx]<-Smooth(data$V5[1:1005],5)
	#if(inx %in% s){show(i)}
	if(i == 365){A=inx}
	inx<-inx+1
	cname<-c(cname,i)
      }
}

names(TotalData)<-cname

rel<-cor(TotalData)
rel<-rel-diag(333)
ncol(rel)
A
which(abs(rel[A,])>0.7)
rel[A,][abs(rel[A,])>0.7]




