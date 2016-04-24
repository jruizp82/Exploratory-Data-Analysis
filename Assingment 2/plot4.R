# Read the data file
## This two lines will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Libraries needed:
library(plyr)
library(ggplot2)

coalcomb.scc <- subset(SCC, EI.Sector %in% 
                               c("Fuel Comb - Comm/Instutional - Coal",
                                 "Fuel Comb - Electric Generation - Coal", 
                                 "Fuel Comb - Industrial Boilers, ICEs - Coal"))

coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)

coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

#rename the col
colnames(coalcomb.pm25year)[3] <- "Emissions"

png("plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + 
        stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
                     color = "purple", aes(shape="total"), geom="line") + 
        geom_line(aes(size="total", shape = NA)) + 
        ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + 
        xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()