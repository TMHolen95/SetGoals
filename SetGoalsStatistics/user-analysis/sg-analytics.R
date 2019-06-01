library(dplyr) 


bfi <- read.csv('user-analysis/bfi-01-06-19.csv', na.strings = "null")
bfiData <- bfi[,c("openness", "conscientiousness", "extroversion", "agreeableness", "neuroticism")]
bfiData <- (bfiData-0.2)/0.8 # When I calculated the bfi values I had calculation-error resulting in values only from 0.2 to 1.0
bfiData <- FilterTestAccounts(bfiData)

names(bfiData)[names(bfiData) == "openness"] <- "opn"
names(bfiData)[names(bfiData) == "conscientiousness"] <- "con"
names(bfiData)[names(bfiData) == "extroversion" ] <- "ext"
names(bfiData)[names(bfiData) == "agreeableness"] <- "agr"
names(bfiData)[names(bfiData) == "neuroticism"] <- "neu"

bfiDataNoNa = na.omit(bfiData)
#which(complete.cases(bfiData))

#mean(bfiDataNoNa[,1:5])

boxplot(bfiData,main="BFI",
        xlab=paste("BFI Trait (n = ", length(bfiDataNoNa[,1]),(")")),
        ylab="Value",
        range=0,
        ylim = c(0.0, 1.0))

        