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


bootGene<-function(data, indices, n, alpha, corfun=cor){
    #data includes the gene expession data about contrl groups and tumor groups.
    #indices is necessary for boot.
    #n must be even. n stand for the number of examples.
    #alpha, corfun is needed by makeNet.
    ctrl<-seq(1,ex-1,by=2)
    tumor<-seq(2,ex,by=2)
    ctrldata<-t(data[,ctrl])
    tumordata<-t(data[,tumor])
    
    bootctrldata<-ctrldata[indices,]
    boottumordata<-tumordata[indices,]
    
    ctrlnet<-makeNetwork(bootctrldata, alpha, corfun)
    tumornet<-makeNetwork(boottumordata, alpha, corfun)
    return(mergeNetwork(ctrlnet,tumornet)
    
}
