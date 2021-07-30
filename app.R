library(shiny)
library(stringr)

# packages for testing
#library(odbc)

# remove concerning env vars
# (leave a trail)
Sys.setenv("CONNECT_API_KEY"="removed-this-for-security")

ui <- fluidPage(
   
   # Application title
   titlePanel("Shiny Shell!"),
   
   sidebarLayout(
     sidebarPanel = NULL,
      mainPanel = mainPanel(
         "Enjoy a shell where you ought not have one!"
         , textInput('command', label='Enter Command')
         , actionButton('execute', label='Run!')
         , textInput('envir', label='Enter name=value pairs to set environment variables (quoting is weird)')
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
       envir <- input$envir
       print(sprintf('Command: %s',command))
       print(sprintf('Args: %s',args))
       print(sprintf('Env: %s', envir))
       returnval <- system2(command=command, args=args
                           , stdout=TRUE
                           , stderr=TRUE
                           , env = envir)
       
       return(paste(returnval,collapse='\n'))
     }
   )
}

# Run the application 
shinyApp(ui = ui, server = server)
