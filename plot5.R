# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(dplyr)
library(ggplot2)

NEI <- readRDS("./data/FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./data/FNEI_data/Source_Classification_Code.rds")

unique(SCC$EI.Sector)
SCC_concise <- select(SCC, SCC, EI.Sector)

SCC_motor <- filter(SCC_concise, EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" | EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")
NEI_motor_Baltimore <- subset(NEI, fips == "24510" & SCC %in% SCC_motor$SCC)
NEI_motor_Baltimore_years <- group_by(NEI_motor_Baltimore,year)
NEI_motor_Baltimore_mean <- summarize(NEI_motor_Baltimore_years,pm25 = mean(Emissions, na.rm = TRUE))
NEI_motor_Baltimore_mean_df <- as.data.frame(NEI_motor_Baltimore_mean)
NEI_motor_Baltimore_mean_df 

ggplot(NEI_motor_Baltimore_mean_df, aes(x = year, y= pm25, group = 1)) + geom_line(col = "red")
dev.copy(png, file = "5.png")
dev.off()	