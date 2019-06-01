library(dplyr) 

campaigns <- read.csv('campaign-190517.csv',skip=2)
names(campaigns[Cost...conv]) <- "CostPerConv"

colnames(campaigns)[11] <- "CostPerConv"
colnames(campaigns)[12] <- "ConvRate"



campaignStartDates <- c("24.04.19", "29.04.19","05.05.19", "06.05.19")
names(campaignStartDates) <- "Start Date"
campaignEndDates <- c("30.04.19", "30.04.19", "06.05.19", "09.05.19")
names(campaignEndDates) <- "End Date"
campaigns <- cbind(campaigns, campaignStartDates, campaignEndDates)


android3 <- read.csv('android3-190520.csv',skip=2)

colnames(android3)[4] <- "Currency"
colnames(android3)[5] <- "CostPerConvNOK"
colnames(android3)[6] <- "ConvRate"

android3$Bid.adj. = NULL
android3$Currency.code = NULL

# 90 Day average: 1 NOK = 0.11604 USD
# 20.05.19, Source: https://www.xe.com/currencyconverter/convert/?Amount=1&From=NOK&To=USD

CostPerConvUSD <- round(android3$CostPerConv * 0.11604 , digits = 2)
names(CostPerConvUSD) <- "CostPerConvUSD"
android3 <- cbind(android3, CostPerConvUSD)

android3 <- android3 %>% 
  filter(android3$Conversions != 0)

android3$ConvRate


android3 <- android3[order(android3$Conversions, decreasing = TRUE),]

write.csv(android3, "android3-modified-190520.csv", quote = FALSE)

