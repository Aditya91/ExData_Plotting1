plot2 <- function()
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
  
  ##Make the plot
  plot(sub_data$Time,sub_data$Global_active_power,pch='.',xlab="",ylab="Global Active Power (kilowatts)")
  lines(sub_data$Time,sub_data$Global_active_power,type="l")
  
  ##Copy plot to PNG file and close device
  dev.copy(png,'plot2.png')
  dev.off()
}
