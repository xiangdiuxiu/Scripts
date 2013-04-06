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

Smooth<-function(v, window){
  res<-vector(mode="double", length=length(v)-window)
  for(i in 1:length(res)){
    b5<-mean(v[i:(i+window-1)])
    a5<-mean(v[(i+1):(i+window)])
    res[i]<-(b5-a5)/a5
  }
  return(res)
}