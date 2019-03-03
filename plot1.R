

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

df <- df[df$Date == "2007-02-01" | df$Date == " 2007-02-02" ,  ]

png(filename = "plot1.png" , width = 480 , height = 480)

hist(df$Global_active_power , col = "red" , main = "Global Active Power" , xlab = "Global Active Power (kilowatts)")

dev.off()