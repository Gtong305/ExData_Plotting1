library(lubridate)
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()

download.file(fileurl, temp, mode="wb") ## "wb" for binary files

unzip(temp, "household_power_consumption.txt")
raw_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrow = 117603, na.strings = "?")
raw_data$datetime <- paste(raw_data[,1], raw_data[,2], sep = " ") ## merge date and time columns
raw_data$datetime <- dmy_hms(raw_data$datetime) ## convert to datetime format

clean_data <- raw_data[grepl("2007-02-01|2007-02-02", raw_data$datetime),]

png(filename = "plot3.png")

with(clean_data, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(clean_data, points(datetime, Sub_metering_2, type = "l", col = "red"))
with(clean_data, points(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

dev.off()

unlink(temp)
