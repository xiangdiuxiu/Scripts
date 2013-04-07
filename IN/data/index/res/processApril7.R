#读入数据
TotalData<-matrix(0,nrow=1005,ncol=331)
inx<-1
cname<-c()
for(i in 1:571){
      filename<-paste0("clean",i)
      if(file.exists(filename)){
	data<-read.table(filename)
	tmp<-data$V5[1:1005]
	TotalData[,inx]<-tmp
	inx<-inx+1
	cname<-c(cname,i)
      }
}
A=72

colnames(TotalData)<-cname


#计算correlation
rel<-cor(TotalData)
rel<-rel-diag(ncol(rel))

#选出与A股指数相关性较高的指数数据
hr<-which(abs(rel[A,])>0.957)
nhr<-names(hr)
rel[A,][nhr[1]]

##计算“错位时间”下相关性的函数
delay<-function(data1,data2,window,len){
	m = length(data1)
	n = length(data2)
	if(max(m,n)<(window[2]+len) || min(m,n)<len){
            show("length error")
            return(NULL)
	}
	if(m==min(m,n)){
            stData = data1[1:len]
	    dyData = data2
	} else {
	    stData = data2[1:len]
	    dyData = data1
	}
	res = c()
	for(i in window[1]:window[2]){
	      tmpData = dyData[(1+i):(len+i)]
	      tmpres = cor(tmpData,stData)
	      res = c(res, tmpres)
	}
	return(res)
}

##测试##
fileA=paste0("clean",A)
fileA
fileT=paste0("clean",nhr[1])
fileT
data=read.table(fileA)
data1=data$V5
data=read.table(fileT)
data2=data$V5

delay(data1,data2,window=c(0,90),len=1005)
