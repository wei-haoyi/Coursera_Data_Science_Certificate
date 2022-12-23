# load the data

NEI <- readRDS("~/Documents/GitHub/Coursera_Data_Science_Certificate/4_exploratory data analysis/Assignment 2/exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("~/Documents/GitHub/Coursera_Data_Science_Certificate/4_exploratory data analysis/Assignment 2/exdata-data-NEI_data/Source_Classification_Code.rds")


# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.



library(collapse)
library(ggplot2)
library(hrbrthemes)
library(dplyr)

baltNEI <- NEI %>%
          filter(fips==24510)
totalNEI <- collap(baltNEI, Emissions ~ type+year, FUN=list(sum))
totalNEI$type <- as.factor(totalNEI$type )
options(scipen =999) # dont want to see the scientific notations in the numbers and charts
g2 <- ggplot(totalNEI, aes(year, Emissions))
g2 + 
          facet_wrap(~type, nrow=1) +
          geom_point(shape=21, color="black", fill="#69b3a2", size=6) +
          geom_smooth(method="lm") +
          ggtitle("Evolution of Baltimore City PM2.5 Emission") +
          labs(x="Year", y="Amount of Emissions (kilotones)") +
          theme(axis.text.y= element_text(angle=90, vjust=1, hjust=1))  # make the y lab vertical
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()     

