library(dplyr)
library(ggplot2)


#download the file to a file in the Working Directory
if(!file.exists("./data/peer_unzipped")){
    dir.create("./data/peer_unzipped")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
temp <- tempfile()
if(!file.exists("./data/peer_assesment.zip")){
    download.file(url, temp, mode = "wb")
}

NEI <- readRDS("./data/summarySCC_PM25.rds")
#SCC <- readRDS("./data/Source_Classification_Code.rds")
unlink(temp)

#subset data to only fips == 24510
baltimore_sub <- subset(NEI, fips == 24510)
ninety_nine_sub <- subset(baltimore_sub, year == 1999)
oh_two <- subset(baltimore_sub, year == 2002)
oh_five <- subset(baltimore_sub, year == 2005)
oh_eight <- subset(baltimore_sub, year == 2008)

#subset by type
aggregated_totals <- aggregate(Emissions ~ year + type, baltimore_sub, sum)

png("plot3.png", width = 640, height = 480)
g <- qplot(year, Emissions, data = aggregated_totals, facets = . ~type)
print(g)
dev.off()