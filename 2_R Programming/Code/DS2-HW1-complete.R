# Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases. A prototype of this function follows

library(dplyr)
complete <- function(directory, id=1:332){
          
          full <-NA
          
          for (x in id){
                    path <- paste("./","data/",directory,"/",sprintf("%.3d",x),".csv",sep="")
                    rcsv <- read.csv(path)
                    full<-rbind(full,rcsv)
          }
          
          results <-full[complete.cases(full),] %>% # remove rows with missing values in any column of data frame.
                    mutate(a=1) %>%
                    group_by(ID) %>%
                    mutate(nobs=sum(a)) %>%
                    filter(row_number()==1) %>%
                    ungroup() %>%
                    select(ID,nobs) %>%
                    relocate(ID,nobs)
          results
}