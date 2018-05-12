# used for lifestyle attributes to compare multiple audiences (ie package user vs non)
# ie is there a relationship between internet package user and liking travel?

##grabbing lifestyle attribute true counts in table form and producing a chi square test 

##Chi-square test is a nonparametric test that is used to compare more than two variables for a randomly selected data.
#The expected frequencies are calculated based on the conditions of null hypothesis. 
#https://www.statisticssolutions.com/non-parametric-analysis-chi-square/ 
# used as an investigative tool only 

#to use this, this requires a column that can take package type 

# data must have column that differentiates group type
# and must have columns with the different lifestyle variables

# lv1 # lv2 # Group

#     #     # internet_only
#   
#

################################################################

# in script below:change x$group variable

################################################################

chisq_table <- function(x) { 
  
#x<-x[1:55] common troubleshooting: no nulls in a col or will not conduct chi square 
nameList<-names(x)

model<-lapply(nameList, function(n) {
  w <- table(x$group, x[[n]])
  v<-chisq.test(w)
  v[[n]]<- paste(n)  # add a list with the name of the variable in the model 
  
  # threshold value .05 / number of tests for type 1 errors
  if(v$p.value <(.00000002)){ 
    print(v[[n]]) # print variable name if meets threshold val and return
    return(v)
  }
})
}

################################################################

# this for loop does the same thing as the app and calculates the % 
# of lifestyle variables

################################################################
# makes tables for true values and divides by the population size
################################################################

# this lets us add a column with a single val 
package_type <- rep("int",nrow(int))
int_type <- cbind(int , package_type)

# now concatenate into one df  - time for analysis 
package_types<-bind_rows(int_type,cbl_int_type,phone_cbl_int_type)

m<-list()
j<-list()
s<-list()
names<-names(mm)
for(i in 1:length(x)){
  
  int_type<-x[x$group == "int",] # select where meets certain criterion 
  m[[i]]<-table(int_type[[i]]) # going to run through 51 times with each lifestyle var
  m[[i]]<-(m[[i]]/nrow(int_type))*100 # normalize by number of customers 
  
  cbl_type<-x[x$group == "int_cbl",]
  j[[i]]<-table(cbl_type[[i]])
  j[[i]]<-(j[[i]]/nrow(cbl_type))*100
  
  phone_type<-x[x$group =="int_cbl_phone",]
  s[[i]]<-table(phone_type[[i]])
  s[[i]]<-(s[[i]]/nrow(phone_type))*100
}

#function to grab names and store 
names<-lapply(names, function(n) {
  m[[n]]<- paste(n,"group",sep="_")  # add a list with the name of the variable in the model 
})

# apply concatenate function to multiple lists 
lifestyle_percent<-mapply(c, m,j,s,SIMPLIFY=FALSE)

