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
USNEI <- inner_join(NEI, BSCC, by="SCC")  %>%
          filter(fips==24510)

totalNEI <- collap(USNEI, Emissions ~ year, FUN=list(sum))

options(scipen =999) # dont want to see the scientific notations in the numbers and charts
g5 <- ggplot(totalNEI, aes(year, Emissions))
g5 + 
          geom_point(shape=21, color="black", fill="#69b3a2", size=6) +
          geom_smooth(method="lm") +
          ggtitle("Emissions of PM 2.5 from motor vehicles by year in Baltimore City") +
          labs(x="Year", y="Amount of Emissions (kilotones)") +
          theme(axis.text.y= element_text(angle=90, vjust=1, hjust=1))  # make the y lab vertical
dev.copy(png,"plot5.png", width=480, height=480)
dev.off()  
