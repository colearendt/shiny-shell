library(shiny)

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
       
        command_split <- strsplit(input$command, " ", fixed = TRUE)[[1]]
        
        command = command_split[1]
        
        args = paste0(command_split[-1], collapse = " ")
        
       print('Running event reactive')
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
