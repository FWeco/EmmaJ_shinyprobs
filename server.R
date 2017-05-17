## Source global.R file
## This file must be in the same directory as your ui.R and server.R files
source('global.R')
#options(shiny.maxRequestSize=-1)


## Server processing
#options(shiny.maxRequestSize=50*1024^2)

shinyServer(function(input, output, session) {
    
    output$dropdownOutput <- renderPrint({ input$dropdownwithallcsvoptions })
    
    output$radioOutput <- renderPrint({ input$radio }) 
    
    output$dropdownwithallcsvoptions <- renderUI({
      selectInput("dropdownwithallcsvoptions","Select a Site to Plot",
                  unique(qtimeseries_FDC$site))})
    
    #Emma Jones addition - won't run as of 15:04 4-7-17
    output$dropdownwithallcsvoptions <- renderUI({
      if(is.null(indicator()))
      return(NULL)
      selectInput("dropdownwithallcsvoptions","Select a Site to Plot",
                  filter(qtimeseries_FDC,sitetype==indicator())$site
      )})
  
  # Switch is critical for radio buttons and other user input widgets. It transforms the 
  # user input into a format you can use for your own data manipulation or server calls
  
  indicator <- reactive({
    switch(input$radio,"1"="impoundment","2"="intake")})
  
  runsubset <- reactive({
    if(is.null(input$dropdownwithallcsvoptions))
      return(NULL)
    run2 <- filter(qtimeseries_FDC, sitetype == indicator(), site == input$dropdownwithallcsvoptions ) 
    return(run2)
  })
  
  output$qplot <- renderPlot({
    if(is.null(runsubset()))
      return(NULL)
    qplotFunction(runsubset(),indicator())
  })
  
  output$fdcplot <- renderPlot({
    if(is.null(runsubset()))
      return(NULL)
    fdcplotFunction(runsubset(),indicator())
  })
  
  
})