# load the data

NEI <- readRDS("~/Documents/GitHub/Coursera_Data_Science_Certificate/4_exploratory data analysis/Assignment 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Documents/GitHub/Coursera_Data_Science_Certificate/4_exploratory data analysis/Assignment 2/exdata-data-NEI_data/Source_Classification_Code.rds")


# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(collapse)
library(ggplot2)
library(hrbrthemes)
library(dplyr)

BSCC <- SCC %>%
          filter(grepl("(.*)(Highway Veh)(.*)", Short.Name))
NEI$fips <- as.numeric(NEI$fips)
BSCC$fips <- as.numeric(BSCC$fips)

BNEI <- inner_join(NEI, BSCC, by="SCC") %>%
          filter(fips==06037|fips==24510)

totalNEI <- collap(BNEI, Emissions ~ fips+year, FUN=list(sum))

totalNEI$fips <- as.factor(totalNEI$fips )

options(scipen =999) # dont want to see the scientific notations in the numbers and charts
g6 <- ggplot(totalNEI, aes(year, Emissions))
g6 + 
          geom_point(aes(color=fips)) +
          geom_smooth(method="lm",aes(color=fips)) +
          ggtitle("Emissions of PM 2.5 from motor vehicles by year") +
          labs(x="Year", y="Amount of Emissions (kilotones)") +
          scale_color_manual(labels=c('Baltimore City','Los Angeles County'), values=c("blue","red")) +
          theme(axis.text.y= element_text(angle=90, vjust=1, hjust=1))  # make the y lab vertical
dev.copy(png,"plot6.png", width=480, height=480)
dev.off()  
