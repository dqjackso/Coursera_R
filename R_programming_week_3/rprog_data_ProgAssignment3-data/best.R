source("helpers.R")

best <- function(state, outcome) {
  ## Format state and outcome
  state <- toupper(state)
  outcome <- tolower(outcome)
  
  ## Check state and outcome
  check(state, outcome)
  
  # Get data for the state
  state_hospitals <- get_state_data(state)
  
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