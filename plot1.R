## First read from your default working directory the *.txt file 
## Read in a subset of the data starting from 1 Feb 2007
## Read in slightly more rows just beyond 3 Feb 2007
library(data.table)
houseData <- ("./household_power_consumption.txt")
hhData <- fread(houseData, nrows = 3500, header = FALSE, verbose = F, skip = "1/2/2007")
setnames(hhData, c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
hhData$Date <- as.Date(hhData$Date, "%d/%m/%Y")

## Now subset the data to include only 1 and 2 Feb

hhData <- subset(hhData, hhData$Date == "2007-02-01" | hhData$Date == "2007-02-02")
#hhData$Date_Time <- paste(hhData$Date, hhData$Time, sep = " ")
#z <- strptime(hhData$Date_Time, "%d/%m/%Y %H:%M:%S")

##  Now publish a plot to your default R working directory.
png(file = "plot1.png", width = 480, height = 480)
hist(hhData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()