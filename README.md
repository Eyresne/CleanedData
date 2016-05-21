## Purpose
This is to clean data as per the final assignment in Getting and Cleaning Data on Coursera.  There is only one script included that processes data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip , loads it into R, and organizes it into two output datasets.

Background information can be found in the original source at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Assumptions
The script assumes you have downloaded and unzipped the data. It assumes your working directory is the folder "UCI HAR Dataset" as in the zip download.
The script assumes you have the R packacge dplyr.

## Process

1. Read the labels for the data variables and activity dimension
2. Load the data
3. Apply the data column names
4. Combine the two dimension files with the data for each dataset, then combine the two sets
5. Join the activity labels with the dataset and then drop the numeric code. Note that it is automatically made into a factor.
6. Get the mean for each data column for each combination of activity and subject ID.


## Output
The script creates two datasets in your R workspace:

### Main.Data 
	This dataset:
	* contains means and standard deviation variables from the original dataset
	* contains the activity label dimnesion from the original dataset in the first column as an R "factor," which means R displays a character sting but uses an integer label internally 
	* contains the subject number dimension as an integer

### All.Means
	This dataset:
	* Contains the average of each mean and each standard deviation
	* Is borken down by subject number and activity label