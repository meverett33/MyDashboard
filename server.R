library(shiny)
library(shinydashboard)
library(ggplot2)
library(readr)
library(dplyr)

shinyServer(function(input, output, session) {
  
  df <- reactiveFileReader(
    intervalMillis = 20000, 
    session = session,
    filePath = 'https://covidtracking.com/data/download/all-states-history.csv',
    readFunc = read_csv)
  
  df1 <- reactive({
    df() %>% filter(state == input$state, date > input$dates[1]) %>%
      filter(date < input$dates[2])
    })
  
  output$ncases <- renderValueBox({
    cases <- summarize(df1() %>% select(positiveIncrease), 
                       Total = sum(positiveIncrease))
    valueBox(
      value = cases$Total,
      subtitle = "Number of Cases",
      icon = icon("table"),
      color = "aqua"
    )
  })
  
  output$nhosp <- renderValueBox({
    hospitalized <- summarize(df1() %>% select(hospitalizedIncrease), 
                              Hospital = sum(hospitalizedIncrease))
    valueBox(
      value = hospitalized$Hospital,
      subtitle = "Number Hospitalized",
      icon = icon("list"),
      color = "purple"
    )
  })
  
})
