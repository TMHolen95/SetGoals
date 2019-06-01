# Load
library(dplyr) 
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)

# Filters out the test users from the data, inculing my own data.
removeTestAccounts <- function(csvData){
  return(csvData %>% 
           filter(accountId != "myzhtGtYzchuiptvmMNE6ssmfyz1") %>% # Admin
           filter(accountId != "ytguYFSKHCavs5DZMxkkfso3xiS2") %>% # Tester Testesen
           filter(accountId != "JUco19TvdCQ6nxqoz1xIHWPmaOS2") %>% # Spamcol Lector
           filter(accountId != "1HrLGpVK22SShbMtPckV1Ni5Aki2") %>% # Master Sweatpants
           filter(accountId != "TAsjKP4tUOM0gnNx8sl1uERH27A2")     # Madison Cab
  )
}

# Prepares text by turning it into a character array, with alphanumeric characters only [a-z0-9]
prepareWordCloudText <- function(text){
  textAsWords <- paste(text, sep = '', collapse = '') 
  textAsAplhaNum <- str_replace_all(textAsWords, "[^[a-zA-Z]]", " ")
  textAsAplhaNum <- str_replace(gsub("\\s+", " ", str_trim(textAsAplhaNum)), "B", "b")
  return(tolower(textAsAplhaNum))
}


goals <- read.csv('user-analysis/goals-190531.csv', na.strings = "default-goal")
noDefault = na.omit(goals)
filteredGoals = removeTestAccounts(noDefault)


titles <- filteredGoals$title
titlesAsString <- paste(titles, 1:length(filteredGoals$title), sep = " ")

descriptions <- filteredGoals$description
descriptionsAsString <- paste(descriptions, 1:length(filteredGoals$title), sep = " ")

allText <- c(titlesAsString, descriptionsAsString)
goalTexts <- prepareWordCloudText(allText)

wordcloud(goalTexts, 
          excludeWords = NULL, 
          textStemming = FALSE,  colorPalette="Dark2",
          max.words=75)

# Create word cloud from posts
posts <- read.csv('user-analysis/posts-190531.csv')
filteredPosts = removeTestAccounts(posts)

postTitles <- filteredPosts$postTitle
postTitlesAsString <- paste(postTitles, 1:length(postTitles), sep = " ")

postDescriptions <- filteredPosts$message
postDescriptionsAsString <- paste(postDescriptions, 1:length(postDescriptions), sep = " ")

allPostText <- c(postTitlesAsString, postDescriptionsAsString)
postTexts <- prepareWordCloudText(allPostText)

wordcloud(postTexts, 
          excludeWords = NULL, 
          textStemming = FALSE,  colorPalette="Dark2",
          max.words=75)

