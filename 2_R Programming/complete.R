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
