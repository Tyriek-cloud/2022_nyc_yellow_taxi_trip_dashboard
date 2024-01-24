# Importing libraries for Dashboard
library(shiny)
library(shinydashboard)

# Designing the UI 
ui <- shinyUI(
  dashboardPage(
    dashboardHeader(title = "2022 NYC Yellow Taxi",
                    dropdownMenu(type = "message",
                                 messageItem(from = "Fares Charged", message = "We are meeting fare charge goals.", icon = icon("wallet"), time = "01-17-2024"),
                                 messageItem(from = "Tip Update", message =  "Tips are lower than expected.", icon = icon("percent"), time = "22:00"),
                                 messageItem(from = "Meeting Update", message = "Meeting about customer service on Wednesday.", icon = icon("calendar"), time = "01-17-2024")
                    ),
                    dropdownMenu(type = "tasks",
                                 taskItem(
                                   value = 75,
                                   color = "green",
                                   "Update Fare Amounts"
                                 ),
                                 taskItem(
                                   value = 50,
                                   color = "blue",
                                   "Re-check the tolls entered"
                                 ),
                                 taskItem(
                                   value = 25,
                                   color = "red",
                                   "Ensure that congestion charges are applied"
                                 )
                    )
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Raw Dataset", badgeLabel = "New", badgeColor = "red", tabName = "rawDataset")
      )
    ),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "dashboard",
                fluidRow(
                  column(width = 12,
                         infoBox("Top Fare", "$", 240, icon = icon("face-smile")),
                         infoBox("Farthest Distance Traveled", 24.6, "Miles!!!", icon = icon("car")),
                         infoBox("Max Tip Earned in 2022", "$", 40, icon = icon("dollar"))
                  )
                ),
                fluidRow(
                  valueBox(30*100*4, "Gas Budget Per Month", icon = icon("gas-pump"), color = "purple"),
                  valueBox(4*150, "New Tires Ordered", icon = icon("taxi"), color = "red"),
                  valueBox(2*1000, "This Month's Expected Customers", icon = icon("person"), color = "yellow")
                ),
                fluidRow(
                  tabBox(
                    tabPanel(title = "Fare Amounts Histogram", status = "primary", solidHeader = T, background = "blue", plotOutput("histogram")),
                    tabPanel(title = "Histogram Controls", status = "warning", solidHeader = T,
                             "These are controls to alter the bins in the histogram.", br(), br(),
                             sliderInput("bins", "Number of Breaks", 1, 80, 50)
                    )
                  ),
                  column(width = 6, plotOutput("lineChart", height = "465px"))  # Linear model visualization to the right
                )
        ),
        tabItem(tabName = "rawDataset",
                fluidPage(
                  titlePanel("Raw Dataset"),
                  mainPanel(
                    downloadLink("downloadData", "Download"),
                    tableOutput("rawTable")
                  )
                )
        )
      )
    )
  )
)