
setwd("/Users/BiancaGonzalez/Desktop/Faraday/Lifestyle_Reduction")

##load all functions
source("/Users/BiancaGonzalez/Desktop/Faraday/function_scripts/load_all_functions.R")

# lifestyle variable
# grab your own lifestyle variables data using audience method in terminal 
# https://paper.dropbox.com/doc/Getting-data-from-FIG-TW0OKILp5uL9Exeqat4Gk


lifestyle<-read.csv('~/Desktop/Faraday/chloropleth_maps/btcomm_lifestyle_success.csv')

################################################################################

## script looks at correlation pairs of lifestyle variables 
 
################################################################################

lifestylevars<-names(lifestyle)

# grab only people that have lifestyle == t set (hack for data inconsistencies)
only_lifestyle<-select(returned, one_of(lifestylevars)) 

# look at coverage of these vars - using my coverage fn
coverage_function(lifestyle)

# code to binary to look at correlations where equal to true -- or if string 
newdf<-lapply(lifestyle,function(x){ifelse(is.na(x) | x =='',0,1)})

# list to df - R 
m<-as.data.frame(newdf)

# matrix obj for correlation tables 
mdf<-as.matrix(m)
mdf<-cor(mdf)

# select where above a certain correlation threshold (or itself) and plot 
mdf[abs(mdf) < 0.3 | mdf ==1] <- NA

# correlation buckets of lifestyle variables 
corrplot(mdf, method = "square")
mdf<-as.data.frame(mdf)


#flatten df to make new human readable df from cor pairs 

df<-data.frame()
for(i in 1:length(mdf)){
  for(j in 1:length(mdf)){
    var1=names(mdf)[i] #col name
    var2=names(mdf)[j] #row name
    val=mdf[i,j] #row col num mi tho
    
    newrow=c(var1=var1, var2=var2, val=val)
    df<-rbind(df,newrow,stringsAsFactors=F) # mi tho

  }
}

# now can compare correlation pairs 
##########################################################################################################


for(i in 1:length(df)){
  colnames(df)[i] <- paste(i,"var",sep="_")
}


df<-df %>% filter(!is.na('3_var'))
# basically trying to omit all NAs so I can have a list of the correlation pairs

df[df=="NA"] <- NA

# if col1 val and col2 val are equal to each other (when offset)
# then grab only one variable 


# one thing Narine has done:
# dynamic process : information gain or final outcome
# solar customers or not -- what are most predicatbale attributes?
# what is the average # of people golfing - standard deviations 

################################################################################

## other code that would help me get names of correlated pairs below - not done 
# needs edits 
################################################################################

#for each row and each column tell me if t/f if not a duplicate
unik<-apply(mdf,1,function(x){!duplicated(mdf)})
# for each cell, tell me what the values are and retain column/row names
m<-mdf[unik] 

#filter out the gunk and still have unique column names and rows.


# gives you the indices for all of the columns 
k<-arrayInd(1:length(mdf),dim(mdf))
# returns the row and column names of all the dimensions
lk<-mapply(`[[`, dimnames(mdf), k)


# now I know the nondupe values, tell me what the row/col names of these are
# what about correlations for multiple variables? - grab the first instance where unique
# and then after first unique instance - then group together




