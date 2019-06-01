library(dplyr) 
library(plyr)
library(lubridate)
library(tidyr)
registrations <- read.csv('user-analysis/registrations.csv')
registrations <- FilterTestAccounts(registrations)

registrations$provider <- mapvalues(registrations$provider, from = c("facebook.com", "google.com", "password"), to = c("Facebook", "Google", "Email"))

sec = registrations$creationTime / 1000
dates <- as.POSIXct(sec, origin="1970-01-01", tz="UTC")


realDates <- as.Date.factor(dates)
factorDates <- as.factor(realDates)
registrations$creationTime <- factorDates
registrations$creationTime <- realDates

registrations <- registrations %>% filter(registrations$creationTime >= as.Date("2019-04-05"))
#require(ggplot2)
#p <- ggplot(registrations, aes(x = registrations$creationTime))
#p + geom_bar(aes(fill = registrations$provider)) + 
#  ggtitle("Plot of registrations") + 
#  xlab("Date") + 
#  ylab("Count") + 
#  labs(fill = "Provider") + 
#  scale_y_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10)) +
#  theme(axis.text.x = element_text(angle = 90, hjust = 1))





countedProvidersByDate <- registrations %>%
  arrange(registrations$creationTime)
  
countedProvidersByDate <- countedProvidersByDate %>% 
  mutate(facebookCumsum = cumsum(countedProvidersByDate$provider == "Facebook")) %>% 
  mutate(googleCumsum = cumsum(countedProvidersByDate$provider == "Google")) %>% 
  mutate(emailCumsum = cumsum(countedProvidersByDate$provider == "Email"))

countedProvidersByDate <- countedProvidersByDate[,-3]
countedProvidersByDate <- countedProvidersByDate[,-1]
write.csv(countedProvidersByDate, file = "user-analysis/countedProvidersByDate.csv")


# # change to long data format
# mydf_m <- gather(countedProvidersByDate, "provider", "val", c(5:7))
# # reorder variable values
# mydf_m$provider <- factor(countedProvidersByDate$creationTime, levels=c("Facebook", "Google", "Email"))
# 
# 
# # Line plot with multiple groups
# ggplot(data=countedProvidersByDate, aes(x=creationTime, y=facebookCumsum, group=provider)) +
#   geom_line(aes(linetype=provider))+
#   geom_point()  +
#   theme(axis.text.x = element_text(angle = 90, hjust = 1))
# # Change line types
# ggplot(data=countedProvidersByDate, aes(x=creationTime, y=googleCumsum, group=provider)) +
#   geom_line(aes(linetype=provider))+
#   geom_point(aes(shape=provider))
# 
# library(reshape2)
# dat = melt(subset(countedProvidersByDate, select = c("facebookCumsum","googleCumsum", "emailCumsum", "provider")),
#            id.vars = "provider")
# ggplot(aes(x = countedProvidersByDate$creationTime, y = value, color = variable), data = dat) +  
#   geom_point() + geom_line()
# 
# 
# 
# ggplot(countedProvidersByDate, aes(x = creationTime, group = creationTime)) + 
#   geom_point(aes(y = facebookCumsum), colour="blue") + 
#   geom_point(aes(y = googleCumsum), colour = "red") + 
#   geom_point(aes(y = emailCumsum), colour = "black") + 
#   theme(axis.text.x = element_text(angle = 90, hjust = 1))
#   #ylab(label="Total registrations per provider") + 
#   #xlab("Date")
# 
# ggplot(countedProvidersByDate, aes(y = creationTime)) + 
#   geom_path(x = countedProvidersByDate$facebookCumsum, colour="blue") + 
#   geom_path(x = countedProvidersByDate$googleCumsum, colour = "red") + 
#   geom_path(x = countedProvidersByDate$emailCumsum, colour = "black") + 
#   theme(axis.text.x = element_text(angle = 90, hjust = 1))


tmin <- min(as.Date(countedProvidersByDate$creationTime))
tmax <- max(as.Date(countedProvidersByDate$creationTime))
tlab <- seq(tmin, tmax, by="month")
lab <- format(tlab,format="%Y-%M-%D")


# Give the chart file a name.
#png(file = "provider-cumsum.jpg")

# Plot the bar chart.


plot(countedProvidersByDate$creationTime, countedProvidersByDate$facebookCumsum, type="s",col = "blue", xlab = "Date", ylab = "Registrations", 
    main = "Cumulative registrations by provider")

lines(countedProvidersByDate$creationTime, countedProvidersByDate$googleCumsum, type="s", col = "red")
lines(countedProvidersByDate$creationTime, countedProvidersByDate$emailCumsum, type="s", col = "gray")
grid()
legend("topleft", legend=c("Facebook", "Google", "Email"),
col=c("blue", "red", "gray"), lty = 1:2, cex=0.8)

# Save the file.
#dev.off()

#registrations$creationTime

#realFactor <- factor(df$score, levels=seq(0, factors-1, by=1), labels=labels)
counts <- table(registrations$provider)
barplot(counts, main="Registrations by provider",)














