# data
# https://divvy-tripdata.s3.amazonaws.com/index.html
# 202207-divvy-tripdata to 202307-divvy-tripdata

# load packages
library(tidyverse)
library(hms)

# cleaning ----------------------------------------------------------------

# load and merge data raw data
july_2022 <- read.csv("202207-divvy-tripdata.csv")
august_2022 <- read.csv("202208-divvy-tripdata.csv")
september_2022 <- read.csv("202209-divvy-tripdata.csv")
october_2022 <- read.csv("202210-divvy-tripdata.csv")
november_2022 <- read.csv("202211-divvy-tripdata.csv")
december_2022 <- read.csv("202212-divvy-tripdata.csv")
january_2023 <- read.csv("202301-divvy-tripdata.csv")
february_2023 <- read.csv("202302-divvy-tripdata.csv")
march_2023 <- read.csv("202303-divvy-tripdata.csv")
april_2023 <- read.csv("202304-divvy-tripdata.csv")
may_2023 <- read.csv("202305-divvy-tripdata.csv")
june_2023 <- read.csv("202306-divvy-tripdata.csv")
july_2023 <- read.csv("202307-divvy-tripdata.csv")
combined_data <- rbind(july_2022, august_2022, september_2022, 
                       october_2022, november_2022, december_2022, 
                       january_2023, february_2023, march_2023, april_2023, 
                       may_2023, june_2023, july_2023)

# basic understanding of data
head(combined_data)
str(combined_data)
colnames(combined_data)
glimpse(combined_data)
View(combined_data)

# rename 'member_casual' column 
combined_data <- rename(combined_data, 'user_type' = 'member_casual')
colnames(combined_data)

# format 'started_at' and 'ended_at' columns
combined_data$started_at <- ymd_hms(combined_data$started_at)
combined_data$ended_at <- ymd_hms(combined_data$ended_at)

# add 'day' column
combined_data <- combined_data %>% 
  mutate(day = weekdays(started_at), .before = started_at)

# add 'ride_length' column
combined_data <- combined_data %>% 
  mutate(ride_length = as_hms(difftime(ended_at, started_at)), 
         .after = ended_at)

# export 'combined_data' as a csv for future use
# (don't forget to add file title at the end of path)
# write_csv(combined_data, "/ENTER FILE PATH HERE/combined_data.csv")

# analysis ---------------------------------------------------------------------

# load cleaned data if necessary
# combined_data <- read.csv("combined_data.csv)

# business question: how do members and casuals differ in their usage of the bikes?


