# Read the data file
## This two lines will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Libraries needed:
library(plyr)
library(ggplot2)

MV <- subset(NEI, (fips == "24510" | fips == "06037") & type=="ON-ROAD")

MV <- transform(MV,region = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))

MVPM25ByYearAndRegion <- ddply(MV, .(year, region), function(x) sum(x$Emissions))
colnames(MVPM25ByYearAndRegion)[3] <- "Emissions"

png("plot6.png")
qplot(year, Emissions, data=MVPM25ByYearAndRegion, geom="line", color=region) +
        #qplot(year, Emissions, data=MVPM25ByYearAndRegion, geom="line", facets=region~.) +
        ggtitle(expression("Baltimore City and Los Angeles County" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
        xlab("Year") +
        ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
