plot4 <- function()
{
  ##Read the input file and subset it for just the two days February 1, 2007 and February 2, 2007
  ##Also convert the date and time values to operable formats
  library(dplyr)
  datas <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))
  new_data <- datas
  new_data$Date <- as.Date(datas$Date, format = "%d/%m/%Y")
  sub_data <- filter(new_data, Date >= "2007-02-01" & Date < "2007-02-03")
  sub_data$timetemp <- paste(sub_data$Date, sub_data$Time)
  sub_data$Time <- strptime(sub_data$timetemp, format = "%Y-%m-%d %H:%M:%S")
  sub_data <- sub_data[,c(1,2,10,3:9)]
  
  ##Modifying the plotting area to contain 4 plots and also change the padding
  par(mfrow=c(2,2))
  par(mar=c(4,4,2,2))
  
  ##Make plot 1 at (1,1)
  plot(sub_data$Time,sub_data$Global_active_power,pch='.',xlab="",ylab="Global Active Power")
  lines(sub_data$Time,sub_data$Global_active_power,type="l")
  
  ##Make plot 2 at (1,2)
  plot(sub_data$Time,sub_data$Voltage,pch='.',ylab="Voltage", xlab="datetime")
  lines(sub_data$Time,sub_data$Voltage,type="l")
  
  ##Make plot 3 at (2,1)
  plot(sub_data$Time,sub_data$Sub_metering_1,pch='.',xlab="",ylab="Energy sub metering", type="l")
  lines(sub_data$Time,sub_data$Sub_metering_2,col="red")
  lines(sub_data$Time,sub_data$Sub_metering_3,col="blue")
  
  ##Make plot 4 at (2,2)
  plot(sub_data$Time,sub_data$Global_reactive_power,pch='.',xlab="datetime",ylab="Global Reactive Power")
  lines(sub_data$Time,sub_data$Global_reactive_power,type="l")
  
  ##Copy plot to PNG file and close the device
  dev.copy(png,'plot4.png')
  dev.off()
}
