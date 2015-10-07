plot1 <- function()
{
  library(dplyr)
  datas <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))
  new_data <- datas
  new_data$Date <- as.Date(datas$Date, format = "%d/%m/%Y")
  sub_data <- filter(new_data, Date >= "2007-02-01" & Date < "2007-02-03")
  sub_data$timetemp <- paste(sub_data$Date, sub_data$Time)
  sub_data$Time <- strptime(sub_data$timetemp, format = "%Y-%m-%d %H:%M:%S")
  sub_data <- sub_data[,c(1,2,10,3:9)]
  hist(sub_data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
  dev.copy(png,'plot1.png')
  dev.off()
  
}