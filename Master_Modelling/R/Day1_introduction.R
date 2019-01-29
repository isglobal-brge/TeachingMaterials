
## ----simulate_twin_heights_again, echo=FALSE, message=FALSE, fig.cap="Twin heights scatter plot."----
library(MASS)
n <- 100
set.seed(1)

Y <- mvrnorm(n, c(0,0), matrix(c(1,0.95,0.95,1),2,2))

plot(Y[,1], Y[,2], xlab="Twin 1 (standardized height)",
     ylab="Twin 2 (standardized height)", 
     xlim=c(-3,3), ylim=c(-3,3))
points(Y[1:2, 1], Y[1:2, 2], col=2, pch=16)

## ----projection_not_PC1, fig.align="Data projected onto space spanned by (1 0).", echo=FALSE, message=FALSE, results='hide'----

plot(Y, xlim=c(-3,3), ylim=c(-3,3),
     main=paste("Sum of squares :", round(crossprod(Y[,1]),1)))
abline(h=0)
apply(Y, 1, function(y) segments(y[1],0,y[1],y[2],lty=2))
points(Y[,1],rep(0,nrow(Y)), col=2, pch=16, cex=0.75)

## ----projection_not_PC1_either, fig.cap="Data projected onto space spanned by (1 0).", echo=FALSE----
v <- matrix(c(1,-1)/sqrt(2), nrow = 1)
w <- Y%*%t(v)

plot(Y, main=paste("Sum of squares:", round(crossprod(w),1)),
     xlim=c(-3,3), ylim=c(-3,3))
abline(h=0,lty=2)
abline(v=0,lty=2)
abline(0,-1,col=2)
Z <- w%*%v
for(i in seq(along=w))
  segments(Z[i, 1], Z[i, 2], Y[i, 1],Y[i, 2], lty=2)
points(Z, col=2, pch=16, cex=0.5)

## ----PC1, fig.cap="Data projected onto space spanned by first PC.", echo=FALSE----
v <- matrix(c(1,1)/sqrt(2), nrow=1)
w <- Y%*%t(v)

plot(Y, main=paste("Sum of squares:",round(crossprod(w),1)),
     xlim=c(-3,3), ylim=c(-3,3))
abline(h=0,lty=2)
abline(v=0,lty=2)
abline(0,1,col=2)
points(w%*%v, col=2, pch=16, cex=1)
Z <- w%*%v
for(i in seq(along=w))
  segments(Z[i,1], Z[i,2], Y[i,1], Y[i,2], lty=2)
points(t(Z), col=2, pch=16, cex=0.5)

## ----get PCA-------------------------------------------------------------
ss <- svd(Y)
v <- ss$v[,1]
v
1/sqrt(2)

## ----SS------------------------------------------------------------------
w <- Y%*%v
crossprod(w) # t(w)%*%w

## ------------------------------------------------------------------------
pc <- prcomp(Y, center = FALSE)

## ----pca_svd, fig.cap="Plot showing SVD and prcomp give same results.",fig.width=10.5,fig.height=5.25----
s <- svd( t(Y) )

# First axis
max(abs(pc$x[,1]) - abs(s$d[1]*s$v[,1]))

# Second axis
max(abs(pc$x[,2]) - abs(s$d[2]*s$v[,2]))

## ------------------------------------------------------------------------
pc$rotation

## ------------------------------------------------------------------------
s$u

## ----variance_explained--------------------------------------------------
pc$sdev
s$d

## ----cum_variance_explained----------------------------------------------
cumsum(pc$sdev)/sum(pc$sdev)

## ----pansy---------------------------------------------------------------
library(imager)
x <- load.image("figures/pansy.jpg")
plot(x)

## ----grayscale-----------------------------------------------------------
m <- grayscale(x)
plot(m)

## ----svd_pansy-----------------------------------------------------------
r.svd <- svd(m)
d <- diag(r.svd$d)
u <- r.svd$u
v <- r.svd$v

# first approximation
u1 <- as.matrix(u[-1, 1])
v1 <- as.matrix(v[-1, 1])
d1 <- as.matrix(d[1,1])
l1 <- u1 %*% d1 %*% t(v1)
l1g <- as.cimg(l1)

## ----plot_first_approximation--------------------------------------------
plot(l1g)

## ----more_depth----------------------------------------------------------
# more depth
depth <- 8
us <- as.matrix(u[, 1:depth])
vs <- as.matrix(v[, 1:depth])
ds <- as.matrix(d[1:depth, 1:depth])
ls <- us %*% ds %*% t(vs)
lsg <- as.cimg(ls)
plot(lsg)

## ------------------------------------------------------------------------
sessionInfo()

