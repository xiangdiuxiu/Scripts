#loss_function:(y-x*beta)~(y-x*beta);
#x, y, beta must be matrixs;
loss <- function(y, x, beta){
  y <- as.matrix(y)
  x <- as.matrix(x)
  beta <- as.matrix(beta)
  res <- t(y - x %*% beta) %*% (y - x %*% beta)
  return(res[1])
}

#L1_penalty;
#beta must be a matrix;
penalty <- function(beta){
  beta <- as.matrix(beta)
  return(sum(abs(beta)))
}

#objective_function=loss+lambda*penalty;
#x, y, beta, must be matrix, lambda be double;
obj_function <- function(x, y, beta, lambda){
  return(loss(y, x, beta) + lambda * penalty(beta))
} 

#armijo_rule;
#H:Hessian matrix;
#y, x, beta, d, H : matrix, lambda, alpha : double

armijo_rule <- function(y, x, beta, d, lambda, H, alpha){
  gamma <- 0.2
  sigma <- 0.1
  bet <- 0.5
  result <- 2 * ((t(x%*%beta-y)%*% x) %*% d + gamma * t(d) %*% H %*% d + lambda * (penalty(beta + d) - penalty(beta)))
  delta <- result[1]
  t1 <- obj_function(y, x, beta, lambda)
  t2 <- sigma * delta
  while(obj_function(y, x, (beta+alpha*d),lambda)>(t1+alpha*t2)){
    alpha <- alpha * bet
  }
  return(alpha)
 
}

#initial value beta <- beta0=(0,0,...,0)
lasso <- function(y, x, beta0, lambda){
    eps <- 1e-04
    p <- nrow(beta0)
    xy <- t(x) %*% y
    x_square <- t(x) %*% x
    H <- diag(diag(x_square))
    d <- matrix(0, nrow=p, ncol=1)  
    beta <- matrix(0, nrow=p, ncol=1)  
    alpha <- 1
    t1 <- matrix(0, nrow=p, ncol=1)  
    t2 <- matrix(0, nrow=p, ncol=1)  
    q <- matrix(0, nrow=p, ncol=1)  
    beta <- beta0 #话说我们之前初始化得那么辛苦干嘛勒？
    k <- 0
    max_ite <- 10000 #最大迭代数

    gradient_f <- 2 * (x_square %*% beta -xy)
    for(j in 1:p){
       	  t1[j,1] <- -(gradient_f[j,1] + lambda)/H[j,j]
	  t2[j,1] <- -(gradient_f[j,1] - lambda)/H[j,j]
	  if(t1[j,1]>-beta[j,1]){
		d[j,1] <- t1[j,1]
	  }else{
		if(t2[j,1] <- -beta[j,1]){
		    d[j,1] <-t2[j,1]
		}else{
		    d[j,1] <- -beta[j,1]
		}
	  }
	  q[j,0]=gradient_f[j,1]*d[j,1]+1/2*d[j,1]*d[j,1]*H[j,j]+lambda*(abs(d[j,1]+beta[j,1])-abs(beta[j,1]));#结束for循环
    }
    least <- min(min(q))
    if(k==0){
	v <- 0.5
    }else{
	if(alpha>1e-03){
		v <- ifelse((v/10)>1e-04,(v/10),1e-04)
	}else{
		if(alpha<1e-06){
			v <- ifelse(0.9<(50*v)?0.9,(50*v))
		}else{
			v <- v
		}
	}
    }
    v_least <- v * least
    for(j in 1:p){
    	  if(q[j,1]>v_least){
		d[j,1] <- 0
	 }
    }
    if((alpha/bet)<1){
	alpha <- alpha / bet
    }else{alpha <- 1}
    alpha <- armijo_rule(y, x, beta, d, lambda, H, alpha)
    beta <- alpha * d
    k <- k+1
    
    while(max(max(abs(H * d))) > eps){
      gradient_f <- 2 * (x_square %*% beta -xy)
      for(j in 1:p){
        t1[j,1] <- -(gradient_f[j,1] + lambda)/H[j,j]
        t2[j,1] <- -(gradient_f[j,1] - lambda)/H[j,j]
        if(t1[j,1]>-beta[j,1]){
          d[j,1] <- t1[j,1]
        }else{
          if(t2[j,1] <- -beta[j,1]){
            d[j,1] <-t2[j,1]
          }else{
            d[j,1] <- -beta[j,1]
          }
        }
        q[j,0]=gradient_f[j,1]*d[j,1]+1/2*d[j,1]*d[j,1]*H[j,j]+lambda*(abs(d[j,1]+beta[j,1])-abs(beta[j,1]));#结束for循环
      }
      least <- min(min(q))
      if(k==0){
        v <- 0.5
      }else{
        if(alpha>1e-03){
          v <- ifelse((v/10)>1e-04,(v/10),1e-04)
        }else{
          if(alpha<1e-06){
            v <- ifelse(0.9<(50*v)?0.9,(50*v))
          }else{
            v <- v
          }
        }
      }
      v_least <- v * least
      for(j in 1:p){
        if(q[j,1]>v_least){
          d[j,1] <- 0
        }
      }
      if((alpha/bet)<1){
        alpha <- alpha / bet
      }else{alpha <- 1}
      alpha <- armijo_rule(y, x, beta, d, lambda, H, alpha)
      beta <- alpha * d
      k <- k+1
    }
    return(beta)
}


cv <- function(y, x, beta0, lambda, n_folds=5){
   row <- nrow(y)
   p <- ncol(x)
   block <- row / n_folds
   test_y <- matrix(0, nrow=block, ncol=1)
   test_x <- matrix(0, nrow=block, ncol=p)
   train_y <- matrix(0, nrow=row-block, ncol=1)
   train_x <- matrix(0, nrow=row-block, ncol=p)
   sum <- 0
   for(k in 1:n_folds){
   	 test_y <- y[((k-1)*block+1):(k*block),1]
	 test_x <- x[((k-1)*block+1):(k*block),1:p]
	 if(k==1){
		train_y <- y[(block+1):row,1]
		train_x <- x[(block+1):row,1:p]
	 }else{
		if(k==n_folds){
			train_y[1:(k*block),1] <- y[1:(k*block),1]
			train_x[1:(k*block),1:p] <- x[1:(k*block),1:p] 
		}else{
			train_y[1:(k*block),1] <- y[1:(k*block),1]
			train_y[(k*block+1):(row-block),1] <- y[(k*block+1):(row-block),1]
			train_x[1:(k*block),1:p] <- x[1:(k*block),1:p] 
			train_x[(k*block+1):(row-block),1:p] <- x[(k*block+1):(row-block),1:p]
		}
	 }
	 beta <- lasso(train_y, train_x, beta0, lambda)
	 temp <- t(test_y-test_x%*%beta) %*% (test_y -test_x %*% beta)
	 sum <- sum + temp[1]
   }#for 循环结束
   return(sum/(row-block)/n_folds)
}
