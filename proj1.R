
# set the directory totest
setwd("C:/Users/Dropbox/R/Exdata/proj1/exdata-data-household_power_consumption/")

#read part of the data files to get the classes of the columns
partdata <- read.table("household_power_consumption.txt",sep=";", header=TRUE, nrows = 5)
classes <- sapply(partdata,class)

# read the table
proj1data <- read.table("household_power_consumption.txt",sep=";", header=TRUE, colClasses = classes, na.strings="?")

#create new Date and Time vars
proj1data$Date1 <- as.Date(proj1data$Date, "%d/%m/%Y")
#proj1data$Date2 <-strptime(proj1data$Date, "%d/%m/%Y")
proj1data_part <- proj1data[ which(proj1data$Date1 =='2007-02-01' | proj1data$Date1 == '2007-02-02'),]
proj1data_part$Time1 <- strptime(proj1data_part$Time,"%H:%M:%S")
#classes <- sapply(proj1data_part,class)
#classes
#windows()

png(filename = "plot1.png", width = 480, height = 480)
hist(proj1data_part$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
# create a combined data and time column
proj1data_part$Date3 <- strptime(paste(proj1data_part$Date,proj1data_part$Time), "%d/%m/%Y %H:%M:%S")
#proj1data_part$Dayweek <- weekdays(proj1data_part$Date1)
png(filename = "plot2.png", width = 480, height = 480)
plot(proj1data_part$Date3,proj1data_part$Global_active_power,type = "l", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
png(filename = "plot3.png", width = 480, height = 480)
plot(proj1data_part$Date3,proj1data_part$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(proj1data_part$Date3,proj1data_part$Sub_metering_2,type="l",col="red")
lines(proj1data_part$Date3,proj1data_part$Sub_metering_3,type="l",col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)
dev.off()
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(1, 1, 1, 1))
with(proj1data_part, {
  plot(Date3,Global_active_power,type = "l", xlab="",ylab="Global Active Power")
  plot(Date3,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
  lines(Date3,Sub_metering_2,type="l",col="red")
  lines(Date3,Sub_metering_3,type="l",col="blue")
  legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)
  plot(Date3, Voltage, type = "l",xlab="datetime",ylab="Voltage")
  plot(Date3, Global_reactive_power,  type = "l",xlab="datetime",ylab="Global reactive power")
})

dev.off()