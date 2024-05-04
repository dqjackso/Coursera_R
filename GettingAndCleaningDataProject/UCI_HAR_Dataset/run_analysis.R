# Import any necessary packages

if (!require(dplyr)) {
  install.packages("dplyr")
}

library(dplyr)

working_directory_check <- function() {
  # Function that checks if the environment is running in the correct working directory.
  # Continues if true, if false it stops all execution and throws an error to set to the correct
  # working directory.
  
  if (!endsWith(getwd(), "Dataset")) {
    stop("Please set your working directory to the folder containing the Dataset.")
  }
}

get_features <- function() {
  # Function with no arguments that reads the features.txt file, and returns it
  # as a dataframe named features.
  
  features <- data.table::fread("./features.txt")
  
  features
}

get_features_data <- function() {
  # Function with no arguments that reads the X_train.txt and X_test.txt data
  # for all of the calculated features, and returns a single data frame
  # containing all of the data labeled features_data.
  
  features_data <- rbind(data.table::fread("./train/X_train.txt"),
                         data.table::fread("./test/X_test.txt"))
  
  features_data
}

replace_features_labels <- function(features, features_data) {
  # Function that takes two arguments, and returns a single data frame.
  # First arg features is the data frame containing the names of the features.
  # Second arg features_data is the data frame containing the calculations for
  # each of the features.
  # Return data frame is the observations with a column name corresponding to 
  # the character string label for the feature.
  
  names(features_data) <- features$V2
  
  features_data
}

get_activity_labels <- function() {
  # Function with no arguments that reads the activity labels text file, and returns
  # it as a data frame labeled activity_labels
  
  activity_labels <- data.table::fread("./activity_labels.txt")
  
  activity_labels
}

get_activity_ID_list <- function() {
  # Function with no arguments that read the activity ID labels from both train
  # and test data sets, and returns them as a single data frame labeled
  # activity_ID_list. 
  
  activity_ID_list <- rbind(data.table::fread("./train/y_train.txt"),
                            data.table::fread("./test/y_test.txt"))
  
  activity_ID_list
}

replace_activity_names <- function(activity_labels, activity_ID_list) {
  # Function that takes a data frame of the list of activity ID numbers, 
  # replaces them in place with the string names of the corresponding activities,
  # and returns that data frame.
  
  for (ID in activity_labels$V1) {
    activity_ID_list$V1[activity_ID_list$V1==ID] <- activity_labels$V2[[ID]]
  }
  
  names(activity_ID_list) <- c("Activity")
  
  activity_ID_list
}

get_subject_list <- function() {
  # Function with no arguments the reads the subject ID numbers from both train and test
  # data sets, and returns them as a single data frame labeled subject_list
  
  subject_list <- rbind(data.table::fread("./train/subject_train.txt"),
                        data.table::fread("./test/subject_test.txt"))
  
  names(subject_list) <- c("Subject")
  
  subject_list
}

get_mean_std_features <- function(labeled_features_data) {
  # Function takes a single argument and returns a data frame.
  # Arg of labeled_features_data is the data frame on features that has had the
  # column names replaced with the names of the features.
  # The return data frame only contains the features for mean and standard
  # deviation.
  
  select(labeled_features_data, matches("mean|std"))
}

combined_data <- function() {
  # This is the higher level function which uses all of the lower level functions
  # to combine the test and train data sets, and create a final data set with 
  # tidy column names for the Subject, Activity, Features(mean & std only).
  
  working_directory_check()
  
  cbind(
    get_subject_list(),
    replace_activity_names(get_activity_labels(), get_activity_ID_list()),
    get_mean_std_features(replace_features_labels(get_features(), get_features_data()))
  )
}

# The functions below can be used to read in and combine the raw data observations.

