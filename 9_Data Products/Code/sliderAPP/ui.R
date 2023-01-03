library(shiny)
shinyUI(fluidPage(
    titlePanel("Slider App"),
    sidebarLayout(
        sidebarPanel(
            h1("Move the Slider!"),
            sliderInput("slider2","Slide Me!", 0, 100,0)
        ),
        mainPanel(
           h3("Main Panel Text"),
           textOutput("text1")
        )
    )
))
