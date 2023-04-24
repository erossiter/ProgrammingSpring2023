library(shiny)

# Basic set up -----

# Define UI
ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(
      # Add input controls here
    ),
    mainPanel(
      # Add output controls here
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Add server logic here
}

# Run the app
shinyApp(ui = ui, server = server)


# Example -----

# Define UI
ui <- fluidPage(
  titlePanel("Central Limit Theorem"),
  sidebarLayout(
    sidebarPanel(
      # Add input controls here
      numericInput(inputId = "reps",
                   label = "Replications:",
                   value = 1000, min = 1, max = 10000),
      numericInput(inputId = "n",
                   label = "Sample Size:",
                   value = 1000, min = 1, max = 10000),
      selectInput(inputId = "dist",
                  label = "Distribution:",
                  choices = c("Uniform", "Normal", "Exponential"),
                  selected = "Uniform"),
      actionButton(inputId = "run",
                   label = "Run Simulation")
    ),
    mainPanel(
      # Add output controls here
      plotOutput(outputId = "plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Add server logic here
  # Generate samples and plot distribution of sample means
  observeEvent(input$run, {
    # Generate random samples
    if(input$dist == "Uniform"){
      samples <- replicate(n = input$reps, runif(input$n))
      pop_mean <- .5
    }else if(input$dist == "Normal"){
      samples <- replicate(n = input$reps, rnorm(input$n))
      pop_mean <- 0
    }else if(input$dist == "Exponential"){
      samples <- replicate(n = input$reps, rexp(input$n, rate = 1))
      pop_mean <- 1
    }
     
    
    # Calculate the means of each sample
    sample_means <- apply(samples, 2, mean)
    
    # Plot the distribution of sample means
    output$plot <- renderPlot({
      hist(sample_means,
           main = "Distribution of Sample Means",
           xlab = "Sample Mean")
      
      # Add a vertical line at the population mean
      abline(v = pop_mean, col = "red")
      
    })
  })
}

# Run the app
shinyApp(ui = ui, server = server)
