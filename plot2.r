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
power2days <- mutate(power2days, Date = as.Date(power2days$Date, format = "%d/%m/%Y"))

# Open PNG graphics device
png(filename = "plot2.png", width = 480, height = 480)

# Plot into graphics device
plot(ymd_hms(paste(power2days$Date, power2days$Time)), power2days$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(ymd_hms(paste(power2days$Date, power2days$Time)), power2days$Global_active_power, type = "l")

# Dispose of graphics device
dev.off()
