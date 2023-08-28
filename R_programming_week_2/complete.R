source("getCorrectPath.R")

comboDF <- function(initial, additional) {
  if (nrow(initial) == 0) {
    additional
  } else {
    rbind(initial, additional)
  }
}

complete <- function(directory, id = 1:332) {
  
  # create empty data frame to store results with correct column names
  c <- data.frame()
  
  # loop through all files for ID vector
  for (i in 1:length(id)) {
    # get path to file
    path <- getCorrectPath(directory, id[i])
    # read file
    full <- read.csv(path)
    # return only complete cases
    cleanData <- na.omit(as.data.frame(full))
    # count nrow() to find number of complete cases & store in variable
    countComplete <- nrow(cleanData)
    idAndComplete <- data.frame(id = id[i], nobs = countComplete)
    # append to final data frame
    # c <- comboDF(c, idAndComplete)
    c <- rbind(c, idAndComplete)
  }
  
  # return the final data frame
  c
}