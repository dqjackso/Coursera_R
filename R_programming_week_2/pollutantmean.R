source("cleanData.R")

pollutantmean <- function(directory, pollutant, id = 1:332) {
  # get the cleaned data frame for the pollutant values for the IDs
  clean <- cleanData(directory, pollutant, id)
  # return the mean of the pollutant values
  mean(clean[[pollutant]])
}