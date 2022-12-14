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

## plot 1
## Create the histogram
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()