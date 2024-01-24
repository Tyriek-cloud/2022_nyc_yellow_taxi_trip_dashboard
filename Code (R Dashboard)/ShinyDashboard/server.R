# Importing libraries for Dashboard
library(shiny)
library(shinydashboard)

# Load the data frame
df <- read.csv("https://data.cityofnewyork.us/resource/qp3b-zxtp.csv")

# The primary server functionality of the app
shinyServer(function(input, output, session) {
  
  # Reactive function to load the dataset
  loaded_dataset <- reactive({
    read.csv("https://data.cityofnewyork.us/resource/qp3b-zxtp.csv")
  })
  
  # Render histogram based on user-defined bins for the loaded dataset
  output$histogram <- renderPlot({
    hist(loaded_dataset()$fare_amount, breaks = input$bins)
  })
  
  # Render the raw dataset table
  output$rawTable <- renderTable({
    head(loaded_dataset())
  })
  
  # Generate a download link for the loaded dataset (for end-user)
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("raw_dataset_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(loaded_dataset(), file)
    }
  )
  
  # Placeholder for the line chart with linear regression model
  output$lineChart <- renderPlot({
    # Fit a linear regression model
    lm_model <- lm(fare_amount ~ trip_distance, data = df)
    
    # Plot the data points
    plot(df$trip_distance, df$fare_amount, main = "Linear Regression Model", xlab = "Trip Distance", ylab = "Fare Amount")
    
    # Add the regression line
    abline(lm_model, col = "red")
  })
})