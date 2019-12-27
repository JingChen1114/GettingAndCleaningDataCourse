# GettingAndCleaningDataCourse
***  

## About this repository 
 
This repository was created for the peer-graded assignment of course : Getting and Cleaning Data

## Details on the files that exist in this repository  
 

### README.md 
It is the file you read right now and tries to explain the purpose and
the contents of the repository.
 
### get_data.R 
It is the script that was used to download and unzip the files, needed to
perform the analysis in the first place. 
 
### run_analysis.R 
 
It is the main script of the repository. 
As it is described in 'CodeBook.md':

> In order to produce the 'tidy_data_summary' table,
> It performs the following tasks: 
>  
> #### Merges the training and the test sets to create one data set with target variables. 
>  
> #### Extracts only the measurements on the mean and standard deviation for each measurement. 
> 
> #### Uses descriptive activity names to name the activities in the data set.   
>
> #### Appropriately labels the data set with target variables with descriptive names. 
> 
> #### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    
### tidy_data_summary.txt 
 
The tidy dataset that was produced by the script 'run_analysis.r',
which contains the averages of selected features from the original
'Human Activity Recognition Using Smartphones Dataset Version 1.0'.
 
### CodeBook.md 

The code book contains informations on the 'tidy_data_summary' table.
It consists of the following: 
 
  0. Table of Contents 
  1. Informations on 'tidy_data_summary' data table 
     - Identificators and averages of features 
     - Description for the variables of 'tidy_data_summary' 
     - How to load 'tidy_data_summary' in R
     - About 'tidy_data_summary' table 
  2. The process by which the 'tidy_data_summary' table was produced 
  3. Description of the features on which the averages were based 
     - Informations on how the features were produced from the raw data 
     - Informations on the collection of raw data 
     - About the original data set 
  4. License 
 
