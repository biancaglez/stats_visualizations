
# next want to make functions that take multiple arguments and can facet to create things by different incomes
# # facet_grid(~sex) +

# initialize data - will have to read the csv and define list of variables interested in (demographics) etc
demo_plots <- function(private) { 
  
#########################################################################################################################
# this demographic vector showcases what we are usually interested in   
demo_vec<- c("gender","household_income","favm","number_of_children",
             "marital_status","age_cats","education","occupation_type","beds","number_of_rooms")  
na.list<-list() 
listy<-list()
temp_df<-data.frame()
plot_list<-list()

# select these dem_vec variables and IDs
private<-private %>% select(demo_vec,id)

for(i in 1:length(demo_vec)){
  
  #get only non-na vals
  na.list[[i]] <- private %>% filter(eval(parse(text=paste("!is.na(",demo_vec[i],")",sep=""))))
  temp_df<- na.list[[i]]
  
  #get percentages of all selected vars
  listy[[i]]<-temp_df %>% group_by(temp_df[,i]) %>% tally() %>% rename(count=n) %>% 
    mutate(percent = (count/sum(count)*100)) 
  
  #rename assignements
  temp_df2<-listy[[i]]
  temp_names<-demo_vec[i]
  
  names(temp_df2)[1] <- temp_names
  
  #plot thing
  p<-ggplot(data=temp_df2, aes_string(x= colnames(temp_df2)[1], y = colnames(temp_df2)[3])) + geom_bar(stat='identity')+xlab(colnames(temp_df2)[1])+ylab(colnames(temp_df2)[3])+ggtitle(paste(colnames(temp_df2)[1],"percentage")) + scale_x_continuous(labels = scales::comma) + theme(axis.text.x = element_text(angle = 40, hjust = 1))
  plot_list[[i]] = p
 
  
}

# R functions don't return multiple objects
return(plot_list)
}

# customize certain plots - household income
hh_plot<-plot_list[[2]]
hh_plot
hh_plot + scale_x_continuous(name="Household Income", limits=c(0, 200000)) + ggtitle("Household Income % Breakdown") + scale_x_continuous(labels = scales::dollar)+xlab("Household Income") + scale_y_continuous(labels = scales::percent)



