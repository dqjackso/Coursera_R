library(data.table)
library(chron)
# Download the data from the remote location

download_household_data <- function() {
  # Function downloads the data from remote and stores it in a global variable
  # titled 'hpc' for use in data operations.
  
  hpc <<- data.table::fread(file = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
}

convert_dates <- function() {
  # Converts all entries in Date column to be a Date object with format
  # YYYY-MM-DD
  
  if (exists("hpc")) {
    hpc[ , Date := as.Date(Date, format = "%d/%m/%Y")]
  } else stop("Data set global variable 'hpc' not found.")
}

get_date_range <- function() {
  # Trims down the global variable dataset to only be between the dates we need
  # specified in the assignment

  trimmed_hpc <<- hpc[Date %between% c("2007-02-01", "2007-02-02")]
}

convert_time <- function() {
  # Converts `Time` to be a chron times object with format HH:MM:SS
  
  trimmed_hpc[ , Time := times(Time)]
}

create_combined_date_time <- function() {
  # Creates new column with combined date time objects
  
  trimmed_hpc[ , ':='(Combined_Dates = as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC"))]
}

convert_power_chr_to_num <- function() {
  # Converts `Global_active_power` `Global_reactive_power` `Voltage` `Global_intensity`
  # `Sub_metering_1` `Sub_metering_2` `Sub_metering_3` to be of type numeric
  
  if (exists("trimmed_hpc")) {
    trimmed_hpc[ , Global_active_power := as.numeric(Global_active_power)]
    trimmed_hpc[ , Global_reactive_power := as.numeric(Global_reactive_power)]
    trimmed_hpc[ , Voltage := as.numeric(Voltage)]
    trimmed_hpc[ , Global_intensity := as.numeric(Global_intensity)]
    trimmed_hpc[ , Sub_metering_1 := as.numeric(Sub_metering_1)]
    trimmed_hpc[ , Sub_metering_2 := as.numeric(Sub_metering_2)]
    trimmed_hpc[ , Sub_metering_3 := as.numeric(Sub_metering_3)]
  } else stop("Global variable 'trimmed_hpc' not found. Please run get_date_range().")
}