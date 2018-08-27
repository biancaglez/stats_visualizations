lifestyle<-read.csv('~anonymous.csv')


#################################################################################


# easier to read, visualize, and understand when we reduce numeric data to categories

mutated_categories <- function(x) { 
x <- x %>% 
  mutate(age_cats = ifelse(age < 25, "Under25_m", 
                           ifelse(age <= 34, "Under34",
                                  ifelse(age <= 44, "Under44",
                                         ifelse(age <= 54, "Under54",
                                                ifelse(age <= 64, "Under64",
                                                       ifelse(age >= 65, "Over65",
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
  mutate(x = ifelse(tech_focused == 't' | foodie =='t' | travel =='t' | books_magazines =='t' | health_conscious =='t' | gardener =='t' | music =='t' | online_purchases == 't','true', 'false'))

x <- x %>% 
  mutate(bankcard_any = ifelse(bank_card_in_household== 't' | card_any== 't' | card_premium== 't','t', 'f')) 

x <- x %>% 
  mutate(sports_any = ifelse(baseball_fan== 't' | basketball_fan== 't' | football_fan== 't' | hockey_fan== 't' |soccer_fan== 't' |sports_fan== 't' | motorcycling== 't','t', 'f'))


x <- x %>% 
  mutate(outdoor_interests = ifelse(outdoors== 't' |
                                      gardener== 't' |
                                      golfs== 't' |
                                      green== 't','t', 'f')) 


x <- x %>% 
  mutate(homepurchases = ifelse(auto_parts== 't' |
                                  parenting== 't' |
                                  children_interests== 't' |
                                  books_magazines== 't' |
                                  frequent_remodeler== 't', 't', 'f')) 

x <- x %>% 
  mutate(entertainment_purchases = ifelse(boating== 't' |
                                            gaming== 't' |
                                            video_games== 't' |
                                            music== 't' , 't', 'f')) 

x <- x %>% 
  mutate(vehicle =ifelse(
    vehicle_any== 't' |
      vehicle_luxury== 't' |
      vehicle_pickup== 't' |
      vehicle_suv== 't' , 't', 'f')) 

x <- x %>% 
  mutate(art_interests=ifelse(
    antiques== 't' |
      art== 't' |
      avid_collector== 't' |
      collectibles== 't', 't', 'f')) 


x <- x %>% 
  mutate(travel=ifelse(
    travel== 't' |
      travels_internationally== 't', 't', 'f')) 

x <- x %>% 
  mutate(health=ifelse(   
    dieting== 't' |
      foodie== 't' |
      health_conscious== 't' |
      medical_health== 't' |
      membership_club== 't', 't', 'f')) 

#x <- x %>% 
#  mutate(pets=ifelse(
#    cat_owner== 't' |
#      dog_owner== 't' |
#      pet_any== 't', 't', 'f')) 

x <- x %>% 
  mutate(apparel_interests=ifelse(
    mens_apparel== 't' |
      womens_apparel== 't', 't', 'f')) 

x <- x %>% 
  mutate(miscellaneous=ifelse(
    charitable_donations== 't' |
      investing== 't' |
      mail_order_buyer== 't' |
      news_politics== 't' |
      online_purchases== 't' |
      political_donor== 't' |
      tech_focused== 't' |
      equestrian== 't', 't', 'f')) 

## categorizing occupation type into different categories for segmentation in BigML 
x<- x %>% 
  mutate(occupation_type = ifelse(occupation == "Professional/Technical" | occupation == "Homemaker" | occupation == "Blue collar", "technical_type",
                                  ifelse(occupation == "Retired" | occupation == "Self Employed" | occupation == "Other", "other_type",
                                         ifelse(occupation == "Sales/Service"| occupation == "Administration/Management" | occupation == "White collar" | occupation == "Legal" | occupation == "Educator" | occupation == "Medical", "professional_type",
                                                ifelse(occupation == "Student", "student_type", "NA")))))
return(x)
}
