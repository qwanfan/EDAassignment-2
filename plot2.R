#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#   Use the base plotting system to make a plot answering this question.

NEI <- readRDS("./data/FNEI_data/summarySCC_PM25.rds")
NEI_Baltimore <- subset(NEI, fips == "24510")
NEI_Baltimore <- with(NEI_Baltimore, tapply(Emissions, year, mean, na.rm = T))
names(NEI_Baltimore)
plot(names(NEI_Baltimore),NEI_Baltimore,type = "l", xlab = "Year", ylab = "Emissions", col = "red")
dev.copy(png, file = "2.png")
dev.off()	
