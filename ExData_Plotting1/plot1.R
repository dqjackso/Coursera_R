# Checks for the correct data set to be loaded

if (!exists("trimmed_hpc")) stop("Dataset 'trimmed_hpc' does not exist. Please run the functions from read_household_data.R before creating plots.")

# Create the graphics device PNG

png(filename = "plot1.png",
    width = 480,
    height = 480, 
    units = "px")

# Create the base histogram

with(trimmed_hpc, hist(
  Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency"
))

dev.off()