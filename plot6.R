# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# Answer: It's LA saw greater changes over time in motor vehicle emissions than Baltimore

library(dplyr)
library(ggplot2)
library(tidyr)

NEI <- readRDS("./data/FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/FNEI_data/Source_Classification_Code.rds")

unique(SCC$EI.Sector)
SCC_concise <- select(SCC, SCC, EI.Sector)

SCC_motor <- filter(SCC_concise, EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" | EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")

NEI_motor_Baltimore <- subset(NEI, fips == "24510" & SCC %in% SCC_motor$SCC)
NEI_motor_Baltimore_years <- group_by(NEI_motor_Baltimore,year)
NEI_motor_Baltimore_mean <- summarize(NEI_motor_Baltimore_years,pm25 = mean(Emissions, na.rm = TRUE))
NEI_motor_Baltimore_mean_df <- as.data.frame(NEI_motor_Baltimore_mean)

NEI_motor_LA <- subset(NEI, fips == "06037" & SCC %in% SCC_motor$SCC)
NEI_motor_LA_years <- group_by(NEI_motor_LA,year)
NEI_motor_LA_mean <- summarize(NEI_motor_LA_years,pm25 = mean(Emissions, na.rm = TRUE))
NEI_motor_LA_mean_df <- as.data.frame(NEI_motor_LA_mean)

NEI_motor <- merge(NEI_motor_Baltimore_mean_df, NEI_motor_LA_mean_df, by = "year")
NEI_motor_df <- gather(NEI_motor, City, Emissions, -year)
NEI_motor_df$City[which(NEI_motor_df$City == "pm25.x")] = "Baltimore"
NEI_motor_df$City[which(NEI_motor_df$City == "pm25.y")] = "LA"
NEI_motor_df

ggplot(NEI_motor_df, aes(x = year, y= Emissions, color = City)) + geom_line() 
dev.copy(png, file = "6.png")
dev.off()	