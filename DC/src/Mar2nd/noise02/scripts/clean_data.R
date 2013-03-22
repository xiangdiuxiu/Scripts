dat<-read.table(file="../raw_noise_0_data")
dat<-dat[-1,]
dat<-t(dat)
write.table(x=dat,file="../syn_data_0",quote=F,col.names=F,row.names=F)