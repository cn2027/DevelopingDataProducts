# The user-interface definition of the Shiny web app.

pkgTest <- function(x)
{
        if (!require(x,character.only = TRUE))
        {
                install.packages(x,dep=TRUE)
                if(!require(x,character.only = TRUE)) stop("Package not found")
        }
}

pkgTest("shiny")
pkgTest("BH")
pkgTest("rCharts")
pkgTest("data.table")
pkgTest("dplyr")
#pkgTest("DT")

shinyUI(
        navbarPage("Visualize Longley's Economic Regression Data", 
                   #user-interface with a navigation bar.
                   tabPanel("Explore Longley Data",
                            sidebarPanel(
                                    sliderInput("Population", 
                                                "Population:",
                                                min = 107608000,
                                                max = 130081000,
                                                value = c(116000000, 128000000)) 
                                    ),
                            mainPanel(
                                    tabsetPanel(
                                            # Data 
                                            tabPanel(p(icon("table"), "DATASET"),
                                                     dataTableOutput(outputId="dTable")
                                            ), # end of "DATASET" tab panel
                                            tabPanel(p(icon("line-chart"), "Interact with the Data"), 
                                                     h4('Population by Year', align = "center"),
                                                     plotOutput("plotPopulationByYear","400px")
                                            ) # end of "Interact with the Data" tab panel
                                            
                                    )
                                    
                                
                   ), # end of "Interact with the Data" tab panel
                   
                   tabPanel("Explore Longley Data",
                            mainPanel(
                                    includeMarkdown("AboutLongley.Rmd")
                            )
                   ) # end of "About" tab panel
                  
        
        )
        
))
