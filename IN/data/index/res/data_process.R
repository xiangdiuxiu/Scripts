Smooth<-function(v, window){
    res<-vector(mode="double", length=length(v)-window)
    for(i in 1:length(res)){
    	  b5<-mean(v[i:(i+window-1)])
	  a5<-mean(v[(i+1):(i+window)])
	  res[i]<-(b5-a5)/a5
    }
    return(res)
}
newSmooth<-function(v,window){
  l<-(length(v)/window)
  res<-vector(mode="double",length=l-1)
  for(i in 1:(l-1)){
    b1<-(i-1)*window+1;
    e1<-i*window;
    b2<-e1+1;
    e2<-(i+1)*window;
    res[i]<-(sum(v[b1:e1])-sum(v[b2:e2]))/sum(v[b1:e1])
  }
      return(res)
  
}



TotalData<-matrix(0,nrow=199,ncol=333)
inx<-1
cname<-c()
s<-c(62, 122, 126, 218)
for(i in 1:571){
      filename<-paste0("clean",i)
      if(file.exists(filename)){
	data<-read.table(filename)
	tmp<-Smooth(data$V5[1:1005],5)
	TotalData[,inx]<-newSmooth(tmp,5)
	if(inx %in% s){show(i)}
	if(i == 72){A=inx}
	inx<-inx+1
	cname<-c(cname,i)
      }
}

names(TotalData)<-cname

rel<-cor(TotalData)
rel<-rel-diag(333)
ncol(rel)

rf<-rel[A,]
which(abs(rel[A,])>0.7)
rf[which(abs(rel[A,])>0.7)]




