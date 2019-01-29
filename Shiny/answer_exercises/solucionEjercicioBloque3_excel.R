library(xlsx)

ui <- fluidPage(

   passwordInput("pass", "Enter the password", ""),
   actionButton("check", "Check password"),

   uiOutput("myapp")

)

server <- function(input, output) {

  output$sheetsui <- renderUI({
    if (is.null(input$file)) return(invisible(NULL))
    sheetslist <- names(getSheets(loadWorkbook(input$file$datapath)))
    selectInput("sheets", "Select a sheet",sheetslist)
  })  

  dat <- reactive({
    validate(need(input$file, "No data selected yet"))
    read.xlsx(input$file$datapath, input$sheets)
  })

  output$varlistui <- renderUI({
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
            uiOutput("sheetsui"),
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