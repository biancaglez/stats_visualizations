
mutated_lifestyle <- function(x) { 
  
lifestyle<-read.csv('~anonymous.csv')


#################################################################################
# changing data to be more human readable by editing given variables...
# easier for humans to read, visualize, and understand when we reduce binary to categories

# grouping like life vars can get us information gain! (increase coverage)
mutated_lifestyle <- function(x) { 
x <- x %>% 
  mutate(x = ifelse(tech_focused == 't' | foodie =='t' | travel =='t' | books_magazines =='t' | health_conscious =='t' | gardener =='t' | music =='t' | online_purchases == 't','true', 'false'))

x <- x %>% 
  mutate(bankcard_any = ifelse(bank_card_in_household== 't' | card_any== 't' | card_premium== 't','t', NA)) 

x <- x %>% 
  mutate(sports_any = ifelse(baseball_fan== 't' | basketball_fan== 't' | football_fan== 't' | hockey_fan== 't' |soccer_fan== 't' |sports_fan== 't' | motorcycling== 't','t', NA))


x <- x %>% 
  mutate(outdoor_interests = ifelse(outdoors== 't' |
                                      gardener== 't' |
                                      golfs== 't' |
                                      green== 't','t', NA)) 


x <- x %>% 
  mutate(homepurchases = ifelse(auto_parts== 't' |
                                  parenting== 't' |
                                  children_interests== 't' |
                                  books_magazines== 't' |
                                  frequent_remodeler== 't', 't', NA)) 

x <- x %>% 
  mutate(entertainment_purchases = ifelse(boating== 't' |
                                            gaming== 't' |
                                            video_games== 't' |
                                            music== 't' , 't', NA)) 
x <- x %>% 
  mutate(vehicle =ifelse(
    vehicle_any== 't' |
      vehicle_luxury== 't' |
      vehicle_pickup== 't' |
      vehicle_suv== 't' , 't', NA)) 

x <- x %>% 
  mutate(art_interests=ifelse(
    antiques== 't' |
      art== 't' |
      avid_collector== 't' |
      collectibles== 't', 't', NA)) 


x <- x %>% 
  mutate(travel=ifelse(
    travel== 't' |
      travels_internationally== 't', 't', NA)) 

x <- x %>% 
  mutate(health=ifelse(   
    dieting== 't' |
      health_conscious== 't' |
      medical_health== 't' |
      membership_club== 't', 't', NA)) 

x <- x %>% 
  mutate(pets=ifelse(
    cat_owner== 't' |
      dog_owner== 't','t', NA))
      #pet_any== 't', 't', NA)) 

x <- x %>% 
  mutate(apparel_interests=ifelse(
    mens_apparel== 't' |
      womens_apparel== 't', 't', NA)) 

x <- x %>% 
  mutate(miscellaneous=ifelse(
    charitable_donations== 't' |
      mail_order_buyer== 't' |
      equestrian== 't', 't', NA))

x <- x %>% 
  mutate(politics=ifelse(
  news_politics== 't' |
  political_donor== 't','t', NA))

x <- x %>% 
  mutate(hipster=ifelse(
    foodie== 't' |
      investing== 't' |
      tech_focused== 't' |
        online_purchases== 't', 't', NA))

return(x)

}
