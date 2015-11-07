# Install lubridate and dpylr packages if not available
if (!require("lubridate")) {
  install.packages("lubridate")
}
if (!require("dplyr")) {
  install.packages("dplyr")
}
# Load lubridate and dplyr libraries
require(lubridate)
require(dplyr)

# Read in the data
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Subset needed data and clean it for use
power2days <- filter(power, Date == "1/2/2007" | Date == "2/2/2007")
power2days <- mutate(power2days, Global_active_power = as.numeric(Global_active_power))
power2days <- mutate(power2days, Sub_metering_1 = as.numeric(Sub_metering_1))
power2days <- mutate(power2days, Sub_metering_2 = as.numeric(Sub_metering_2))
power2days <- mutate(power2days, Sub_metering_3 = as.numeric(Sub_metering_3))
power2days <- mutate(power2days, Date = as.Date(power2days$Date, format = "%d/%m/%Y"))

# Open PNG graphics device
png(filename = "plot3.png", width = 480, height = 480)

# Plot into graphics device
plot(ymd_hms(paste(power2days$Date, power2days$Time)), power2days$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(ymd_hms(paste(power2days$Date, power2days$Time)), power2days$Sub_metering_1, type = "l", col = "black")
lines(ymd_hms(paste(power2days$Date, power2days$Time)), power2days$Sub_metering_2, type = "l", col = "red")
lines(ymd_hms(paste(power2days$Date, power2days$Time)), power2days$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1)

# Dispose of graphics device
dev.off()
