# ui.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny UI script
# 2023-01-03

# Libraries and options ####
library(shiny)
library(shinythemes)
library(png)

# Define the app ####

shinyUI(fluidPage(

    # Theme
    theme = shinytheme("journal"),
    
    # Application title
    titlePanel("Next Word Predictor"),
    img(src = 'view.png', height = 200, width = 1100,style="display: block; margin-left: auto; margin-right: auto;"),
    br(),

# Sidebar ####    
    sidebarLayout(
        
        sidebarPanel(
        
        # Text input
        textInput("text", label = ('Please enter some text for prediction'), value = ''),
        
        # Number of words slider input
        sliderInput('slider',
                    'Maximum number of predicted words',
                    min = 0,  max = 50,  value = 10
        ),
        br(),
        h5('Instructions'),
        helpText("This application is for guessing the next word you are going to write."),
        helpText("The next word is guessed using the frequency of combinations of one,two, three words."),
        helpText("The frequency is calculated using text extracted from blogs, news and twitter that SwiftKey  gives for this projects"),
        helpText("The suggested word was ranked by its frequency in the one-gram corpus when there is no hint for guessing or no matched-pattern is found"),
        helpText("When you type some words, the right-hand side will give you a list of suggest words ranked by its probability and a word cloud of the suggested word."),
        helpText("You can slide the slider to set the maximum number of suggested word"),
        helpText("Have fun! Thank you!")
        ,
        # Link to report
        helpText(a('More information on the app',
                   href='https://rpubs.com/econhaoyiwei/finalslides', 
                   target = '_blank')
        ),
        
        # Link to repo
        helpText(a('Code repository',
                   href='https://github.com/wei-haoyi/Coursera_Data_Science_Certificate/tree/main/10_Data%20Science%20Capstone/shiny',
                   target = '_blank')
        )
        
        ),

# Mainpanel ####

        mainPanel(
            
            wellPanel(
                      
        # Table output
        dataTableOutput('table'),
        
        # Wordcloud output
        plotOutput('wordcloud')
        ),

        # add some description
        p("This shiny application is created by Haoyi Wei.")
    ) 
)
)
)
