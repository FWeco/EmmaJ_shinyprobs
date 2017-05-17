## Source global.R file
## This file must be in the same directory as your ui.R and server.R files
source("global.R")


## Build user interface (how your app looks)
shinyUI(
  fluidPage(
    titlePanel("ARS Phase II Research Sites - Flow Alteration Visualizations"),
    sidebarLayout(
      sidebarPanel(radioButtons('radio',label="Select Site Type to Plot",
                                choices=list("Impoundment"=1,"Intake"=2), selected=1),
                   uiOutput('dropdownwithallcsvoptions')),
      
      # Show a radio buttion, dropdown box, qplot, and fdc plot
      mainPanel(
        
        h1("Pre and Post Hydrographs"),
        plotOutput('qplot'),
        h1("Annual Flow Duration Curves"),
        plotOutput('fdcplot')
      )
    )
  )
)
