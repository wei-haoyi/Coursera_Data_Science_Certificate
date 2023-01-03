library(shiny)
shinyServer(function(input, output) {
output$text1= renderText(input$slider2+10)
})
