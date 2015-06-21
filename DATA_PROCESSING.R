#setwd("/Users/ChannyNic/Documents/Coursera/DevelopingDataProducts")
pkgTest <- function(x)
{
        if (!require(x,character.only = TRUE))
        {
                install.packages(x,dep=TRUE)
                if(!require(x,character.only = TRUE)) stop("Package not found")
        }
}

# Load required libraries
pkgTest("data.table")
pkgTest("sqldf")
pkgTest("dplyr")
#pkgTest("DT")
pkgTest("rCharts")

# Read data
data("longley")
data <- longley
head(data)
setnames(data, "GNP.deflator", "GNPDeflator")
setnames(data, "Armed.Forces", "ArmedForces")
#data$Year <- as.POSIXct(as.character(data$Year))
# Exploratory data analysis
sum(is.na(data)) # 0
length(unique(data$GNPDeflator)) # 16
table(data$Year) # 1947 - 1962
length(table(data$Year)) # 16
#sqldf("SELECT distinct year FROM data") 


## Helper functions
#' Plot number of Unemployed by Before and After 1955
#' 
#' @param dt data.table
#' @param Population
#' @param xlab Year
#' @param ylab Populations
#' @return PopulationByYear1 plot

plotPopulationByYear <- function(dt){
        PopulationByYear <- ggplot(data = dt, 
                                    mapping=aes(x=Year,
                                    y = Population,color=Population))
        PopulationByYear<- PopulationByYear +  geom_point()
        PopulationByYear<- PopulationByYear + scale_color_gradient2(low = "blue", mid = "white", high = "green", midpoint = median(data$Population))
        return(PopulationByYear)
}

#' Aggregate dataset by years before and after 1955
#' 
#' @param dt data.table
#' @param Year
#' @return result
#'
GroupBy1955 <- function(dt) {
        this.subset<-subset(dt,Year < 1955)
        this.subset["Before1955"] <- 1
        this.subset2 <- subset(dt,Year >= 1955)
        this.subset2["Before1955"] <- 0
        result<-rbind(this.subset,this.subset2)
        return(result)
}

#' Plot number of Unemployed by Before and After 1955
#' 
#' @param dt data.table
#' @param Population
#' @param Year
#' @param Before1955
#' @param ylab Population
#' @param xlab Epoch
#' @return PopulationByEpoch plot
PopulationByEpoch <- function(dt){
        Grouped<-GroupBy1955(dt)
        PopulationByEpoch <- qplot(factor(Before1955),
                y = Population,
                data = Grouped, 
                geom=c("boxplot","jitter"),
                xlab="Epoch",
                ylab="Population")
        PopulationByEpoch<- PopulationByEpoch + scale_x_discrete(breaks=c(0,1), labels=c("Before 1955","After 1955"))
        return(PopulationByEpoch)
}

#' Plot number of Unemployed by Before and After 1955
#' 
#' @param dt data.table
#' @param Unemployed
#' @param Year
#' @param Population
#' @return plotUnemploymentByYear plot
plotUnemploymentByYear <- function(dt){
        UnemploymentByYear <- ggplot(data = dt, 
                                   mapping=aes(x=Year,
                                               y = Unemployed,color=Population))
        UnemploymentByYear<- UnemploymentByYear +  geom_line()
        UnemploymentByYear<- UnemploymentByYear + scale_color_gradient2(low = "blue", mid = "white", high = "green", midpoint = median(data$Population))
        return(UnemploymentByYear)
}
