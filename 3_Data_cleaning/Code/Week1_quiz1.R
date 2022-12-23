# Course 3 Data cleaning
# Week 1, quiz1

# Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#
# and load the data into R. The code book, describing the variable names is here:
#
#   c
#

setwd("~/Documents/GitHub/Coursera_Data_Science_Certificate/3_Data_cleaning")
# How many properties are worth $1,000,000 or more?

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv","../Data/acs/acs.csv")
acs <-read.csv("../Data/acs.csv")

# VAL
idahol <- acs %>%
  filter(ST=="16" & VAL==24)

nrow(idahol)

# 2. Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

# 3.
# Question 3
# Download the Excel spreadsheet on Natural Gas Aquisition Program here:
#
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
#
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx","../Data/natural_gas/naturalg.xlsx")

library("readxl")
ns <- read_excel("../Data/natural_gas/naturalg.xlsx",range=cell_rows(18:23))
dat <- ns[,7:15]
sum(dat$Zip*dat$Ext,na.rm=T)

# 4

install.packages("XML")

library(XML)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml","../Data/BaltimoreResturant/Brest.xml")
result <- xmlTreeParse("../Data/BaltimoreResturant/Brest.xml",useInternal=T)
rootnode <-xmlRoot(result)
sum(xpathSApply(rootnode,"//zipcode",xmlValue) == 21231)

