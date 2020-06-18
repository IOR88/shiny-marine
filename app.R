library(shiny)
if(!exists("server", mode="function")) source("server.R")
if(!exists("ui", mode="function")) source("ui.R")
shinyApp(ui = ui, server = server)