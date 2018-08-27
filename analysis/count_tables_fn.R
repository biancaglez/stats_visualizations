################################################

setwd('/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/R_functions')


################################################

# function that can later take any data and calculate the % of groups

counts_tables <- function(private) { 
  
  list<-list()
  for (i in 1:length(private)) {
    list[[i]] <- private %>% group_by(private[,i]) %>% tally() %>% rename(count=n) %>% 
      mutate(percent = (count/sum(count)*100)) 
    
    
  }
  
  #set column names
  np <- names(private)
  for (i in seq_along(list)){
    colnames(list[[i]])[1] <- np[i] #colnames of list at index 1, set to names of private
  }
  
  # everything stored in list - return list 
  return(list)
  # save list 
  
  
  # make tables pretty in RMD  if desired 

  table_list<- list()
  for(i in seq_along(list)){
    table_list[[i]]<-list[[i]] %>% head() %>% 
      kable(digits=2, 
            booktabs = TRUE) 
    print(table_list[[i]])
    
  }
}
