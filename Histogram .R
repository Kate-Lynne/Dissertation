# 01-two-inputs

library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "num", 
              label = "Choose a number", 
              value = 14, min = 1, max = 18),
  textInput(inputId = "title", 
            label = "Write a title",
            value = "Histogram of Number of health boards"),
  plotOutput("hist")
)

server <- function(input, output) {
  output$hist <- renderPlot({
    hist(rnorm(input$num), main = input$title)
  })
}

shinyApp(ui = ui, server = server)