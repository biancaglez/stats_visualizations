
# a for loop that uses hacks around some annoying ggplot things and
# also produces charts that are normalized by subgroups created or given 

# function to upper caps - stackoverflow
simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = " ")
}

# function with customized labs and % normalized by groups 
plotList<-list()
for(i in 1:length(simpli1)){
  df<- simpli1 %>%
    group_by(order_type,simpli1[,i]) %>%   # does this work? 
    summarise(count=n()) %>% 
    group_by(order_type) %>% 
    mutate(percent=count/sum(count)*100) 
  
  #rename second var to original thing 
  colnames(df)[2] <- names(simpli1[i])
  
  #okay now I have the multiple chart thing normalized by order amounts
  plotList[[i]]<-ggplot(df,aes_string(x=colnames(df)[2],y=colnames(df)[4], fill=colnames(df)[1]))+
    geom_bar(stat='identity',position='dodge')+
    xlab(simpleCap(sub("_","",colnames(df)[2])))+
    ylab(simpleCap(colnames(df)[4]))+
    ggtitle(simpleCap(sub("_","",paste(colnames(df)[2],"Percentage"))))
}