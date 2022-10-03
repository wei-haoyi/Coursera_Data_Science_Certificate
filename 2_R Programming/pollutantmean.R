pollutantmean <- function(directory,pollutant, id=1:332) {

  full <-NA

  for (x in id){
    path <- paste("./","data/",directory,"/",sprintf("%.3d",x),".csv",sep="")
    rcsv <- read.csv(path)
    full<-rbind(full,rcsv)
  }

  x<-mean(full[,pollutant],na.rm=T)
  x
}
