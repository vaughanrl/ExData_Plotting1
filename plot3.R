## Getting full dataset
powerData <- read.csv("household_power_consumption.txt", 
                      header=T, 
                      sep=';', 
                      na.strings="?", 
                      nrows=2075259, 
                      check.names=F, 
                      stringsAsFactors=F, 
                      comment.char="", 
                      quote='\"')

powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")

## Subset the data for required dates
powerData <- subset(powerData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Convert dates
newDates <- paste(as.Date(powerData$Date), powerData$Time)
powerData$Datetime <- as.POSIXct(newDates)

## Plot 2
with(powerData,
     {plot(Sub_metering_1~Datetime,
           type="l",
           ylab="Global Active Power (kilowatts)",
           xlab="")
       lines(Sub_metering_2~Datetime, col='Red')
       lines(Sub_metering_3~Datetime, col='Blue')
     })
legend("topright",
       col=c("black", "red", "blue"),
       lty=1,
       lwd=2,
       legend=c("Sub_metering_1", "Sub_meering_2", "Sub_metering_3"))

## Saving to PNG file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()