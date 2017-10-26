# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(dplyr)
library(ggplot2)

NEI <- readRDS("./data/FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/FNEI_data/Source_Classification_Code.rds")

unique(SCC$EI.Sector)
SCC_concise <- select(SCC, SCC, EI.Sector)

SCC_coal <- filter(SCC_concise, EI.Sector == "Fuel Comb - Electric Generation - Coal" | EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal" | EI.Sector == "Fuel Comb - Comm/Institutional - Coal")
NEI_coal <- subset(NEI, SCC %in% SCC_coal$SCC)
NEI_coal_years <- group_by(NEI_coal,year)
NEI_coal_mean <- summarize(NEI_coal_years,pm25 = mean(Emissions, na.rm = TRUE))
NEI_coal_mean_df <- as.data.frame(NEI_coal_mean)
NEI_coal_mean_df 
ggplot(NEI_coal_mean_df, aes(x = year, y= pm25, group = 1)) + geom_line(col = "red") 
dev.copy(png, file = "4.png")
dev.off()	