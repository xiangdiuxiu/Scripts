source("../identify.R")

#读入判断example所属的癌症阶段的数据;
stages<-read.table("count")
IB<-which(stages==5)
II<-which(stages==6)
IIIA<-which(stages==3)
IIIB<-which(stages==4)
III<-which(stages==2)
IV<-which(stages==1)
unknown<-which(stages==7)

early<-union(IB,II)
middle<-union(IIIA,IIIB)
middle<-union(III,middle)
late<-union(IV,unknown)

early_ctrl<-early[early%%2==1]
early_tumor<-early[early%%2==0]

middle_ctrl<-middle[middle%%2==1]
middle_tumor<-middle[middle%%2==0]

late_ctrl<-late[late%%2==1]
late_tumor<-late[late%%2==0]

testdata<-read.table("dataGSE",header=T)
#testdata<-read.table("littleData",header=T)
testdata<-testdata[2:nrow(testdata),]
alpha<-0.75
early_ctrl_data<-t(testdata[,early_ctrl])
early_tumor_data<-t(testdata[,early_tumor])
net_e_1<-makeNetwork(data=early_ctrl_data,alpha=alpha)
net_e_2<-makeNetwork(data=early_tumor_data,alpha=alpha)
gene1<-mergeNetwork(net_e_1,net_e_2)

middle_ctrl_data<-t(testdata[,middle_ctrl])
middle_tumor_data<-t(testdata[,middle_tumor])
net_m_1<-makeNetwork(data=middle_ctrl_data,alpha=alpha)
net_m_2<-makeNetwork(data=middle_tumor_data,alpha=alpha)
gene2<-mergeNetwork(net_m_1,net_m_2)

late_ctrl_data<-t(testdata[,late_ctrl])
late_tumor_data<-t(testdata[,late_tumor])
net_l_1<-makeNetwork(data=late_ctrl_data,alpha=alpha)
net_l_2<-makeNetwork(data=late_tumor_data,alpha=alpha)
gene3<-mergeNetwork(net_l_1,net_l_2)

gene<-intersect(gene1,gene2)
gene<-intersect(gene3,gene)
show(sort(gene))