NOTE: PCA is equivalent to performing the SVD on the centered data


set.seed(123)
n <- 100  
k <- 10
X <- matrix(rnorm(n^2), n)

pc <- prcomp(X)
plot(pc$x[, 1], pc$x[, 2])


X.c <- sweep(X, 2, colMeans(X), "-")
svd <- RSpectra::svds(X.c, k=2)
plot(svd$v[,1], svd$v[,2])
plot(svd$v[,1], svd$v[,2])


     