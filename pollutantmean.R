getCorrectPath <- function(directory, id) {
  # format path correctly to always have 3 numbers
  if(id < 10) {
    path <- paste(directory, "/", "00", id, ".csv", sep = "")
  } else if (id >= 10 & id <= 99) {
    path <- paste(directory, "/", "0", id, ".csv", sep = "")
  } else {
    path <- paste(directory, "/", id, ".csv", sep = "")
  }
  # return correctly formatted path
  path
}

getData <- function(path, pollutant) {
  # read the csv
  full <- read.csv(path)
  # create a data frame with the values from the pollutant column
  d <- as.data.frame(full[pollutant])
  # return the data frame without NA values
  na.omit(d)
}

cleanData <- function(directory, pollutant, id) {
  # create empty data frame to store final data frame
  data <- data.frame()
  
  # loop through id values for CSVs
  for (i in 1:length(id)) {
    # use getCorrectPath to format the file path
    filepath <- getCorrectPath(directory, id[i])
    # use getData to bind pollutant data to the compiled data frame
    data <- rbind(data, getData(filepath, pollutant))
  }
  
  # return full data frame
  data
}

pollutantmean <- function(directory, pollutant, id = 1:332) {
  # get the cleaned data frame for the pollutant values for the IDs
  clean <- cleanData(directory, pollutant, id)
  # return the mean of the pollutant values
  mean(clean[[pollutant]])
}