get_body_acc_x_data <- function() {
  # Function that takes no arguments, reads the body accelerometer X axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_acc_x_data.
  
  body_acc_x_data <- rbind(data.table::fread("./train/Inertial_Signals/body_acc_x_train.txt"),
                           data.table::fread("./test/Inertial_Signals/body_acc_x_test.txt"))
  
  millisecond_labels(body_acc_x_data)
}

get_body_acc_y_data <- function() {
  # Function that takes no arguments, reads the body accelerometer Y axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_acc_Y_data.
  
  body_acc_y_data <- rbind(data.table::fread("./train/Inertial_Signals/body_acc_y_train.txt"),
                           data.table::fread("./test/Inertial_Signals/body_acc_y_test.txt"))
  
  millisecond_labels(body_acc_y_data)
}

get_body_acc_z_data <- function() {
  # Function that takes no arguments, reads the body accelerometer Z axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_acc_z_data.
  
  body_acc_z_data <- rbind(data.table::fread("./train/Inertial_Signals/body_acc_z_train.txt"),
                           data.table::fread("./test/Inertial_Signals/body_acc_z_test.txt"))
  
  millisecond_labels(body_acc_z_data)
}

get_body_gyro_x_data <- function() {
  # Function that takes no arguments, reads the body gyroscope X axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_gyro_x_data.
  
  body_gyro_x_data <- rbind(data.table::fread("./train/Inertial_Signals/body_gyro_x_train.txt"),
                           data.table::fread("./test/Inertial_Signals/body_gyro_x_test.txt"))
  
  millisecond_labels(body_gyro_x_data)
}

get_body_gyro_y_data <- function() {
  # Function that takes no arguments, reads the body gyroscope Y axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_gyro_y_data.
  
  body_gyro_y_data <- rbind(data.table::fread("./train/Inertial_Signals/body_gyro_y_train.txt"),
                            data.table::fread("./test/Inertial_Signals/body_gyro_y_test.txt"))
  
  millisecond_labels(body_gyro_y_data)
}

get_body_gyro_z_data <- function() {
  # Function that takes no arguments, reads the body gyroscope Z axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_gyro_z_data.
  
  body_gyro_z_data <- rbind(data.table::fread("./train/Inertial_Signals/body_gyro_z_train.txt"),
                            data.table::fread("./test/Inertial_Signals/body_gyro_z_test.txt"))
  
  millisecond_labels(body_gyro_z_data)
}

get_total_acc_x_data <- function() {
  # Function that takes no arguments, reads the total accelerometer X axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_total_x_data.
  
  body_total_x_data <- rbind(data.table::fread("./train/Inertial_Signals/body_total_x_train.txt"),
                            data.table::fread("./test/Inertial_Signals/body_total_x_test.txt"))
  
  millisecond_labels(body_total_x_data)
}

get_total_acc_y_data <- function() {
  # Function that takes no arguments, reads the total accelerometer Y axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_total_y_data.
  
  body_total_y_data <- rbind(data.table::fread("./train/Inertial_Signals/body_total_y_train.txt"),
                             data.table::fread("./test/Inertial_Signals/body_total_y_test.txt"))
  
  millisecond_labels(body_total_y_data)
}

get_total_acc_z_data <- function() {
  # Function that takes no arguments, reads the total accelerometer Z axis data for
  # both train and test data sets, and returns them as a single data frame labeled
  # body_total_z_data.
  
  body_total_z_data <- rbind(data.table::fread("./train/Inertial_Signals/body_total_z_train.txt"),
                             data.table::fread("./test/Inertial_Signals/body_total_z_test.txt"))
  
  millisecond_labels(body_total_z_data)
}

millisecond_labels <- function(observation_data) {
  # Function that takes a single argument of a data frame that contains the observations
  # collected at the 128 points during the 2.56 second observation period. It
  # labels the columns on the data frame with the millisecond timestamp corresponding
  # to when that observation was taken. It returns the data frame with new labels.
  
  names(observation_data) <- as.character(seq(20, 20*128, by=20))
  
  observation_data
}