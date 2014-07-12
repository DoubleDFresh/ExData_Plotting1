## First read from your default working directory the *.txt file 
## Read in a subset of the data starting from 1 Feb 2007
## Read in slightly more rows just beyond 3 Feb 2007
houseData <- ("./household_power_consumption.txt")
hhData <- fread(houseData, nrows = 3500, header = FALSE, verbose = F, skip = "1/2/2007")
setnames(hhData, c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
hhData$Date <- as.Date(hhData$Date, "%d/%m/%Y")

## Now subset the data to include only 1 and 2 Feb

hhData <- subset(hhData, hhData$Date == "2007-02-01" | hhData$Date == "2007-02-02")

##  Concatenate date and time.  Cast as data.table because this supports POSIXct
##  Convert Date_Time column to POSIXct
hhData$Date_Time <- paste(hhData$Date, hhData$Time)
hhData <- as.data.frame(hhData)
hhData$Date_Time <- as.POSIXct(hhData$Date_Time)


##  Now publish a plot to your default R working directory.
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

with(hhData, {
        plot(hhData$Date_Time,hhData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(hhData$Date_Time,hhData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        plot(hhData$Date_Time,hhData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
                lines(hhData$Date_Time,hhData$Sub_metering_2, type = "l", col = "red")
                lines(hhData$Date_Time,hhData$Sub_metering_3, type = "l", col = "blue")
                legend("topright", col = c("black", "red", "blue"), lwd = 2, bty ="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(hhData$Date_Time,hhData$Global_reactive_power, type = "l", xlab = "datetime", ylab ="Global_reactive_power")
})

dev.off()