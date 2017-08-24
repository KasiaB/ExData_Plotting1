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

#merge date and time variables to create a new variable, transform it into a datetime variable
feb$dateTime <- paste(feb$Date,feb$Time)
feb$dateTime <- dmy_hms(feb$dateTime)

#create the plot3 and save it to a png file in the working directory
png(file="plot3.png",width=480,height=480)
plot(feb$dateTime,feb$Sub_metering_1,pch="",xlab = "",ylab="Energy sub metering")
lines(feb$dateTime,feb$Sub_metering_1,col="black")
lines(feb$dateTime,feb$Sub_metering_2,col="red")
lines(feb$dateTime,feb$Sub_metering_3,col="blue")
legend("topright",pch = "",lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()