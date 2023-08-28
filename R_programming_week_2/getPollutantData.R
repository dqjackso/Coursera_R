getPollutantData <- function(path, pollutant) {
  # read the csv
  full <- read.csv(path)
  # create a data frame with the values from the pollutant column
  d <- as.data.frame(full[pollutant])
  # return the data frame without NA values
  na.omit(d)
}