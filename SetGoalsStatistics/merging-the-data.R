library(plyr)

FilterTestAccounts <- function(matrix){
  matrix <- matrix %>% 
    filter(accountId != "myzhtGtYzchuiptvmMNE6ssmfyz1") %>% 
    filter(accountId != "ytguYFSKHCavs5DZMxkkfso3xiS2") %>% 
    filter(accountId != "JUco19TvdCQ6nxqoz1xIHWPmaOS2") %>% 
    filter(accountId != "1HrLGpVK22SShbMtPckV1Ni5Aki2") %>% 
    filter(accountId != "TAsjKP4tUOM0gnNx8sl1uERH27A2")
  return(matrix)
}

# To combine bfi with agrevated the total number of posts, and goals and logs made by each user
dataset <- read.csv('user-analysis/bfi-190531.csv', na.strings = "null")
dataset <- FilterTestAccounts(dataset)
bfiData <- dataset[,c("openness", "conscientiousness", "extroversion", "agreeableness", "neuroticism")]
bfiData <- (bfiData-0.2)/0.8 # When I calculated the bfi values I had calculation-error resulting in values only from 0.2 to 1.0
dataset[,c("openness", "conscientiousness", "extroversion", "agreeableness", "neuroticism")] <- bfiData

names(bfiData)[names(bfiData) == "openness"] <- "opn"
names(bfiData)[names(bfiData) == "conscientiousness"] <- "con"
names(bfiData)[names(bfiData) == "extroversion" ] <- "ext"
names(bfiData)[names(bfiData) == "agreeableness"] <- "agr"
names(bfiData)[names(bfiData) == "neuroticism"] <- "neu"

bfiDataNoNa = na.omit(bfiData)
#which(complete.cases(bfiData))

#mean(bfiDataNoNa[,1:5])

# boxplot(bfiData,main="BFI",
#         xlab=paste("BFI Trait (n = ", length(bfiDataNoNa[,1]),(")")),
#         ylab="Value",
#         range=0,
#         ylim = c(0.0, 1.0))


# Merge cumsums of the goals with the bfi data
goals <- read.csv('user-analysis/goals-190531.csv', na.strings = "null")
noDefault <- na.omit(goals)
filteredGoals <- FilterTestAccounts(noDefault)
filteredGoals <- filteredGoals %>% 
  filter(goalId != "default-goal")

countedGoals <- count(filteredGoals$accountId)
names(countedGoals)[1] <- "accountId"
names(countedGoals)[2] <- "goals"

publicGoals <- filteredGoals %>% 
  filter(public == "true")
countedPublicGoals <- count(publicGoals$accountId)
names(countedPublicGoals)[1] <- "accountId"
names(countedPublicGoals)[2] <- "publicGoals"


privateGoals <- filteredGoals %>% 
  filter(public == "false")
countedPrivateGoals <- count(privateGoals$accountId)
names(countedPrivateGoals)[1] <- "accountId"
names(countedPrivateGoals)[2] <- "privateGoals"


posts <- read.csv('user-analysis/posts-190531.csv', na.strings = "null")
filteredPosts <- FilterTestAccounts(posts)
countedPosts <- count(filteredPosts$accountId)
names(countedPosts)[1] <- "accountId"
names(countedPosts)[2] <- "posts"

goalLogs <- read.csv('user-analysis/log-entries190531.csv', na.strings = "null")
filteredGoalLogs <- FilterTestAccounts(goalLogs)
countedGoalLogs <- count(filteredGoalLogs$accountId)
names(countedGoalLogs)[1] <- "accountId"
names(countedGoalLogs)[2] <- "goalLogs"

reminders <- read.csv('user-analysis/reminders190531.csv', na.strings = "null")
filteredReminders <- FilterTestAccounts(reminders)
countedReminders <- count(filteredReminders$accountId)
names(countedReminders)[1] <- "accountId"
names(countedReminders)[2] <- "reminders"

comments <- read.csv('user-analysis/comments-190531.csv', na.strings = "null")
filteredComments <- FilterTestAccounts(comments)
countedComments <- count(filteredComments$accountId)
names(countedComments)[1] <- "accountId"
names(countedComments)[2] <- "comments"


dataset <- merge(dataset, countedGoals, by = "accountId", all = TRUE)
dataset <- merge(dataset, countedPublicGoals, by = "accountId", all = TRUE)
dataset <- merge(dataset, countedPrivateGoals, by = "accountId", all = TRUE)
dataset <- merge(dataset, countedGoalLogs, by = "accountId", all = TRUE)
dataset <- merge(dataset, countedReminders, by = "accountId", all = TRUE)
dataset <- merge(dataset, countedPosts, by = "accountId", all = TRUE)
dataset <- merge(dataset, countedComments, by = "accountId", all = TRUE)

# Add registration and provider info

registrations <- read.csv('user-analysis/registrations.csv')
registrations <- FilterTestAccounts(registrations)

registrations$provider <- mapvalues(registrations$provider, from = c("facebook.com", "google.com", "password"), to = c("Facebook", "Google", "Email"))

#sec = registrations$creationTime / 1000
#dates <- as.POSIXct(sec, origin="1970-01-01", tz="UTC")

#realDates <- as.Date.factor(dates)
#registrations$creationTime <- realDates
registrations <- registrations[-3]
#factorDates <- as.factor(realDates)
#registrations$creationTime <- factorDates

#registrations <- registrations %>% filter(registrations$creationTime >= as.Date("2019-04-05"))

dataset <- merge(dataset, registrations, by = "accountId", all = TRUE)

write.csv(dataset, file = "user-analysis/processed-data.csv", na = "")
# See if there is any correlation between the values.

