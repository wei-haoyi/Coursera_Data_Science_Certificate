ls#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plyr)
library(plotly)
library(scales)

# Load Data

fatals <- read.csv("./Fatal.csv")
library(reshape)
fatalities <- melt(fatals, id=c("State","ID"))
fatalities$variable <- as.numeric(gsub("X","",fatalities$variable))


# Define a server for the Shiny app 
 function(input, output) { 
    
   # Fill in the spot we created for a plot 
   output$fatal <- renderPlot({ 
             state <- input$Region
             minX <- input$sliderX[1]
             maxX <- input$sliderX[2] 
             final_data <- fatalities %>%
                       filter(State==state) %>%
                       filter(variable>=minX & variable<=maxX)
             maxvalue <- max(final_data$value)
             roundmax <- plyr::round_any(maxvalue,1000, f=ceiling)
             roundmax1 <- ifelse(roundmax>0 & roundmax<100000,roundmax,50000)
             xlab <- ifelse(input$show_xlab, "Year", "")
             ylab <- ifelse(input$show_ylab, "Number of Traffic Fatalitie","")
             main <- ifelse(input$show_title, input$Region, "")             
     # Render a plot 
ggplot(final_data, aes(variable, value)) +
          geom_line(color="red") +
          geom_point(color="black") +
          theme_bw() +
          xlab(xlab) +
          ylab(ylab) +
          xlim(minX,maxX) +
          ylim(0,roundmax1)+
          ggtitle(main) +
          scale_x_continuous(breaks= pretty_breaks())

          
          
# plot(final_data$variable, 
#           final_data$value,
#           type = "l",
#           xlab=xlab,
#           ylab=ylab,
#           xlim=c(minX,maxX), 
#           ylim=c(0,roundmax1),
#           main=main) 
   })
 }

