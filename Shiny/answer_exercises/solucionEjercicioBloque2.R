library(shiny)

ui <- fluidPage(
   
   titlePanel("Distribution exercise"),
   
   sidebarLayout(
      sidebarPanel(
        selectInput("distr", "Choose distr", c("Normal", "Exponential", "Binomial")),
        conditionalPanel("input.distr=='Normal'",
          wellPanel(
            fluidRow(
              column(6, numericInput("mu", "Mean", 0)),
              column(6, numericInput("sd", "SD", 1))
            )
          )
        ),
        conditionalPanel("input.distr=='Exponential'",
          wellPanel(
            numericInput("lambda", "lambda", 1)
          )
        ),
        conditionalPanel("input.distr=='Binomial'",
          wellPanel(
            numericInput("n", "Trials", 10),
            sliderInput("p", "Prob", min=0, max=1, value=0.5, step=0.01)
          )
        )
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("Plot",
            plotOutput("plot")  
          ),
          tabPanel("Summary",
            verbatimTextOutput("summary")
          )
        )
      )
   )
)


server <- function(input, output) {

  output$summary <- renderPrint({
    if (input$distr=="Normal")
      data <- rnorm(1000, input$mu, input$sd)
    if (input$distr=="Exponential")
      data <- rexp(1000, input$lambda)
    if (input$distr=="Binomial")
      data <- rbinom(1000, input$n, input$p)
    summary(data)
  })

  output$plot <- renderPlot({
    if (input$distr=="Normal")
      data <- rnorm(1000, input$mu, input$sd)
    if (input$distr=="Exponential")
      data <- rexp(1000, input$lambda)
    if (input$distr=="Binomial")
      data <- rbinom(1000, input$n, input$p)
    if (input$distr=="Binomial"){
      datafact <- factor(data, levels=0:input$n)
      barplot(table(datafact))
    } else {
      hist(data, main="")
    }
    title(paste("Distr: ", input$distr))
  })

}

# Run the application 
shinyApp(ui = ui, server = server)
