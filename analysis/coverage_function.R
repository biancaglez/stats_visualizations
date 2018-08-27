
################################################

setwd('/Users/BiancaGonzalez/Desktop/Faraday/function_scripts')

################################################

#assumption both have equal rates of non-coverage 
#full is full dataset - works if importing and correcting for falses in fdy data

coverage_function <- function(full) {

#grab NA sums tots
NAS_tots <- sapply(full, function(x) sum(is.na(x)))  #sum of NAS across columns
total <- nrow(full) #total records

# calculate percentage of coverage by variable 
coverage_percent <- sapply(NAS_tots, function(x) (total-x)/total)
coverage_df<-data.frame(as.list(coverage_percent))


# make df into tidy long format and with col name "variable" and "percent"
coverage_tidy <- gather(data = coverage_df,
                        key = variables,
                        value = percent)
return(coverage_tidy)
}
