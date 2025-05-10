# Checks for the correct data set to be loaded

if (!exists("trimmed_hpc")) stop("Dataset 'trimmed_hpc' does not exist. Please run the functions from read_household_data.R before creating plots.")

# Create the graphics device PNG

png(filename = "plot2.png",
    width = 480,
    height = 480, 
    units = "px")

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

dev.off()