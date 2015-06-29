library(shiny)

shinyUI(fluidPage(

  titlePanel("Extract Item Response Information from eDirect Geometry Common Core Data Files"),

  sidebarLayout(
    sidebarPanel(
      fileInput("inFile", "Upload CSV from eDirect"), #input$inFile holds the information about the uploaded file, but not the actual file
      uiOutput('downloadFile') #downloadFile is the name of the widget, not the download object
    ), #end of sidebarPanel
    mainPanel(
      
      
    )#end of mainPanel
  )
))
