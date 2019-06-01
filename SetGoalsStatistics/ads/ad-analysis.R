library(dplyr) 




### Functions

AddCostPerConvUsd <- function(matrix, nokCost){
  # 90 Day average: 1 NOK = 0.11604 USD
  # 20.05.19, Source: https://www.xe.com/currencyconverter/convert/?Amount=1&From=NOK&To=USD
  CostPerConvUSD <- round(nokCost * 0.11604 , digits = 2)
  names(CostPerConvUSD) <- "CostPerConvUSD"
  matrix <- cbind(matrix, CostPerConvUSD)
  return(matrix)
}

NumCharWithCommaToNum <- function(column){
  column <- as.character(column)
  column <- gsub(",", "", column)
  column <- as.numeric(column)
}


### Campaign Overview
campaigns <- read.csv('ads/campaign-overview-190531.csv',skip=2)
campaigns <- campaigns[-1]
campaigns <- campaigns[-1]
campaigns <- campaigns[-1]
campaigns <- campaigns[-1]
campaigns <- campaigns[-1]
campaigns <- campaigns[-1]
campaigns <- campaigns[-1]
# Rename some colums that are problematic in pgfplotstable in LaTeX.
colnames(campaigns)[8] <- "AvgCPC"
colnames(campaigns)[2] <- "CostPerConvNOK"
colnames(campaigns)[3] <- "ConvRate"

# Remove %, since the pgfplotstable in LaTeX wont show values after "%"
campaigns$ConvRate <- gsub("%", "", campaigns$ConvRate) 
campaigns$CTR <- gsub("%", "", campaigns$CTR) 
#campaigns <- campaigns[order(campaigns$Conversions, decreasing = TRUE),]

campaigns <- AddCostPerConvUsd(campaigns, campaigns$CostPerConvNOK)
campaigns$Impressions <- NumCharWithCommaToNum(campaigns$Impressions)
campaigns$Clicks <- NumCharWithCommaToNum(campaigns$Clicks)

campaigns <- campaigns[-c(7,8), ] 

campaignStartDates <- c("24.04.19", "29.04.19","05.05.19", "06.05.19", "23.05.19", "24.04.19")
names(campaignStartDates) <- "Start Date"
campaignEndDates <- c("30.04.19", "30.04.19", "06.05.19", "09.05.19","26.05.19", "26.05.19")
names(campaignEndDates) <- "End Date"
campaignAudience <- c("World-wide", "World-wide", "Norway", "Europe", "World-wide")
names(campaignAudience) <- "Target Audience"
campaignTarget <- c("Android", "iOS", "Android", "Android", "Android")
names(campaignAudience) <- "Platform"
campaignNames <- c("And1", "iOS1", "And2", "And3", "And4")
names(campaignNames) <- "Name"

campaigns <- cbind(campaigns, campaignStartDates, campaignEndDates, campaignAudience, campaignTarget,campaignNames)


write.csv(campaigns, "ads/campaign-overview-dates-added-190531.csv", quote = FALSE)



















