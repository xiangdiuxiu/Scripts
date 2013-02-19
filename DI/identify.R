makeNetwork<-function(data, alpha, corfun=cor){
    #data : each column presents a gene;
    #alpha : if two genes' correlation coefficient is lower than alpha, we consider
    #        these two genes have no connection;
    #corfun : function to calculate correlation between two genes, defaultly is cor().
    #         if we use another function instead, corfun(data) should return a matrix,
    #         in which its ij entry means the correlation between gene i and gene j;
    #net : return a matrix;

    net<-corfun(data)
    net[net<alpha]=0
    net[net>0]=1
    return(net)
}

mergeNetwork<-function(net1, net2){
    #net1,net2 : two matrix with the same size;
    #candiGenes : we delete the common edges in net1 and net2 and find the genes left 
    mergeNet=net1+net2;
    mergeNet[net1==net2]=0
    genes<-which(mergeNet>0,arr.ind=T)#return the row number and the col number of genes
    genelist1<-genes[,1] #get the row numbers
    genelist2<-genes[,2] #get the col numbers
    # row number i and col number j means that gene i and gene j have connection

    return(intersect(genelist1,genelist2))
}



bootGene<-function(ctrl,tumor,B){
  #ctrl, tumor: gene expression data for ctrl group and tumor group respectively;
  #B: boostrap times;
  res<-c()
  b<-0
  N<-ncol(ctrl) #number of examples
  indices<-seq(1,N)
  while(b<B){
    b_indices<-sample(indices,size=floor(sqrt(N)))
    b_ctrl_net<-makeNetwork(ctrl[b_indices,],0.75) #OK, we will add parameter later.
    b_tumor_net<-makeNetwork(tumor[b_indices,],0.75)
    b_net<-mergeNetwork(b_ctrl_net,b_tumor_net)
    res<-c(res,b_net)
    b<-b+1
  }
  myCount<-function(x,v){
    return(sum(v==x))
  }
  f_res<-c()
  for(e in res){
    if(myCount(e,res)>B/2){
      f_res<-c(f_res,e)
    }
  }
  return(unique(f_res))
}
