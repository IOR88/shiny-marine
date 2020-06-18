library(shiny)
if(!exists("server", mode="function")) source("server.R")
# if(!exists("ui", mode="function")) source("ui.R")

ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data Modified"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      textOutput("testing_var")
    )
  )
))

shinyApp(ui = ui, server = server)