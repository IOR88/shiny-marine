#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

if(!exists("getShipTypes", mode="function")) source("db.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Marine ships observations."),

    # Sidebar with a slider input for number of bins
    
    sidebarLayout(
        
        sidebarPanel(
            selectInput(inputId = "select_ship_types", label = strong("Ship Type"),
                        choices = getShipTypes()
            ),
            selectInput(inputId = "select_ship_names", label = strong("Ship Name"),
                        choices = c()
            )
        ),

        mainPanel(
            textOutput("observation_description"),
            leafletOutput("mymap"),
            tableOutput("data")
        )
    )
))


