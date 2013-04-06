dataA<-read.table("SH000001.TXT")
dataXNY<-read.table("xinnengyuan.TXT")
dataZJGDP<-read.table("zhongjinggdp.TXT")
dataSZJX<-read.table("shenzhengzhixiao.TXT")
dataNDJJ<-read.table("neidijijian.TXT")

source("../src/in.R")

window<-5
yA<-dataA$V5[1:(1000+window)]
yXNY<-dataXNY$V5[1:(1000+window)]
yZJGDP<-dataZJGDP$V5[1:(1000+window)]
ySZJX<-dataSZJX$V5[1:(1000+window)]
yNDJJ<-dataNDJJ$V5[1:(1000+window)]

cor(yA,yXNY)
cor(yA,yZJGDP)
cor(yA,ySZJX)
cor(yA,yNDJJ)

par(mfrow=c(2,2))

lx1<-1:(1000+window)

twoord.plot(lx=lx1,rx=lx1,ly=yA,ry=yXNY,type="l")
title("新能源")
twoord.plot(lx=lx1,rx=lx1,ly=yA,ry=yZJGDP,type="l")
title("中经GDP")
twoord.plot(lx=lx1,rx=lx1,ly=yA,ry=ySZJX,type="l")
title("深圳绩效")
twoord.plot(lx=lx1,rx=lx1,ly=yA,ry=yNDJJ,type="l")
title("内地基建")

sA<-Smooth(yA,window)
sXNY<-Smooth(yXNY,window)
sZJGDP<-Smooth(yZJGDP,window)
sSZJX<-Smooth(ySZJX,window)
sNDJJ<-Smooth(yNDJJ,window)

par(mfrow=c(2,2))
lx1<-1:1000
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sXNY,type="l")
title("新能源")
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sZJGDP,type="l")
title("中经GDP")
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sSZJX,type="l")
title("深圳绩效")
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sNDJJ,type="l")
title("内地基建")

cor(sA,sXNY)
cor(sA,sZJGDP)
cor(sA,sSZJX)
cor(sA,sNDJJ)


par(mfrow=c(2,2))
lx1<-1:200
sA<-sA[lx1]
sXNY<-sXNY[lx1]
sZJGDP<-sZJGDP[lx1]
sSZJX<-sSZJX[lx1]
sNDJJ<-sNDJJ[lx1]
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sXNY,type="l")
title("新能源")
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sZJGDP,type="l")
title("中经GDP")
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sSZJX,type="l")
title("深圳绩效")
twoord.plot(lx=lx1,rx=lx1,ly=sA,ry=sNDJJ,type="l")
title("内地基建")

nyA<-newSmooth(yA,window)
nyXNY<-newSmooth(yXNY,window)
nyZJGDP<-newSmooth(yZJGDP,window)
nySZJX<-newSmooth(ySZJX,window)
nyNDJJ<-newSmooth(yNDJJ,window)

par(mfrow=c(2,2))
twoord.plot(lx=lx1,rx=lx1,ly=nyA,ry=nyXNY,type="l")
title("新能源")
twoord.plot(lx=lx1,rx=lx1,ly=nyA,ry=nyZJGDP,type="l")
title("中经GDP")
twoord.plot(lx=lx1,rx=lx1,ly=nyA,ry=nySZJX,type="l")
title("深圳绩效")
twoord.plot(lx=lx1,rx=lx1,ly=nyA,ry=nyNDJJ,type="l")
title("内地基建")
