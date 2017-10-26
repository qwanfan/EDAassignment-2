#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases 
#   in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?
#   Use the ggplot2 plotting system to make a plot answer this question.


library(ggplot2)
library(dplyr)

NEI <- readRDS("./data/FNEI_data/summarySCC_PM25.rds")
NEI_Baltimore <- subset(NEI, fips == "24510")
NEI_Baltimore_group <- group_by(NEI_Baltimore, type, year)
NEI_Baltimore_mean <- summarize(NEI_Baltimore_group, pm25 = mean(Emissions, na.rm = TRUE))
NEI_Baltimore_mean_df <- as.data.frame(NEI_Baltimore_mean)
NEI_Baltimore_mean_df 
ggplot(NEI_Baltimore_mean_df, aes(x = year, y= pm25, col = type, group = type)) + geom_line() 
dev.copy(png, file = "3.png")
dev.off()	