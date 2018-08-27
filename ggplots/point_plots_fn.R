################################################

setwd('/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/R_functions')
library(tidyverse)

################################################
# scatter plots for potential relationships or patterns for two D data
# ie age and household income 
# http://www.datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html 
# site for point types in ggplot

# to use this fn - call count_tables and use the output from the lists 
# to print -- improve by only selecting only attrs where I know relationships exist

point_plot <- function(private) { 

#take dfs out of list and make a simple ggplot for all three 

# # Make plots.
plot_list = list()

# seq_along (list) here is output from count_tables
for(i in seq_along(list)){
  temp<-list[[i]] %>% filter(!is.na(list[[i]][1])) #filter out nas of the current list at index 1
  p = ggplot(temp, aes_string(colnames(temp)[1], y = colnames(temp)[3])) +geom_point()  # pass string instead of obj
  plot_list[[i]] = p
  
}


# Save plots to tiff. Makes a separate file for each plot.
# for (i in seq_along(list)) {
#   file_name = paste("iris_plot_", i, ".tiff", sep="")
#   tiff(file_name)
#   print(plot_list[[i]])
#   dev.off()
# }

# Create pdf where each page is a separate plot.
pdf("plots_full.pdf")
for (i in seq_along(list)) {
  print(plot_list[[i]])
}
dev.off()

}
