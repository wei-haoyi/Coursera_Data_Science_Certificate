# This file plot plot1.
library(dplyr)
## Import the data
data0 <- read.table("~/Documents/GitHub/Coursera_Data_Science_Certificate/4_exploratory data analysis/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# clean the data
data <- data0 %>%
          mutate(Date=as.Date(Date, "%d/%m/%Y")) %>% ## Format date to Type Date
          filter(Date>="2007-02-01" & Date<="2007-02-02") %>% ## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
          na.omit() %>% ## Remove incomplete observation
          mutate(datetime=as.POSIXct(paste(Date,Time),format="%Y-%m-%d %H:%M:%S")) %>% #add time date column
          select(-c(Date,Time)) %>%
          relocate(datetime)

## Create Plot 3
with(data, {
          plot(Sub_metering_1~datetime, type="l",
               ylab="Global Active Power (kilowatts)", xlab="")
          lines(Sub_metering_2~datetime,col='Red')
          lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()