library(shiny)
library(stringr)

# package for testing
library(odbc)

ui <- fluidPage(
   
   # Application title
   titlePanel("Shell App!"),
   
   sidebarLayout(
     sidebarPanel = NULL,
      mainPanel = mainPanel(
         "Enjoy a shell where you ought not have one!"
         , textInput('command', label='Enter Command')
         , actionButton('execute', label='Run!')
         , verbatimTextOutput("text")
      )
   )
)

server <- function(input, output) {
   
   output$text <- eventReactive(
     input$execute, {
       
       print('Running event reactive')
       first_space <- str_locate(input$command,' ')[[1,'start']]
       if (!is.na(first_space)) {
         command <- str_sub(input$command,1,first_space-1)
         args <- str_sub(input$command,first_space+1)
       } else {
         command <- input$command
         args <- character()
       }
       print(sprintf('Command: %s',command))
       print(sprintf('Args: %s',args))
       returnval <- system2(command=command, args=args
                           , stdout=TRUE
                           , stderr=TRUE)
       
       return(paste(returnval,collapse='\n'))
     }
   )
}

# Run the application 
shinyApp(ui = ui, server = server)

