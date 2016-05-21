library(dplyr)

# load labels
features <- read.table("features.txt")
activites <- read.table("activity_labels.txt")

#load data
Xt <- read.table("./test/X_test.txt")
Yt <- read.table("./test/y_test.txt")
St <- read.table("./test/subject_test.txt")

Xr <- read.table("./train/X_train.txt")
Yr <- read.table("./train/y_train.txt")
Sr <- read.table("./train/subject_train.txt")

names(Xt) <- features$V2 #apply names to main data columns
names(Xr) <- features$V2 

Main.Data <- rbind(
  tbl_df(data.frame(Yt,St,Xt)),
  tbl_df(data.frame(Yr,Sr,Xr))
) #combine all the datasets in one step

rm(Xr,Xt,Yt,Yr,St,Sr) #clean up
names(Main.Data)[1:2] <- c("Activity","Subject") #name the dimension columns

Main.Data <- Main.Data %>%
  select(c(Activity,Subject, contains("mean"),contains("std"))) %>% #find all variables for means or std dev
  inner_join(activites, by = c("Activity" = "V1" )) %>% #join to labels
  rename(Activity_label = V2) %>%  #rename V2 to what it is
  select(Activity_label,everything()) %>% #move the activity to the first column
  select(-Activity) #Activity_label is a factor anyway so we don't need the number

names(Main.Data) <- sub("\\.\\.","",names(Main.Data)) #thanks to http://stackoverflow.com/questions/16041935/remove-dots-from-the-column-names-in-r

All.Means <- Main.Data %>% #means of every variable
#  select(Activity_label,Subject, contains("mean")) %>% # not sure if mean of means columns or means of every columns is needed
  group_by(Activity_label,Subject) %>%
  summarise_each(funs(mean))
  
