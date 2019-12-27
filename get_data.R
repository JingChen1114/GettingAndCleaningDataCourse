##########################################################
#get_data.R
##########################################################
#DESCRIPTION: This script downloads and extracts the "UCI 
#             HAR" in the working directory if the folder
#             doesn't exist
#DOWNLOAD URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##########################################################
message("Check for the existence of the folder 'UCI HAR Dataset'")
if(!dir.exists("UCI HAR Dataset")){
  message("no folder with name 'UCI HAR Dataset exists in the working directory'")
  #Download the data zipped file
  message("Trying to download the zipped file")
  data_url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(data_url,destfile="data.zip")
  message("zipped data was downloaded successfully in the working directory as 'data.zip'")
  #Creates a log file for recording
  log_url <- paste0("Data was downloaded from:",data_url)
  log_date <- paste0("Data was downloaded at date:",date())
  log <- file("log.txt")
  writeLines(c(log_url,log_date),log)
  close(log)
  message("A file was created as 'log.txt' at the working directory \n",
          "which stores the url and the date.")
  #Extracts files from zipped file
  unzip("data.zip")
}else{
  message("'UCI HAR Dataset' are available in the folder.")
}
