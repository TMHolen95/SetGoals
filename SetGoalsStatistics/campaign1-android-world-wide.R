### Google Ads World-Wide CPI 3.8
worldWide <- read.csv('ads/campaign1-android-world-wide.csv',skip=2)

worldWide$Bid.adj. = NULL
worldWide$Added.Excluded = NULL
worldWide$Location.type = NULL

colnames(worldWide)[3] <- "Impr"
colnames(worldWide)[5] <- "Currency"
colnames(worldWide)[6] <- "AvgCPC"
colnames(worldWide)[9] <- "CostPerConvNOK"
colnames(worldWide)[10] <- "ConvRate"

worldWide <- worldWide[order(worldWide$Conversions, decreasing = TRUE),]
#worldWide$Impr <- as.numeric(worldWide$Impr)

# COnvert factor to numeric
worldWide$Impr <- as.character(worldWide$Impr)
worldWide$Impr <- gsub(",", "", worldWide$Impr)
worldWide$Impr <- as.numeric(worldWide$Impr)

# gsub("%", "", worldWide$CTR)
worldWide$CTR <- gsub("%", "", worldWide$CTR)
worldWide$ConvRate <- gsub("%", "", worldWide$ConvRate)
worldWide <- AddCostPerConvUsd(worldWide, worldWide$CostPerConvNOK)


worldWideDef <- worldWide %>% 
  filter(worldWide$Clicks >= 10)

#worldWideHighlyViewed <- worldWide %>% 
#  filter(worldWide$Impr >= 1000)


write.csv(worldWideDef, "ads/campaign1-android-world-wide-modified.csv", quote = FALSE)


### Google Ads World-Wide CPI 3.8
worldWide <- read.csv('ads/campaign4-android-world-wide.csv',skip=2)

worldWide$Bid.adj. = NULL
worldWide$Added.Excluded = NULL
worldWide$Location.type = NULL

colnames(worldWide)[3] <- "Impr"
colnames(worldWide)[5] <- "Currency"
colnames(worldWide)[6] <- "AvgCPC"
colnames(worldWide)[9] <- "CostPerConvNOK"
colnames(worldWide)[10] <- "ConvRate"

worldWide <- worldWide[order(worldWide$Conversions, decreasing = TRUE),]
#worldWide$Impr <- as.numeric(worldWide$Impr)

# COnvert factor to numeric
worldWide$Impr <- as.character(worldWide$Impr)
worldWide$Impr <- gsub(",", "", worldWide$Impr)
worldWide$Impr <- as.numeric(worldWide$Impr)

# gsub("%", "", worldWide$CTR)
worldWide$CTR <- gsub("%", "", worldWide$CTR)
worldWide$ConvRate <- gsub("%", "", worldWide$ConvRate)
worldWide <- AddCostPerConvUsd(worldWide, worldWide$CostPerConvNOK)


worldWideDef <- worldWide

write.csv(worldWideDef, "ads/campaign4-android-world-wide-modified.csv", quote = FALSE)



### Google Ads World-Wide CPI 3.8
worldWide <- read.csv('ads/campaign3-android-europe-v2.csv',skip=2)

worldWide$Bid.adj. = NULL
worldWide$Added.Excluded = NULL
worldWide$Location.type = NULL

colnames(worldWide)[3] <- "Impr"
colnames(worldWide)[5] <- "Currency"
colnames(worldWide)[6] <- "AvgCPC"
colnames(worldWide)[9] <- "CostPerConvNOK"
colnames(worldWide)[10] <- "ConvRate"

worldWide <- worldWide[order(worldWide$Conversions, decreasing = TRUE),]
#worldWide$Impr <- as.numeric(worldWide$Impr)

# COnvert factor to numeric
worldWide$Impr <- as.character(worldWide$Impr)
worldWide$Impr <- gsub(",", "", worldWide$Impr)
worldWide$Impr <- as.numeric(worldWide$Impr)

# gsub("%", "", worldWide$CTR)
worldWide$CTR <- gsub("%", "", worldWide$CTR)
worldWide$ConvRate <- gsub("%", "", worldWide$ConvRate)
worldWide <- AddCostPerConvUsd(worldWide, worldWide$CostPerConvNOK)


worldWideDef <- worldWide

write.csv(worldWideDef, "ads/campaign4-android-europe-v2-modified.csv", quote = FALSE)