pkgTest <- function(x)
{
        if (!require(x,character.only = TRUE))
        {
                install.packages(x,dep=TRUE)
                if(!require(x,character.only = TRUE)) stop("Package not found")
        }
}

pkgTest("shiny")

# Load data processing file
source("DATA_PROCESSING.R")
#themes <- sort(unique(data$theme))

# Shiny server
shinyServer(
        function(input, output) {
                #     output$text1 <- renderText({input$text1})
                #     output$text2 <- renderText({input$text2})
                output$dTable <- renderDataTable({
                        data
                } #, options = list(bFilter = FALSE, iDisplayLength = 50)
                )
                
                output$plotPopulationByYear <- renderChart({
                        plotPopulationByYear(data) 
                })
                
                output$PopulationByEpoch <- renderChart({
                        PopulationByEpoch(data)
                })
                
        } # end of function(input, output)
)
