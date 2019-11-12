## app.R ##
library(shiny)
library(shinydashboard)
library(DT)
library(timevis)

### Zeitschienen Testdaten

data <- data.frame(
    id      = 1:20,
    content = c("Hornbach", "Coca Cola", "Ferrari", "BMW", "Müller", "Schwartau", "Nestle", "Amazon", "google", "apple", "Commerzbank", "Lufthansa", "SAP", "Starbucks", "Roche", "Eaton", "Novartis", "Danone", "Audi", "VW"),
    start = c("2016-01-10", "2016-01-13", "2016-01-15", "2016-01-17", "2016-01-20", "2016-01-23", "2016-01-25", "2016-01-27", "2016-01-15", "2016-01-18",
              "2016-02-30", "2016-02-13", "2016-03-15", "2016-03-17", "2016-01-29", "2016-02-05", "2016-03-10", "2016-04-25", "2016-02-14", "2016-03-18"),
    end = c("2016-02-10", "2016-02-16", "2016-01-15", "2016-03-17", "2016-03-20", "2016-02-23", "2016-03-25", "2016-03-27", "2016-02-15", "2016-05-18",
              "2016-03-30", "2016-04-13", "2016-02-15", "2016-05-17", "2016-07-29", "2016-08-05", "2016-09-10", "2016-10-25", "2016-04-14", "2016-05-18")
)



ui <- dashboardPage(
    dashboardHeader(
        title = uiOutput("svg"),
        titleWidth = 225
    ),
    dashboardSidebar(
        width = 225,
        sidebarMenu(
        includeCSS("www/css/main.css"),
        includeScript("www/scripts/script.js"),
        menuItem("Kampagnenübersicht", tabName = "kampagnen", icon = icon("dashboard")),
        menuItem("Belegungseinheiten", tabName = "belegungseinheiten", icon = icon("th")),
        menuItem("Spendings", tabName = "spendings", icon = icon("th"))
    )),
    dashboardBody(
        tabItems(
            tabItem(tabName = "kampagnen",
                fluidRow(
                    column(width = 3,
                           box(width = NULL,
                               fileInput("file1", "Upload der PZT Daten",
                                         accept = c(".csv")
                               )
                           )
                )),
                fluidRow(
                    box(width = 12,
                        dataTableOutput("kampagnen_uebersicht")
                    )
                )
            ),
        tabItem(tabName = "belegungseinheiten",
                fluidRow(
                    box(width = 12,
                        timevisOutput("timeline")
                    ),
                    textOutput("text")
                )
        ),
        tabItem(tabName = "spendings",
                fluidRow(
                    box(width = 6,
                        tags$p("Spendings")
                    )
                )
        ))
    )
)

server <- function(input, output, session) {
    
    ### Upload der Daten checken
    table_data <- reactive({
        
        inFile <- input$file1
        
        if(is.null(inFile))
            return(NULL)
        else {
            data <- read.csv(inFile$datapath, stringsAsFactors = FALSE, sep = ";")
            return(data)
        }
    })
    
    output$kampagnen_uebersicht <- DT::renderDataTable(datatable(
        table_data(), rownames = FALSE  
    ))
    
    output$svg <- renderUI({
        HTML('<svg
       xmlns:svg="http://www.w3.org/2000/svg"
       xmlns="http://www.w3.org/2000/svg"
       version="1.0"
       width="80"
       height="80"
       viewBox="0 0 88.596252 87.363747"
       id="svg2430">
      <defs
         id="defs2432" />
      <g
         transform="translate(20.298125,19.681875)"
         id="layer1">
        <path
           d="M 0.0625,67.125 L 0.0625,87.375 L 7.375,87.375 C 12.82125,87.375 17.5,83.0075 17.5,77.40625 C 17.345,71.1825 13.44625,67.124997 8,67.125 L 0.0625,67.125 z M 24.5,67.125 L 16.71875,87.375 L 21.0625,87.375 L 27.125,71.34375 L 32.125,84.09375 L 26.5,84.09375 L 26.5,87.375 L 37.71875,87.375 L 29.78125,67.125 L 24.5,67.125 z M 34.28125,67.125 L 34.28125,70.5625 L 40.84375,70.5625 L 40.84375,87.375 L 45.34375,87.375 L 45.34375,70.5625 L 51.71875,70.5625 L 51.71875,67.125 L 34.28125,67.125 z M 53.4375,67.125 L 53.4375,87.375 L 67.4375,87.375 L 67.4375,84.09375 L 57.78125,84.09375 L 57.78125,78.5 L 66.34375,78.5 L 66.34375,75.0625 L 57.78125,75.0625 L 57.78125,70.5625 L 66.96875,70.5625 L 66.96875,67.125 L 53.4375,67.125 z M 68.0625,67.125 L 76,87.375 L 80.8125,87.375 L 88.59375,67.125 L 77.875,67.125 L 77.875,70.5625 L 83,70.5625 L 78.3125,82.84375 L 72.5625,67.125 L 68.0625,67.125 z M 4.25,70.5625 L 7.6875,70.5625 C 11.11,70.5625 13.4375,73.04875 13.28125,77.25 C 13.12625,81.6075 10.17125,83.937496 6.59375,83.9375 L 4.25,83.9375 L 4.25,70.5625 z "
           transform="translate(-20.298125,-19.681875)"
           style="fill:#00a992;fill-opacity:1;fill-rule:evenodd;stroke:none"
           id="path54962" />
        <path
           d="M -20.298125,42.766875 L 67.980625,42.766875 L 67.980625,-19.681875 L -20.298125,-19.681875 L -20.298125,42.766875 z "
           style="fill:#96d550;fill-opacity:1;fill-rule:nonzero;stroke:none"
           id="path54964" />
      </g>
      </svg>')
    })
    
    ### Zeitschienenvisualisierung
    
    output$timeline <- renderTimevis({
        timevis(data)
    })
    
    output$text <- renderText({
        
        ### timelineval wird aus JavaScript übergeben
        req(input$timelineval)
        
        paste("you clicked on the campaign", input$timelineval)
    })
    
    
    
}

shinyApp(ui, server)