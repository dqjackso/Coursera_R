source("getCorrectPath.R")
source("getPollutantData.R")

cleanData <- function(directory, pollutant, id) {
  # create empty data frame to store final data frame
  data <- data.frame()
  
  # loop through id values for CSVs
  for (i in 1:length(id)) {
    # use getCorrectPath to format the file path
    filepath <- getCorrectPath(directory, id[i])
    # use getPollutantData to bind pollutant data to the compiled data frame
    data <- rbind(data, getPollutantData(filepath, pollutant))
  }
  
  # return full data frame
  data
}