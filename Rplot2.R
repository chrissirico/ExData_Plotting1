# Run this code in same working directory as household_power_consumption.txt

library(readr)
library(lubridate)
library(dplyr)
power2 <- read.csv2("household_power_consumption.txt", dec = ".", na.strings = "?", skip = 66636, nrows = 2880) # read in rows for feb 1 & 2, 2007
names(power2) <- c("date", "time", "act_pwr", "react_pwr", "volts", "amps", "kitchen", "laundry", "ac") # assign names
power2 <-mutate(power2, datetime = as_datetime(dmy_hms(paste(date, time)))) # create date-time column from date and time factor variables

# I've verified there are no missing values with > assertthat::noNA(power2) 
#> TRUE

# CODE BOOK
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# Chart Global Active Power by kilowatt
# png("Rplot1.png") # create ping file
# hist(power2$act_pwr, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)") # create graph
# dev.off() # close ping device

# Chart Global Active Power as a function of time
png("Rplot2.png") # create ping file
with(power2, plot(datetime, act_pwr, type = "n"))
with(power2, lines(datetime, act_pwr, xlab = "Day", ylab = "Global Active Power"))
dev.off() # close ping device

# Similar w/ ggplot2
ggplot2::ggplot(power2, aes(datetime, act_pwr)) +
  geom_area() +
  xlab("Date") +
  ylab("Global Active Power")

