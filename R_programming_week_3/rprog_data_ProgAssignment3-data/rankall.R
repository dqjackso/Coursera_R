source("helpers.R")

## Read outcome data
data <- read.csv("outcome-of-care-measures.csv")

all_rankhospital <- function(state, outcome, num) {
  # Get data for the state
  state_hospitals <- data[data$State == state, ]
  
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

rankall <- function(outcome, num = "best") {
  ## Formatting
  outcome <- tolower(outcome)
  
  ## Check that state and outcome are valid
  check(outcome = outcome)
  
  ans <- data.frame()
  
  ## For each state, find the hospital of the given rank
  for (s in sort(state.abb)) {
    hospital <- all_rankhospital(s, outcome, num)
    ans <- rbind(ans, data.frame(hospital = hospital, state = s))
  }
  
  ## Return a data frame with the hospital names and the abbreviated
  ## state name that are {num} for {outcome} from all states
  ans
}