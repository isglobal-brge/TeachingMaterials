library(Hmisc)

ui <- fluidPage(

   passwordInput("pass", "Enter the password", ""),
   actionButton("check", "Check password"),

   uiOutput("myapp")

)

server <- function(input, output) {

  dat <- reactive({
    spss.get(input$file$datapath)
  })

  output$varlistui <- renderUI({
    validate(need(input$file, "No data selected yet"))
    selectInput("varlist", "Select the variables", names(dat()), multiple=TRUE)
  })

  output$summary <- renderPrint({
    validate(need(input$file, "No data selected yet"))
    validate(need(input$varlist, "Select at least one variable"))
    summary(dat()[,input$varlist])
  })

  output$down <- downloadHandler(
    filename = function() "data.csv",
    content = function(ff) {
      write.table(dat(), file=ff, sep=";", row.names=FALSE)
    }
  )

  output$myapp <- renderUI({
    if (input$check==0) return(invisible(NULL))
    isolate({
      if (input$pass=='') return("Enter the password")
      if (input$pass!='123') return("Incorrect")
      tagList(
        titlePanel("Summary"),
        sidebarLayout(
          sidebarPanel(
            fileInput("file", ""),
            uiOutput("varlistui")
          ),
          mainPanel(
            verbatimTextOutput("summary"),
            downloadButton('down', 'Download data')
          )
        )
      )
    })
  })

}

shinyApp(ui = ui, server = server)