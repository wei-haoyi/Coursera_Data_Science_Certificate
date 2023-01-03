#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


# Load Data

fatals <- read.csv("./Fatal.csv")
library(reshape)
fatalities <- melt(fatals, id=c("State","ID"))
fatalities$variable <- as.numeric(gsub("X","",fatalities$variable))

# Use a fluid Bootstrap layout 
fluidPage(     
    
   # Give the page a title 
   titlePanel("Traffic Fatalities by State, 1994-2020"), 
    
   # Generate a row with a sidebar 
   sidebarLayout(       
     # Define the sidebar with one input 
     sidebarPanel(
               p(strong("Documentation:",style="color:blue"), a("User Help Page",href="https://rpubs.com/econhaoyiwei/ds9-3")),
               selectInput("Region", "Region:",
                           choices=unique(fatalities$State),selected ="USA"),
               sliderInput("sliderX", "Pick Time Range:", 1994, 2020, value=c(2011, 2020),sep=""),
               checkboxInput("show_xlab", "Show/Hide X Axis Label", value=TRUE), 
               checkboxInput("show_ylab", "Show/Hide Y Axis Label", value=TRUE),
               checkboxInput("show_title", "Show/Hide Title", value=TRUE),

       hr(),  #add a horizontal line
       helpText("Data Source: National Highway Traffic Safety Administration") 
     ), 
      
     # Create a spot for the barplot 
     mainPanel(
               h3("Graph of Traffic Fatalities"),
               plotOutput("fatal")   
     ) 
      
   ) 
 ) 
