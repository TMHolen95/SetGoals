library(dplyr) 

goals <- read.csv('user-analysis/response190506.csv', na.strings = "default-goal")
noDefault <- na.omit(goals)
filteredGoals <- FilterTestAccounts(noDefault)

publicGoals <- filteredGoals %>% 
  filter(public == "true")

privateGoals <- filteredGoals %>% 
  filter(public == "false")

privacy <- table(filteredGoals$public)

barplot(privacy, main="Privacy of users goals", names.arg=c("Private Goals", "Public Goals"))

