#set the download link and download the data file
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/power.zip")

#unzip the data
unzip(zipfile = "./data/power.zip", exdir = ".")

#load the libraries
library(sqldf)
library(lubridate)

#read onlythe relevant subset of the entire dataset into memory
feb <- read.csv.sql("household_power_consumption.txt", sep = ';', header = TRUE, sql="select * from file where Date in ('1/2/2007','2/2/2007')")

#create the plot1 and save it to a png file in the working directory
png(file="plot1.png",width=480,height=480)
hist(feb$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.off()