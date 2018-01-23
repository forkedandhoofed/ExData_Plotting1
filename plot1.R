
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


png("plot1.png")
hist(filteredHPC$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
