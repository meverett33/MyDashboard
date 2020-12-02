library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(
    selectInput("state", "Please select a state:", choices = state.abb),
    dateRangeInput("dates", "Please select a date range:")
  ),
  dashboardBody(
    fluidRow(
      valueBoxOutput(width=4, "ncases"),
      valueBoxOutput(width=6, "nhosp")
    )
  )
)
