### Google Ads in Europe CPI 3.8
europe <- read.csv('ads/campaign3-android-europe.csv',skip=2)

europe <- europe %>% 
  filter(europe$Conversions != 0)
europe$Bid.adj. = NULL

# Rename some colums that are problematic in pgfplotstable in LaTeX.
colnames(europe)[3] <- "Currency"
colnames(europe)[4] <- "CostPerConvNOK"
colnames(europe)[5] <- "ConvRate"

# Remove %, since the pgfplotstable in LaTeX wont show values after "%"
europe$Conv..rate <- gsub("%", "", europe$Conv..rate) 
europe <- europe[order(europe$Conversions, decreasing = TRUE),]

europe <- AddCostPerConvUsd(europe, europe$CostPerConvNOK)

write.csv(europe, "ads/europe-modified-190520.csv", quote = FALSE)
