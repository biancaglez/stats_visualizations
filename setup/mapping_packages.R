
# devtools::install_github("tidyverse/ggplot2")

library(lubridate)
load.packages <- function(x){
  package.list <- c("sf","raster","maps","maptools","sp","dplyr",
                    "tidyverse","ggmap","DT","knitr","ggplot2", "Rcpp", "ggpubr", 
                    "Hmisc","corrplot","nortest","tibble","reshape2",
                    "USAboundaries","devtools", "treemap","forecast", "viridisLite",
                    "highcharter", "lubridate", "DataExplorer","googlesheets","doBy")
  
  new.packages <- package.list[!(package.list) %in% installed.packages()[,"Package"]]
  if(length(new.packages)) install.packages(new.packages)
  
  load.libraries <- lapply(package.list, FUN = function(x){
    library(x, character.only = TRUE)
  })
}
load.packages()

# Kendall tau rank correlation non-parametric test for statistical dependence between two ordinal (or rank-transformed) variables
# Kendall_tau_b = (P - Q) / ( (P + Q + Y0)*(P + Q + X0) )^0.5