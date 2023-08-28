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