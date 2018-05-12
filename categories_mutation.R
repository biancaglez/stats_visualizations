lifestyle<-read.csv('~/Desktop/Faraday/chloropleth_maps/btcomm_lifestyle_success.csv')


#################################################################################


# easier to read, visualize, and understand when we reduce numeric data to categories

mutated_categories <- function(x) { 
x <- x %>% 
  mutate(age_cats = ifelse(age < 25, "Bucket1_under25", 
                           ifelse(age <= 34, "Bucket2_under34",
                                  ifelse(age <= 44, "Bucket3_under44",
                                         ifelse(age <= 54, "Bucket4_under54",
                                                ifelse(age <= 64, "Bucket5_under64",
                                                       ifelse(age >= 65, "Bucket6_over65",
                                         ifelse(age == "", "NA","unknown" ))))))))

x <- x %>% 
  mutate(age_cats_mills = ifelse(age < 32, "Millenial",
                                 ifelse(age<60, "GenerationX",
                                        ifelse(age>=61,"BabyBoomer", "NA"))))
                             

x<- x %>% 
  mutate(resident_type = ifelse(length_of_residence < 2 , "Under2years", 
                                ifelse(length_of_residence < 6 , "2_6years", 
                                ifelse(length_of_residence < 12 , "Permanent Residents_6_12years",
                                       ifelse(length_of_residence < 35, "Lifetimers_great12" ,"NA")))))

x<- x %>% mutate(favm_type = ifelse(favm <= 236208, "HouseVal1", 
                                                  ifelse(favm <= 393158, "HouseVal2",
                                                         ifelse(favm <= 142050698, "HouseVal3" ,"other"))))

# use upward bounds by geography or by data quantiles
x<-x %>% mutate(income_cat = ifelse(household_income < 50000 , "Hardworking American Family < $50,000", 
                                                  ifelse(household_income < 120000 , "On the Up American Family > $50,000",
                                                         ifelse(household_income < 600000, "Living Large > $120,000" ,"other"))))
#bucketizing into higher ed - the rest 
x<- x %>% 
  mutate(education_type = ifelse(education == "Completed Graduate School"| education == "Completed College","higher_ed",
                             ifelse(education == "Attended Vocational/Technical" | education == "Completed High School",
                                    "highschool_tech", "other")))

# grouping like life vars can get us information gain! (increase coverage)
x <- x %>% 
  mutate(lifestyle = ifelse(tech_focused == 't' | foodie =='t' | travel =='t' | books_magazines =='t' | health_conscious =='t' | gardener =='t' | music =='t' | online_purchases == 't','true', 'false'))

## categorizing occupation type into different categories for segmentation in BigML 
x<- x %>% 
  mutate(occupation_type = ifelse(occupation == "Professional/Technical" | occupation == "Homemaker" | occupation == "Blue collar", "technical_type",
                                  ifelse(occupation == "Retired" | occupation == "Self Employed" | occupation == "Other", "other_type",
                                         ifelse(occupation == "Sales/Service"| occupation == "Administration/Management" | occupation == "White collar" | occupation == "Legal" | occupation == "Educator" | occupation == "Medical", "professional_type",
                                                ifelse(occupation == "Student", "student_type", "NA")))))
return(x)
}
