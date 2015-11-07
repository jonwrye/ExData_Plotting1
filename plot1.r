# Install dpylr package if not available
if (!require("dplyr")) {
  install.packages("dplyr")
}
# Load dplyr library
require(dplyr)

# Read in the data
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Subset needed data and clean it for use
power2days <- filter(power, Date == "1/2/2007" | Date == "2/2/2007")
power2days <- mutate(power2days, Global_active_power = as.numeric(Global_active_power))
power2days <- mutate(power2days, Date = as.Date(power2days$Date, format = "%d/%m/%Y"))

# Open PNG graphics device
png(filename = "plot1.png", width = 480, height = 480)

# Plot into graphics device
hist(power2days$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

# Dispose of graphics device
dev.off()