library(dplyr)
library(ggplot2)

#Read the data into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#merge data based on SCC number
merged <- merge(NEI, SCC, by = "SCC")

#cut out all Short.Names without Coal in the entry
merged.sub <- merged[grepl("Coal", merged$Short.Name, ignore.case = FALSE), ]

#merged.sub <- merged.sub[with(merged.sub, order(year)), ]
agg <- aggregate(Emissions ~ year, merged.sub, sum)


#make the graph of pm2.5 sums by year
png("plot4.png", width = 640, height = 480)
plot4 <- ggplot(agg, aes(factor(year), Emissions)) + 
         geom_bar(stat = "identity", aes(fill = year, color = year)) + 
         labs(title = expression(PM[2.5] * " sums from 1999-2008")) +
         labs(x = "Year", y = expression("Sum of " * PM[2.5] * " levels"))

print(plot4)
dev.off()



