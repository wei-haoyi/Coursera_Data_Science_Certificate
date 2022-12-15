# load the data

NEI <- readRDS("~/Documents/GitHub/Coursera_Data_Science_Certificate/4_exploratory data analysis/Assignment 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Documents/GitHub/Coursera_Data_Science_Certificate/4_exploratory data analysis/Assignment 2/exdata-data-NEI_data/Source_Classification_Code.rds")


# Have total emission from PM2.5 decreased in US from 1999 to 2008?

library(collapse)
library(ggplot2)
library(hrbrthemes)
totalNEI <- collap(NEI, Emissions ~ year, FUN=list(sum))

options(scipen =999) # dont want to see the scientific notations in the numbers and charts
g1 <- ggplot(totalNEI, aes(year, Emissions))
g1 + 
          geom_point(shape=21, color="black", fill="#69b3a2", size=6) +
          geom_line(color="grey") +
          theme_ipsum() +
          ggtitle("Evolution of U.S. PM2.5 Emission") +
          labs(x="Year", y="Amount of Emissions (kilotones)") +
          theme(axis.text.y= element_text(angle=90, vjust=1, hjust=1))  # make the y lab vertical
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()     


          
