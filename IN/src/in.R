require(plotrix)
require(energy)

kel<-function(v){
  n<-length(v)
  res<-vector(mode='double',length=n-4)
  for(i in 1:(n-4)){
    res[i]<-mean(v[i:(i+4)])
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

Smooth<-function(v, window){
  res<-vector(mode="double", length=length(v)-window)
  for(i in 1:length(res)){
    b5<-mean(v[i:(i+window-1)])
    a5<-mean(v[(i+1):(i+window)])
    res[i]<-(b5-a5)/a5
  }
  return(res)
}