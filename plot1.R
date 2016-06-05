library(dplyr)
library(ggplot2)


#download the file to a file in the Working Directory
if(!file.exists("./data/peer_unzipped")){
    dir.create("./data/peer_unzipped")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
temp <- tempfile()
#if(!file.exists("./data/peer_assesment.zip")){
#    download.file(url, temp, mode = "wb")
#}

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
unlink(temp)

#subsetting the data based on year
ninety_nine <- subset(NEI, year == 1999)
oh_two <- subset(NEI, year == 2002)
oh_five <- subset(NEI, year == 2005)
oh_eight <- subset(NEI, year == 2008)

#find sum of PM25 of each subset
ninety_nine$Emissions <- as.numeric(ninety_nine$Emissions)
oh_two$Emissions <- as.numeric(oh_two$Emissions)
oh_five$Emissions <- as.numeric(oh_five$Emissions)
oh_eight$Emissions <- as.numeric(oh_eight$Emissions)

Emissions_Sum <- c(sum(ninety_nine$Emissions), sum(oh_two$Emissions), sum(oh_five$Emissions), sum(oh_eight$Emissions))
Year <- c("1999", "2002", "2005", "2008")
Emissions_labels <- as.character(Emissions_Sum)
png("plot1.png", width = 640, height = 480)
plot(Year, Emissions_Sum, pch = 20, type = "l", ylab = "PM2.5 Sum")
points(Year, Emissions_Sum, pch = 20, cex = 2)
dev.off()


