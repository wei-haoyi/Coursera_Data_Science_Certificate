# server.R ####
# Coursera Data Science Capstone Project (https://www.coursera.org/course/dsscapstone)
# Shiny server script
# 2023-01-03

# Libraries and options ####
source('prediction.R')

library(shiny)

# Define application ####

shinyServer(function(input, output) {

# Reactive statement for prediction function when user input changes ####
    prediction =  reactive( {
        
        # Get input
        inputText = input$text
        nSuggestion = input$slider
        
        # Predict
        prediction = fun.predict(inputText, n = nSuggestion)
    })

# Output data table ####
output$table = renderDataTable(prediction(),
                            option = list(pageLength = 5,
                                        lengthMenu = list(c(5, 10, 50), c('5', '10', '50')),
                                        columnDefs = list(list(visible = F, targets = 1)),
                                        searching = F
                                        )
                                )

# Output word cloud ####
wordcloud_rep = repeatable(wordcloud)
output$wordcloud = renderPlot(
                        wordcloud_rep(
                            prediction()$NextWord,
                            prediction()$count,
                            colors = brewer.pal(8, 'Dark2'),
                            scale=c(4, 0.5),
                            max.words = 300
                            )
                    )
})
