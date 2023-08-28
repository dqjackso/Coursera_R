source("getPollutantData.R")
source("getCorrectPath.R")
source("complete.R")

corr <- function(directory, threshold = 0){
  # get data frame of all complete cases in the directory
  completed <- complete(directory)
  
  # get data frame of IDs that meet the threshold requirement
  meets <- completed[completed$nobs > threshold, ]
  
  # create base vector to store results
  data <- c()
  
  # loop through each of the IDs that meet the threshold requirement
  for (id in meets$id) {
    # get the path to the CSV file for the ID
    path <- getCorrectPath(directory, id)
    # read the CSV into a data frame
    full <- as.data.frame(read.csv(path))
    nona <- na.omit(full)
    data <- append(data, cor(nona$sulfate, nona$nitrate))
  }
  
  data
}