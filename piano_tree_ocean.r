#Lending Library

#Include libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)

#Create UI
ui <- fluidPage(
  titlePanel("Lending Library"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      selectInput("library_type", label = "Type of Library:",
                  choices = c("Public", "School", "University"), 
                  selected = "Public"),
      submitButton("Submit"),
     ),
     
    # Main Panel
    mainPanel(
      tableOutput("library_table")
    )
  )
)

#Server
server <- function(input, output) {
  library_data <- reactive({data.frame(
    library_type = c("Public", "School", "University"),
    number_books = c(45, 25, 50)
  ) 
  
  # Select data corresponding to selection
  subset(library_data, library_type == input$library_type)
  
  # Display results
  output$library_table <- renderTable({
    return(
      library_data()
    )
  })
}

#Run UI
shinyApp(ui = ui, server = server)