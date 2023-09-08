source("helpers.R")

rankhospital <- function(state, outcome, num) {
  ## Format state and outcome
  state <- toupper(state)
  outcome <- tolower(outcome)
  
  ## Check state and outcome
  check(state, outcome)
  
  # Get data for the state
  state_hospitals <- get_state_data(state)
  
  ## Return a vector containing the name of the hospital with the 
  ## {num} lowest death rate for {outcome} from {state}
  suppressWarnings(
    if (outcome == "heart attack") {
      state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
      ranked <- state_hospitals[order(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, state_hospitals$Hospital.Name, na.last = NA),]
    } else if (outcome == "heart failure") {
      state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
      ranked <- state_hospitals[order(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, state_hospitals$Hospital.Name, na.last = NA),]
    } else if (outcome == "pneumonia") {
      state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
      ranked <- state_hospitals[order(state_hospitals$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, state_hospitals$Hospital.Name, na.last = NA),]
    }
  )
  
  if (num == "best") {
    ranked$Hospital.Name[1]
  } else if (num == "worst") {
    tail(ranked$Hospital.Name, n = 1)
  } else {
    ranked$Hospital.Name[num]
  }
}