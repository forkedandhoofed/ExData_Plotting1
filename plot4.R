
# Download Data -----------------------------------------------------------

library(dplyr)

if (!file.exists("./data")) {
    dir.create("./data")
}

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "./data/hpc.zip"
download.file(fileURL, destFile, method = "curl")

unzippedFile <- unzip(destFile, exdir = "./data")

hpc <- read.table(unzippedFile, header = TRUE, sep = ";", stringsAsFactors = FALSE,
                  na.strings = "?", dec = ".")

filteredHPC <- hpc[hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007", ]

detailedTime <- strptime(paste(filteredHPC$Date, filteredHPC$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")


# Plot & Export PNG -------------------------------------------------------

png("plot4.png")
par(mfrow = c(2, 2))
plot(detailedTime, filteredHPC$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(detailedTime, filteredHPC$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(detailedTime, filteredHPC$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
points(detailedTime, filteredHPC$Sub_metering_2, type = "l", col = "red")
points(detailedTime, filteredHPC$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
plot(detailedTime, filteredHPC$Global_reactive_power, type = "l", xlab = "datetime", ylab = "global_reactive_power")
dev.off()
