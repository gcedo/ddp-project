
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Trends in immigrants population in Milan"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of countries:",
                  min = 1,
                  max = 50,
                  value = 10)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("demographics")
    )
  )
))
