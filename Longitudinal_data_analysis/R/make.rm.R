make.rm<-function(constant,repeated,data,contrasts) {
 if(!missing(constant) && is.vector(constant)) {
  if(!missing(repeated) && is.vector(repeated)) {
   if(!missing(data)) {
    dd<-dim(data)
    replen<-length(repeated)
    if(missing(contrasts))
     contrasts<-
      ordered(sapply(paste("T",1:length(repeated),sep=""),rep,dd[1]))
    else
     contrasts<-matrix(sapply(contrasts,rep,dd[1]),ncol=dim(contrasts)[2])
    if(length(constant) == 1) cons.col<-rep(data[,constant],replen)
    else cons.col<-lapply(data[,constant],rep,replen)
    new.df<-data.frame(cons.col,
     repdat=as.vector(data.matrix(data[,repeated])),
     contrasts)
    return(new.df)
   }
  }
 }
}
