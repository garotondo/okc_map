library(dplyr)
library(readxl)
library(ggplot2)
library(sf)
library(fs)
library(shiny)
library(shinythemes)
library(gganimate)
library(maps)
library(base)
library(tidyverse)

#Read in my map using read_rds, named it my map
#my_map <- read_rds("/Users/gracerotondo/Desktop/GOV1005\ /p_sets/ps-7-release-garotondo/graphics/map.rds")

# Define UI for application that draws a map
ui <- fluidPage(
    navbarPage("Oklahoma City Traffic Violations", theme = shinytheme("flatly"),
               
               sidebarLayout(
                   sidebarPanel(
                       h4("About"),
                       p("This plot visualizes the locations of traffic citations in Oklahoma City by the race of the violator. 
                         The data is taken from the Stanford Open Policing Project. This graphic was created by Grace Rotondo, 
                         a junior at Harvard College. You can find my Github here:", 
                         tags$a("https://github.com/garotondo/okc_map.git"))
                   ),
                   # Show a map plot of the generated distribution
                   #mainPanel(
                   plotOutput("mapPlot"))))


# Define server logic required to draw a map plot
server <- function(input, output) {
    output$mapPlot <- renderImage({
        x <- read_rds("map.rds")
        anim_save("map.gif", x)
        
        list(src = "map.gif",
             contentType = "image/gif",
             width = "800px", 
             height = "800px",
             align = "right")
    }, deleteFile = FALSE)
}

# Run the application 
shiny_app <- shinyApp(ui = ui, server = server)
