

## Download and unzip the dataset: 

filename <- "exdata_data_household_power_consumption.zip" 

if (!file.exists(filename)){ 
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
  download.file(fileURL, filename, method="curl") 
}   
if (!file.exists("household_power_consumption")) {  
  unzip(filename)  
} 

library(data.table)

df <- as.data.frame(fread( input = "household_power_consumption.txt" , na.strings = c("NA" , "?" )))

df$Date <- as.Date(df$Date , format = "%d/%m/%Y")

df$Time <- format(df$Time , format = "%T" , usetz = FALSE)

df <- df[df$Date == "2007-02-01" | df$Date == "2007-02-02" ,  ]

df$tiempo <- as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")

png(filename = "plot4.png" , width = 480 , height = 480)

par(mfrow=c(2,2))

plot(x = df$tiempo , y = df$Global_active_power  , type = "l" ,  main = "" , ylab = "Global Active Power" , xlab = "")

plot(x = df$tiempo , y = df$Voltage  , type = "l" ,  main = "" , ylab = "Voltage" , xlab = "datetime")

plot(x = df$tiempo , y = df$Sub_metering_1  , type = "l"  , col = "black" , main = "" , ylab = "Energy sub metering" , xlab = "")

lines(x = df$tiempo , y = df$Sub_metering_2 , col = "red")

lines(x = df$tiempo , y = df$Sub_metering_3 , col = "blue")

legend( x =  "topright"  ,legend=c( "Sub_metering_1" , "Sub_metering_2" , "Sub_metering_3" ) , col = c("black" , "red" , "blue") , lty = 1)

plot(x = df$tiempo , y = df$Global_reactive_power  , type = "l" ,  main = "" , ylab = "Global_reactive_power" , xlab = "datetime")

dev.off()