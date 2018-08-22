# Call this script to load all functions/packages into any R doc

# Load all R packages from other scripts
source("/Users/BiancaGonzalez/Desktop/Faraday/mapping_packages.R")

# call the coverage function 
source("/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/R_functions/coverage_function.R")

# call the ggthemR function 
source("/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/R_functions/ggthemeR_function.R")
ggthemr::ggthemr(fdy, layout="minimal")

# call the counts_tables fn
source("/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/R_functions/count_tables_fn.R")

# call categories mutation fn 
source("/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/R_functions/categories_mutation.R")

# call demo plots fn 
source("/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/point_plots_fn.R")

# for ggplots later
# make this angled
# opts(axis.text.x = theme_text(size = 7, 
#                               hjust = 0, 
#                               vjust = 1,
#                               angle = 310))


