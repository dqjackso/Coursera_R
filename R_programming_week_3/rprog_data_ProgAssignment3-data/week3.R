valid_outcomes <- c("heart attack", "heart failure", "pneumonia")

best <- function(state, outcome) {
  ## Format state and outcome
  state <- toupper(state)
  outcome <- tolower(outcome)
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  if (nchar(state) != 2 | !state %in% state.abb) {
    stop("invalid state")
  }
  
  if (!outcome %in% valid_outcomes) {
    stop("invalid outcome")
  }
  
  ## Return hospital name in that state with lowest 30-day death rate
  ## Filter to only hospitals in the state
  state_hospitals <- data[data$State == state, ]
  
  ## Remove NA values and return the minimum lowest rate associated with the outcome
  suppressWarnings(
    if (outcome == "heart attack") {
      state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
      lowest <- min(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, na.rm = TRUE)
      winner <- subset(state_hospitals, state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == lowest, Hospital.Name)
    } else if (outcome == "heart failure") {
      state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
      lowest <- min(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, na.rm = TRUE)
      winner <- subset(state_hospitals, state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == lowest, Hospital.Name)
    } else if (outcome == "pneumonia") {
      state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
      lowest <- min(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, na.rm = TRUE)
      winner <- subset(state_hospitals, state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == lowest, Hospital.Name)
    }
  )
  
  ## Find hospitals with the lowest rate in alphabetical order
  ## Return the first hospital
  sort(winner$Hospital.Name)[1]
}

rankhospital <- function(state, outcome, num) {
  ## Read outcome data
  
  ## Check that the state and outcome are valid
  
  ## Return a vector containing the name of the hospital with the 
  ## {num} lowest death rate for {outcome} from {state}
}

rankall <- function(outcome, num = "best") {
  ## Read outcome data
  
  ## Check that state and outcome are valid
  
  ## For each state, find the hospital of the given rank
  
  ## Return a data frame with the hospital names and the abbreviated
  ## state name that are {num} for {outcome} from all states
}