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

#change the PM2.5values to numerics
ninety_nine_sub$Emissions <- as.numeric(ninety_nine_sub$Emissions)
oh_two$Emissions <- as.numeric(oh_two$Emissions)
oh_five$Emissions <- as.numeric(oh_five$Emissions)
oh_eight$Emissions <- as.numeric(oh_eight$Emissions)

#summing the columns
Sum_baltimore <- c(sum(ninety_nine_sub$Emissions),sum(oh_two$Emissions), sum(oh_five$Emissions), sum(oh_eight$Emissions))
Years <- c("1999", "2002", "2005", "2008")

#make the plot
png("plot2.png", width = 640, height = 480)
plot(Years, Sum_baltimore, typ = "l", ylab = "Baltimore PM2.5 Sum Emissions")
points(Years, Sum_baltimore, pch = 20, cex = 2)
dev.off()