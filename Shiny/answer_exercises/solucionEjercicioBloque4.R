library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)
library(shinyjqui)
library(shinyFeedback)

ui <- fluidPage(
  
  useShinyFeedback(),

  titlePanel("Distribution exercise"),
   
  theme = shinytheme("united"),
   
  HTML("<style type='text/css'> #leftPanel{background-color: rgb(230,230,230); border: 2px solid grey; box-shadow: 2px 2px 1px #888888;} </style>"),
  HTML("<style type='text/css'> #optionsNormal, #optionsExponencial, #optionsBinomial {background-color: rgb(50,50,50);color:white} </style>"),
        
   
  sidebarLayout(
      sidebarPanel(id="leftPanel",
        actionButton("help", "Help"),
        br(),br(),                   
        selectInput("distr", "Choose distr", c("Normal", "Exponential", "Binomial")),
        conditionalPanel("input.distr=='Normal'",
          wellPanel(id="optionsNormal",
            fluidRow(
              column(6, numericInput("mu", "Mean", 0)),
              column(6, numericInput("sd", "SD", 1))
            )
          )
        ),
        conditionalPanel("input.distr=='Exponential'",
          wellPanel(id="optionsExponencial",
            numericInput("lambda", "lambda", 1)
          )
        ),
        conditionalPanel("input.distr=='Binomial'",
          wellPanel(id="optionsBinomial",
            numericInput("n", "Trials", 10),
            sliderInput("p", "Prob", min=0, max=1, value=0.5, step=0.01)
          )
        )
      ),
      
      mainPanel(
        bsCollapse(open=c("Plot"), multiple=TRUE,
          bsCollapsePanel("Plot", style="primary",
            jqui_resizabled(plotOutput("plot", "600px", "500px"))
          ),
          bsCollapsePanel("Summary", style="primary",
            verbatimTextOutput("summary")
          )
        )        
      )
   ),
   bsTooltip("help","Click here to know more about this app"),
   bsModal("helpModal","Help","help",
    HTML("<p>This app shows some well known statistical distribution<p>")
   )

)

server <- function(input, output) {
  
  observe({
   feedback("sd", condition=input$sd<0,
      text="SD must be positive", color="red")
   feedback("lambda", condition=input$lambda<0,
      text="lambda must be positive", color="red") 
   feedback("n", condition=!is.integer(input$n) | input$n<0,
      text="n must be a positive integer", color="red")        
  })  

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

shinyApp(ui,server)
