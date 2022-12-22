# Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA. A prototype of the function is as follows

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
