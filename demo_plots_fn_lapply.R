
#modifications by b.gonzalez -courtesy of s.kelly
gen_hh<-simpli %>% select(gender,household_income, order_type)


f = function(column) {
    ggplot() +
    geom_bar(aes(x=na.omit(column), y=(..count..)/sum(..count..))) +
    scale_y_continuous(labels = scales::percent) +
    theme(axis.text.x = element_text(angle = 40, hjust = 1)) + 
    ylab("Percentage") +xlab(paste(names(column)))
}
#+ facet_grid(~gen_hh$order_type)
x = lapply(gen_hh, f)
#gen_hh[[3]]
x[[2]


