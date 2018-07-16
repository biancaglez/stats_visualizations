################################################

setwd('/Users/BiancaGonzalez/Desktop/Faraday/function_scripts')


################################################

# this function is to generate graphs for cont data types (numeric)

# make plots for numeric or continous type    
pz = list()  
for (i in seq_along(list)) {
  
  #get first data frame 
  temp <- list[[i]] %>% filter(!is.na(list[[i]][1]))
   
  for(j in seq_along(temp)){
    
	# if this data type make these charts 
     if (class(temp[j][[1]]) == "integer" | class(temp[j][[1]]) == "numeric" | class(temp[j][[1]]) == "double") {
  
   k = ggplot(temp, aes_string(colnames(temp)[1], y = colnames(temp)[2])) + geom_bar(stat='identity')  # pass string instead of obj
   pz[[i]] = k
    }
  } 

}

