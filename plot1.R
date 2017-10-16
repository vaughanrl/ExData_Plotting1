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
powerData$Datetime <- as.POSIXct(newDates )

## Plot 1
hist(powerData$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", col="Red")

## Saving to PNG file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()