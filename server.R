library(shiny)

source("AddVariables.R")

shinyServer(function(input, output) {
  
  #This determines when to call the fuction that processes the data
  OutFile = reactive (
    if(is.null(input$inFile)){  #If nothing has been uploaded,
      return(NULL) #don't do anything yet
    } else {  #if something has been uploaded,
      x = AddVariables(input$inFile) #call the function that processes the data
      return(x)}
    ) #end of reactive
  
  
  #This creates the file to be downloaded
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')  #This is the name of the file
    },
    content = function(file) {  #the argument "file" means absolutely nothing, but must appear here and on the next line
      write.csv(OutFile(), file)
    }
  ) #end of downloadHandler
  
  
  #This creates the download button
  output$downloadFile <- renderUI({
    if (is.null(OutFile())){ #if the output hasn't been created yet,
      return(NULL) #do nothing
    } else  { #if the output has been created,
      return(downloadButton('downloadData')) #created a download button that links to file that will be downloaded
    }
  }) #end of rednerUI
  
})# end of shinyServer