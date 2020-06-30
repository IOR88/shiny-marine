#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
if(!exists("getShipNames", mode="function")) source("db.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
#    output$data <- renderTable({
#        getShipNames(input$select_ship_types)
#    })
    
    observe({
        x <- input$select_ship_types
        
        updateSelectInput(session, "select_ship_names",
                          choices = getShipNames(x)
        )
    })

    
#    output$observation_description <- renderText({
#        input$select_ship_types
#    })

})
