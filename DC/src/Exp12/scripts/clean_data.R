dat<-read.table(file="../raw_noise_0_data",header=T)
dat<-t(dat)
write.table(x=dat,file="../syn_data_0",quote=F,col.names=F)