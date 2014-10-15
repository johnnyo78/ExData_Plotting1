###
### Course Assignment #1: plot4.R
###
#install.packages("sqldf");
library(sqldf);

#Import the range of interest from the datafile
datafile <- "./data/household_power_consumption.txt";
cls <- c(Global_active_power="numeric", Global_reactive_power="numeric", Voltage="numeric", Global_intensity="numeric");
indata <- read.csv.sql(datafile, sep=";", header=T, sql = "SELECT * from file WHERE Date IN ('1/2/2007','2/2/2007')", colClasses=cls);
indata$DateTime <- strptime(paste(indata$Date, indata$Time), "%d/%m/%Y %H:%M:%S");
indata$DayOfWeek <- weekdays(indata$DateTime, abbreviate=T); # Not needed, but useful for correlating data w graphs

#Plot the information
par(mfrow = c(2,2));
plot(indata$DateTime, indata$Global_active_power, xlab="", ylab="Global Active Power", typ="l");
plot(indata$DateTime, indata$Voltage, xlab="datetime", ylab="Voltage", typ="l");
plot(indata$DateTime, y, xlab="", ylab="Energy sub metering", typ="n", yaxt="n", ylim=c(0,40));
axis(2,at=seq(0,30,10));
points(indata$DateTime, indata$Sub_metering_1, col="Black", typ="l", pch=27);
points(indata$DateTime, indata$Sub_metering_2, col="Red", typ="l", pch=27);
points(indata$DateTime, indata$Sub_metering_3, col="Blue", typ="l", pch=27);
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("Black","Red","Blue"), lty=1, bty="n");
plot(indata$DateTime, indata$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", typ="l");

#Copy to PNG format and close the device
dev.copy(png, filename="plot4.png", width=480, height=480, units="px");
dev.off();
