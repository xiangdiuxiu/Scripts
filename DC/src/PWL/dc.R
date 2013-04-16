
d <- function(X, Y, inx){
  i <- inx[1]
  j <- inx[2]
  k <- inx[3]
  l <- inx[4]
  dij <- dist(rbind(X[i], X[j]))[1]
  dkl <- dist(rbind(X[k], X[l]))[1]
  dik <- dist(rbind(X[i], X[k]))[1]
  djl <- dist(rbind(X[l], X[j]))[1]
  dx <- dij + dkl - dik - djl
  
  dij <- dist(rbind(Y[i], Y[j]))[1]
  dkl <- dist(rbind(Y[k], Y[l]))[1]
  dik <- dist(rbind(Y[i], Y[k]))[1]
  djl <- dist(rbind(Y[l], Y[j]))[1]
  dy <- dij + dkl - dik - djl
  
  return(dx * dy)
}

phi <- function(X, Y, inx){
  ijkl <- ijlk <- iljk <- inx
  ijlk[3] <- ijkl[4]
  ijlk[4] <- ijkl[3]
  iljk[2] <- ijkl[4]
  iljk[4] <- ijkl[2]
  return((d(X, Y, ijkl) + d(X, Y, ijlk) + d(X, Y, iljk)) / 12)
}

u_stastic <- function(dX, dY){
  
  dX <- as.matrix(dX)
  dY <- as.matrix(dY)
  n <- dim(dY)[1]
  inx <- combn(1:n, 4, simplify=F)
  f<-function(i){
    return(phi(X=dX, Y=dY, inx=i))
  }
  res <- sapply(inx, f)
  
  return(sum(res)/choose(n, 4))
}

##test##

dcor_pwl <- function(dX, dY){
  dxy <- u_stastic(dx, dy)
  dxx <- u_stastic(dx, dx)
  dyy <- u_stastic(dy, dy)
  return(dxy / sqrt(dxx * dyy))
}