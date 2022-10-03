source("./2_R Programming/complete.R")
corr <- function(directory, threshold=0){

  for (x in 1:332){
    path <- paste("./","data/",directory,"/",sprintf("%.3d",x),".csv",sep="")
    rcsv <- read.csv(path)
    full<-rbind(full,rcsv)
  }

  nobs <- complete(directory)

  full_nobs <- left_join(full,nobs, by="ID")

  results <-    full_nobs %>%
    group_by(ID) %>%
    mutate(correlation=cor(sulfate,nitrate,use="na.or.complete")) %>%
    filter(row_number()==1) %>%
    ungroup() %>%
    select(ID,nobs,correlation) %>%
    filter(nobs>threshold)

  vec <-results$correlation
}
