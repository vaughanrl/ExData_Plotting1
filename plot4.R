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

## Plot 4
par(mfrow=c(2,2),
    mar=c(4,4,2,1),
    oma=c(00,0,2,0))
with(powerData,
     {plot(Global_active_power~Datetime,
           type="l",
           ylab="Global Active Power (kilowatts)",
           xlab="")
       plot(Voltage~Datetime,
            type="l",
            ylab="Voltage (volt)",
            xlab="datetime")       
       plot(Sub_metering_1~Datetime,
            type="l",
            ylab="Energy sub metering",
            xlab="")       
       lines(Sub_metering_2~Datetime, col='Red')
       lines(Sub_metering_3~Datetime, col='Blue')
       legend("topright",
              col=c("black", "red", "blue"),
              lty=1,
              lwd=2,
              bty="n",
              legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
       plot(Global_reactive_power~Datetime,
            type="l",
            ylab="Global Reactive Power (kilowatts)",
            xlab="datetime")
       })

## Saving to PNG file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()