library(dplyr) 
library(gridExtra)
library(devtools)
library(ggplot2)


questionnaire <- read.csv('user-analysis/questionnaire.csv')
questionnaire <- FilterTestAccounts(questionnaire)

getQuestion <- function(questionText){
  qst <- questionnaire %>% filter(questionnaire$question == questionText)
  return(qst)
}


# Demographic
d1 <- getQuestion("What is your age?")
d2 <- getQuestion("How were you recruited to this application?")
d3 <- getQuestion("What is your gender?") # Likert
d4 <- getQuestion("Do you currently reside within norway?") # Likert

# Social 
s1 <- getQuestion("Did you feel the application's social features (posts and comments) were useful for your progress?")
s2 <- getQuestion("Did seeing posts from friends make you want to compete or collaborate with them towards a goal?")
s3 <- getQuestion("Did you find the point system motivating, engaging, or competitive?")

# Logging
l1 <- getQuestion("What did you and did not like about the goal logging feature?") # Likert
l2 <- getQuestion("What did you and did not like about the view data feature? Check-ins is shown in image but consider the other logging options as well.") # Likert
l3 <- getQuestion("How did you feel about having to log the data on the same day you did your activity? (Not being able to add entries for previous days)")
l4 <- getQuestion("Would you continue to use this application, why or why not?") # Likert
l5 <- getQuestion("How did you feel about receiving the reminders, did they help you to work towards your goal?")

# Map
m1 <- getQuestion("Did you use the map feature, why and why not?") 
m2 <- getQuestion("Were the map useful to find suggestions on what to do?") # Likert
m3 <- getQuestion("Do you think the map feature could be improved, if so do you have any suggestions?")

# Privacy
p1 <- getQuestion("Which of these login methods are you comfortable using: Email, Facebook, Google, or other methods?")
p2 <- getQuestion("Would you be comfortable with other people seeing your goal's logged data, if so who?")
p3 <- getQuestion("Who are you be comfortable sharing your personal goals to? (not private goals)")

# Feedback
f1 <- getQuestion("Did you encounter any errors in the application?") # Likert
f2 <- getQuestion("If you have any more feedback please provide it through the feedback dialog, or here. Thanks for answering these questions, if all questionnaires are checked and you have consented to the contest rules on the profile page you are eligble for participating in the prize draw. Big thanks for participating!")



#likertQuestions <- questionnaire %>% 
  #filter(questionnaire$score != "null")

generateBarPlot <- function(df, factors, labels, title = NULL){
  realFactor <- factor(df$score, levels=seq(0, factors-1, by=1), labels=labels)
  counts <- table(realFactor)
  if(is.null(title)) title <- df$question[1]
  barplot(counts, main=title, names.arg =labels)
}

# Likert questions: d3, d4, l1, l2, l4, m2, f1
generateBarPlot(d3, 3, list("male","female","other"))
generateBarPlot(d4, 2, list("yes", "no"))
generateBarPlot(l1, 5, list("severely disliked it","disliked it","Neutral","liked it","severely liked it"), "Goal Logging Feature Likability")
generateBarPlot(l2, 5, list("severely disliked it","disliked it","Neutral","liked it","severely liked it"), "View Data Feature Likability")
generateBarPlot(l4, 3, list("Yes", "No", "Maybe"), "Would you continue to use this application?")
generateBarPlot(m2, 5, list("Strongly Disagree","Disagree","Neutral","Agree","Strongly Agree"))
generateBarPlot(f1, 3, list("Yes", "No","Maybe"))

allQuestions <- list(d1,d2,d3,d4,s1,s2,s3,l1,l2,l3,l4,l5,m1,m2,m3,p1,p2,p3,f1,f2)



saveQuestion <- function(df, index){
  qstn <- as.character(i[1,"question"])
  score <- i[,"score"]
  responses <- as.character(i[,"freeText"])
  res <- cbind(score, responses)
  colnames(res)[2] <- qstn
  
  csvTitle <- paste("user-analysis/questions/",index,".csv", sep="")
  write.csv(res, csvTitle, quote = FALSE)
}

index <- 0;
for(i in allQuestions){
  # Trim to essentials
  saveQuestion(i, index)
  index <- index + 1;
}

### Functions

# AddCostPerConvUsd <- function(matrix, nokCost){
#   # 90 Day average: 1 NOK = 0.11604 USD
#   # 20.05.19, Source: https://www.xe.com/currencyconverter/convert/?Amount=1&From=NOK&To=USD
#   CostPerConvUSD <- round(nokCost * 0.11604 , digits = 2)
#   names(CostPerConvUSD) <- "CostPerConvUSD"
#   matrix <- cbind(matrix, CostPerConvUSD)
#   return(matrix)
# }


### Read Write
# campaigns <- read.csv('ads/campaign-overview-190517.csv',skip=2)
# write.csv(campaigns, "ads/campaign-overview-dates-added-190520.csv", quote = FALSE)

### Modify columns and add to 
# campaignStartDates <- c("24.04.19", "29.04.19","05.05.19", "06.05.19")
# names(campaignStartDates) <- "Start Date"
# campaigns <- cbind(campaigns, campaignStartDates, campaignEndDates, campaignAudience, campaignTarget,campaignNames)
# colnames(campaigns)[8] <- "AvgCPC" # Rename

# campaigns$ConvRate <- gsub("%", "", campaigns$ConvRate) # Remove %
# campaigns <- campaigns[order(campaigns$Conversions, decreasing = TRUE),]

# campaigns <- AddCostPerConvUsd(campaigns, campaigns$CostPerConvNOK)
# campaigns$Impressions <- NumCharWithCommaToNum(campaigns$Impressions)
# campaigns$Clicks <- NumCharWithCommaToNum(campaigns$Clicks)






