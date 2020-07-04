#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
if(!exists("getShipNames", mode="function")) source("db.R")
if(!exists("getShipObservations", mode="function")) source("db.R")
if(!exists("getLongestObservation", mode="function")) source("observations.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    # First we observe value of select_ship_types if it is changed we load
    # new set of ship names
    # Next we observe on select_ship_names if it is changed we load a new
    # set of observations from which we select 2 consecutive points which
    # have greatest distance.
    # From the data set we visualize observations on the map, list the
    # observations in the table and provide the distance.
    
    observe({
        x <- input$select_ship_types
        getReactiveShipNames <- reactive({getShipNames(x)})
        shipNames <- getReactiveShipNames()
        updateSelectInput(session, "select_ship_names",
                          choices = shipNames
        )
    })
    
    observe({
        x <- input$select_ship_names
        getReactiveObservations <- reactive({getShipObservations(x)})
        observations <- getReactiveObservations()
        
        if(nrow(observations)!=0){
            results = getLongestObservation(observations)
            distance = results[[1]]
            observations <- as.data.frame(results[2:5])
            
            output$data <- renderTable({
                observations
            })
            
            output$mymap <- renderLeaflet({
                leaflet(data = observations) %>%
                    addProviderTiles(providers$Stamen.TonerLite,
                                     options = providerTileOptions(noWrap = TRUE)
                    ) %>%
                    addMarkers(~LON, ~LAT, popup = ~DESTINATION) %>%
                    addPolylines(~LON, ~LAT)
            })
            
            output$observation_description <- renderText({
                paste("The longest distance between 2 consecutive points is ", distance)
            })
        }
    })

})
