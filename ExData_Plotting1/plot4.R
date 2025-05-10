# Checks for the correct data set to be loaded

if (!exists("trimmed_hpc")) stop("Dataset 'trimmed_hpc' does not exist. Please run the functions from read_household_data.R before creating plots.")

# Create the graphics device PNG

png(filename = "plot4.png",
    width = 480,
    height = 480, 
    units = "px")

par(mfrow = c(2,2))

# Same as plot 2

with(trimmed_hpc, plot(
  Global_active_power ~ Combined_Dates,
  type = "l",
  xaxt = "n",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
))

axis(
  1,
  at = seq(min(trimmed_hpc$Combined_Dates), max(trimmed_hpc$Combined_Dates), length.out = 3),
  labels = c("Thur", "Fri", "Sat")
)

# Different plot

with(trimmed_hpc, plot(
  Voltage ~ Combined_Dates,
  type = "l",
  xaxt = "n",
  xlab = "datetime",
  ylab = "Voltage"
))

axis(
  1,
  at = seq(min(trimmed_hpc$Combined_Dates), max(trimmed_hpc$Combined_Dates), length.out = 3),
  labels = c("Thur", "Fri", "Sat")
)

# Same as plot 3

with(trimmed_hpc, plot(
  Sub_metering_1 ~ Combined_Dates, 
  type = "l", 
  xaxt = "n", 
  xlab = "", 
  ylab = "Energy sub metering"))

with(trimmed_hpc, lines(
  Sub_metering_2 ~ Combined_Dates, 
  col = "red"))

with(trimmed_hpc, lines(
  Sub_metering_3 ~ Combined_Dates, 
  col = "blue"))

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lwd = 2,
       box.lwd = 0)

axis(
  1,
  at = seq(min(trimmed_hpc$Combined_Dates), max(trimmed_hpc$Combined_Dates), length.out = 3),
  labels = c("Thur", "Fri", "Sat")
)

# Different plot

with(trimmed_hpc, plot(
  Global_reactive_power ~ Combined_Dates,
  type = "l",
  xaxt = "n",
  xlab = "datetime",
  ylab = "Global_reactive_power"
))

axis(
  1,
  at = seq(min(trimmed_hpc$Combined_Dates), max(trimmed_hpc$Combined_Dates), length.out = 3),
  labels = c("Thur", "Fri", "Sat")
)

dev.off()
