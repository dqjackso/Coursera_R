valid_outcomes <- c("heart attack", "heart failure", "pneumonia")

check <- function(state = "AZ", outcome) {
  ## Check that state and outcome are valid
  if (nchar(state) != 2 | !state %in% state.abb) {
    stop("invalid state")
  }
  
  if (!outcome %in% valid_outcomes) {
    stop("invalid outcome")
  }
}

get_state_data <- function(state) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Return hospital name in that state with lowest 30-day death rate
  ## Filter to only hospitals in the state
  data[data$State == state, ]
}