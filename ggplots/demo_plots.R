
# this function thing will help us produce basic plots for the : " Basic Customer Profiling " sections in reports

demo_plots <- function(private) { 
#########################################################################################################################
# this demographic vector - most popular vars
demo_vec<- c("gender","household_income","favm","number_of_children",
             "marital_status","education","beds","number_of_rooms")  

# select these dem_vec variables and IDs
private<-private %>% select(demo_vec,id)

# initialize lists
na.list<-list() 
listy<-list()
temp_df<-data.frame()
plot_list<-list()
char_plots<-list()

for(i in 1:length(demo_vec)){
  
  #get only non-na vals
  na.list[[i]] <- private %>% filter(eval(parse(text=paste("!is.na(",demo_vec[i],")",sep=""))))
  temp_df<- na.list[[i]]
  
  #get percentages of all selected vars
  listy[[i]]<-temp_df %>% group_by(temp_df[,i]) %>% tally() %>% rename(count=n) %>% 
    mutate(percent = (count/sum(count)*100)) 
  
  #rename Rsux
  temp_df2<-listy[[i]]
  temp_names<-demo_vec[i]
  names(temp_df2)[1] <- temp_names
  
  
  # if char provide discrete scale for plots
  if (is.character(temp_df2[[1]]) == TRUE) {
   
    p<-ggplot(data=temp_df2, aes_string(x= colnames(temp_df2)[1], y = colnames(temp_df2)[3])) + geom_bar(stat='identity')+xlab(colnames(temp_df2)[1])+ylab(colnames(temp_df2)[3])+ggtitle(paste(colnames(temp_df2)[1],"percentage")) + theme(axis.text.x = element_text(angle = 40, hjust = 1))+ scale_x_discrete()
    plot_list[[i]] = p
    
  # else provide continous scale plots (numeric)
  } else {
    p<-ggplot(data=temp_df2, aes_string(x= colnames(temp_df2)[1], y = colnames(temp_df2)[3])) + geom_bar(stat='identity')+xlab(colnames(temp_df2)[1])+ylab(colnames(temp_df2)[3])+ggtitle(paste(colnames(temp_df2)[1],"percentage")) + theme(axis.text.x = element_text(angle = 40, hjust = 1))+ scale_x_continuous(labels = scales::comma) 
    plot_list[[i]] = p
  }
  # R functions don't return multiple objects
  return(plot_list)
  
  }
}

plot_list[[1]] # + scale_x_discrete()


# customize certain plots even moreee - household income
hh_plot<-plot_list[[2]]
hh_plot + scale_x_continuous(name="Household Income", limits=c(0, 200000)) + ggtitle("Household Income % Breakdown") + scale_x_continuous(labels = scales::dollar)+xlab("Household Income") + scale_y_continuous(labels = scales::percent)


# next want to make functions that take multiple arguments and can facet to create things by different incomes
# # facet_grid(~sex)


