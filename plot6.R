library(dplyr)
library(ggplot2)

#Read the data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#merge data based on SCC number, cut out non motor vehicle, cut out non-baltimore fips, 
#order by year
merged <- merge(NEI, SCC, by = "SCC")
merged.BAL <- merged[merged$fips == "24510" & merged$type == "ON-ROAD", ]
merged.LA <- merged[merged$fips == "06037" & merged$type == "ON-ROAD", ]

#sum it up based on years
agg.BAL <- aggregate(Emissions ~ year, merged.BAL, sum)
agg.LA <- aggregate(Emissions ~ year, merged.LA, sum)


agg.merge <- rbind(agg.BAL, agg.LA)
fips <- as.factor(c("25410", "25410", "25410", "25410", "06037", "06037", "06037", "06037"))
agg.merge <- cbind(agg.merge, fips)

#make the graph of pm2.5 sums by year
png("plot6.png", width = 640, height = 480)
plot6 <- ggplot(agg.merge, aes(factor(year), Emissions)) + 
  facet_grid(. ~ fips) +
  geom_bar(stat = "identity", aes(fill = year, color = year)) + 
  labs(title = expression(PM[2.5] * " sums from 1999-2008 for ON ROAD Vehicles between Baltimore(24510) and LA(06037)")) +
  labs(x = "Year", y = expression("Sum of " * PM[2.5] * " levels"))

print(plot6)
dev.off()