# Download the file and put the file in the data folder
if(!file.exists("./../data")){dir.create("./../data")}
fileUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl,destfile="./../data/Dataset.zip")

# Unzip the file
unzip(zipfile="./../data/Dataset.zip",exdir="./../data")


dataFile <- "../data/household_power_consumption.txt"
data <- read.table(dataFile, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
subSetData <- data[data$Date %in% c("1/2/2007", "2/2/2007") ,]

globalActivePower <- as.numeric(subSetData$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(globalActivePower, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
