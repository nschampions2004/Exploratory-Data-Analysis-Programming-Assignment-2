library(dplyr)
library(ggplot2)

#Read the data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#merge data based on SCC number, cut out non motor vehicle, cut out non-baltimore fips, 
#order by year
merged <- merge(NEI, SCC, by = "SCC")
merged <- merged[merged$fips == "24510" & merged$type == "ON-ROAD", ]


#sum it up based on years
agg <- aggregate(Emissions ~ year, merged, sum)


#make the graph of pm2.5 sums by year
png("plot5.png", width = 640, height = 480)
plot5 <- ggplot(agg, aes(factor(year), Emissions)) + 
  geom_bar(stat = "identity", aes(fill = year, color = year)) + 
  labs(title = expression(PM[2.5] * " sums from 1999-2008 for ON ROAD Vehicles")) +
  labs(x = "Year", y = expression("Sum of " * PM[2.5] * " levels"))

print(plot5)
dev.off()
