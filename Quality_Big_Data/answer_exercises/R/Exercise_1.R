# task 1
x <- c(3, 4, 1, 1, 2, 1, 4, 2, 1, 1, 5, 3, 1, 1, 1, 2, 4, 5, 5, 3)
x

# task 2
x == 1
which(x == 1)

length(which(x == 1))

sum(x==1)

# task 3
y <- log(x)
y

# task 4
x
z <- x[1:5]
z

# task 5
help(seq)
seq(1, 20, by=0.2)

# task 6
newVec <- c(x,y)
newVec

# task 7
ls()
rm(newVec)

# task 8
elasticband <- data.frame(stretch = c(46,54,48,50,44,42,52),
                          distance = c(148,182,173,166,109,141,166))
elasticband

# task 9
mean(elasticband$stretch)
sum(elasticband$stretch)/length(elasticband$stretch)
mean(elasticband[,1])


# task 10
class(elasticband$distance)
class(elasticband)
