#########################################################
# run_analysis.R
#########################################################
# DESCRIPTION: This script includes 5 main steps as required
#              by the assignment
#              1. Merge the training and the test sets to
#                 create one data set.
#              2. Extracts only the measurements on the mean
#                 and standard deviation for each measurement.
#              3. Uses descriptive activity names to name
#                 the activities in the data set.
#              4. Appropriately labels the data set with 
#                 descriptive variable names.
#              5. From the data set in step 4, creates
#                 a second,independent tidy data set with
#                 the average of each variable for each
#                 activity and each subject.
##############################################################
##############################################################
library(dplyr)
#####################################################
# STEP 0: Loads all the data files 
#####################################################
##Creates the list with the instructions needed by 
##'read.table()'
read.table_instructions <- list(
  #The first object is the list with name 'file' that
  #contains values for 'file' argument, which indicates
  #the path of each file.
  file = list(
    activity_labels = "UCI HAR Dataset/activity_labels.txt",
    features = "UCI HAR Dataset/features.txt",
    subject_train = "UCI HAR Dataset/train/subject_train.txt",
    y_train = "UCI HAR Dataset/train/y_train.txt",
    x_train = "UCI HAR Dataset/train/x_train.txt",
    subject_test = "UCI HAR Dataset/test/subject_test.txt",
    y_test = "UCI HAR Dataset/test/y_test.txt",
    x_test = "UCI HAR Dataset/test/x_test.txt"
  ),
  #The second object is a list with name 'colClasses' that
  #contrains the values for 'nolClasses' argument that
  #indicates the classes of all variables in each file.
  colClasses = list(
    activity_labels = c("integer","character"),
    features = c("integer","character"),
    subject_train = "integer",
    y_train = "integer",
    x_train = rep("numeric",561),
    subject_test = "integer",
    y_test = "integer",
    x_test = rep("numeric",561)
  ),
  #The third object is a list with name 'nrows' that
  #contains the values for 'nrows' argument that indicates
  #the number of rows to read in each file.
  nrows = list(
    activity_labels = 6,
    features =561,
    subject_train = 7352,
    y_train = 7352,
    x_train = 7352,
    subject_test = 2947,
    y_test = 2947,
    x_test = 2947
  )
)
## Uses the instructions created above to load all needed
## data with Map().For each file the correct arguments
## are supplied to function 'read.table()', as well as
## some extra, common arguments for all files. Function
## with() is used for clearer code.
data_files <- with(read.table_instructions,
                   Map(read.table,file = file, 
                       colClasses = colClasses, nrows = nrows,
                       quote = "", comment.char = ""))
######################################################
# STEP 1: Merge the training and test data sets
######################################################
merged_data <- with(data_files,rbind(cbind(subject_train,y_train,
                    x_train),cbind(subject_test,y_test,x_test)))
######################################################
# STEP 2: Extract only the measurements on the mean and
#         standard deviation for each measurement.
######################################################
target_features_indexes <- grep("mean\\(\\)|std\\(\\)",data_files$features[[2]])
##add the first two columns that refer to "subject" and 
##"activity"
target_features_indexes <- c(1,2,target_features_indexes+2)
target_data <- merged_data[,target_features_indexes]
########################################################
# STEP 3: Use decriptive activity names to name the 
# activities in the data set
#######################################################
target_data[,2] <- factor(target_data[,2],levels =
                          data_files$activity_labels[,1],
                          labels = data_files$activity_labels[,2])
#######################################################
# STEP 4: Appropriately labels the data set with descriptive
#         variable names.
######################################################
## Extract the target variables names
target_features_indexes1 <- target_features_indexes[-(1:2)]
target_features_indexes1 <- target_features_indexes1-2
descriptive_variable_names <- data_files$features[target_features_indexes1,2]
descriptive_variable_names <- gsub(pattern = "BodyBody",
                                   replacement = "Body",
                                   descriptive_variable_names)
tidy_data <- target_data
names(tidy_data) <- c("subject","activity",descriptive_variable_names)
######################################################
# STEP 5: From the data set in step 4, create a second,
#         independent tidy data set with the average of
#         each variable for each activity and each subject.
######################################################
tidy_data_summary <- tidy_data %>% group_by(subject,activity) %>% summarise_all(funs(mean)) %>% ungroup()
new_names <- c(names(tidy_data_summary[c(1,2)]),paste0("Avrg-",names(tidy_data_summary[-c(1,2)])))
names(tidy_data_summary) <- new_names
write.table(tidy_data_summary,"tidy_data_summary.txt",row.names=FALSE)
