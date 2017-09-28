setwd("./datasciencecoursera/C4Project1")

#reading 100000 lines of the file
df <- read.table("./household_power_consumption.txt", header=TRUE, sep = ";", stringsAsFactors=FALSE, nrows = 100000)

#creating Datetime variable
df$Datetime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

#changing df$Date class from character to date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

#subsetting the needed timeframe
df <- df[df$Date %in% as.Date("01-02-2007", "%d-%m-%Y") : as.Date("02-02-2007", "%d-%m-%Y"),]

#Creating and saving the plot
df$Global_active_power <- as.numeric(df$Global_active_power)
hist(df$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Powe (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()
