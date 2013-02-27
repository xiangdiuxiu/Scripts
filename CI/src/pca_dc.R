library(earth); #Multivariate Adaptive Regression Splines
library(energy);# distance correlation
dc<-function(v1,v2,vcs=NULL){
  if(is.null(vcs)){cmiv<-dcor(v1,v2)}
  else{ 
    if(is.vector(vcs)){vcs<-as.matrix(vcs)}
    else{vcs<-t(vcs)}
    resx<-earth(v1~vcs)$res
    resy<-earth(v2~vcs)$res
    cmiv<-dcor(resx,resy)}
  
  return(cmiv)
}

edgereduce_dc<-function(G,Gval,order,data,t,lambda){
  if(order==0){
    for(i in 1:(nrow(G)-1)){
      for(j in (i+1):nrow(G)){
        if(G[i,j]!=0){
          cmiv<-dc(data[i,],data[j,])
          Gval[i,j]<-cmiv
          Gval[j,i]<-cmiv
          if(cmiv<lambda){
            G[i,j]<-0
            G[j,i]<-0
          }
        }
      }
    }
    t<-t+1
  }else{
    for(i in 1:(nrow(G)-1)){
      for(j in (i+1):nrow(G)){
        if(G[i,j]!=0){
          adj<-c()
          for(k in 1:nrow(G)){
            if(G[i,k]!=0&&G[j,k]!=0){
              adj<-c(adj,k)
            }
          }
          if(!is.null(adj)&&length(adj)>=order){
            combnlist<-combn(adj,order)
            combnnum<-ncol(combnlist)
            cmiv<-0
            v1<-data[i,]
            v2<-data[j,]
            for(k in 1:combnnum){
              vcs<-data[combnlist[,k],]
              a<-dc(v1,v2,vcs)
              cmiv<-max(cmiv,a)
            }
            Gval[i,j]<-cmiv
            Gval[j,i]<-cmiv
            if(cmiv<lambda){
              G[i,j]<-0
              G[j,i]<-0
            }else{
              t<-t+1
            }
          }
        }
      }
    }
  }
  return(list(G,Gval,t))
}

pca_dc<-function(data,lambda,order0=NULL){
  n_gene<-nrow(data)
  G<-matrix(1,n_gene,n_gene)
  diag(G)=0
  Gval<-G
  order<--1
  t=0
  while(t==0){
    order<-order+1
    if(!is.null(order0)){
      if(order>order0){
        #G[lower.tri(G,diag=TRUE)]=0
        #Gval[lower.tri(G,diag=TRUE)]=0
        return(list(G,Gval,order))
      }
    }
    result<-edgereduce_dc(G,Gval,order,data,t,lambda)
    G<-result[[1]]
    Gval<-result[[2]]
    t<-result[[3]]
    if(t==0){
      show("Algorithm is finished")
      break;
    }else{
      t=0
    }
  }
  #G[lower.tri(G,diag=TRUE)]=0
  #Gval[lower.tri(G,diag=TRUE)]=0
  order<-order-1
  return(list(G,Gval,order))
}

#Y10<-read.csv(file=file.choose(),header=T)
#Y10<-as.matrix(Y10[,-1])
#res<-pca_cmi(t(Y10),0.5,2)