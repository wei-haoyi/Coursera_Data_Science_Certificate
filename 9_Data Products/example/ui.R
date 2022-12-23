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

prpeople <- read.csv("./puertoricansinusa.csv")


# Use a fluid Bootstrap layout 
fluidPage(     
    
   # Give the page a title 
   titlePanel("Puerto Ricans by State"), 
    
   # Generate a row with a sidebar 
   sidebarLayout(       
      
     
     # Define the sidebar with one input 
     sidebarPanel(p(strong("Documentation:",style="color:red"), a("User Help Page",href="http://rpubs.com/joanperez/293126")), 
       selectInput("Region", "Region:",  
                   choices=colnames(prpeople)), 
       hr(), 
       helpText("Puerto Rican Diaspora.") 
     ), 
      
     # Create a spot for the barplot 
     mainPanel( 
       plotOutput("people")   
     ) 
      
   ) 
 ) 
