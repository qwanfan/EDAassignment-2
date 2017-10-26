#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system,
#   make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("./data/FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/FNEI_data/Source_Classification_Code.rds")
head(NEI)
NEI_year <- with(NEI, tapply(Emissions, year, mean, na.rm = T))
NEI_year
names(NEI_year)
plot(names(NEI_year),NEI_year,type = "l", xlab = "Year", ylab = "Emissions", col = "green")
dev.copy(png, file = "1.png")
dev.off()	
