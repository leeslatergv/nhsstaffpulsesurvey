library(janitor)

# Import the three data sets, delete the empty rows, and add a date variable
Q4_202122_data <- read_excel("202122Q4.xlsm", sheet = 3)
Q4_202122_data <- tail(Q4_202122_data, -2)
Q4_202122_data <- Q4_202122_data %>% 
  mutate(time = "202122Q4")

Q1_202223_data <- read_excel("202223Q1.xlsm", sheet = 3)
Q1_202223_data <- tail(Q1_202223_data, -2)
Q1_202223_data <- Q1_202223_data %>% 
  mutate(time = "202223Q1")

Q2_202223_data <- read_excel("202223Q2.xlsm", sheet = 3)
Q2_202223_data <- tail(Q2_202223_data, -2)
Q2_202223_data_1 <- Q2_202223_data %>% 
  mutate(time = "202223Q2")

# Merge the data with an outer join (i.e. retains all observations regardless of if they are in other time periods)
merged_data <- merge(x = Q4_202122_data, y = Q1_202223_data, all = TRUE)
pulse_ts_data <- merge(x = merged_data, y = Q2_202223_data, all = TRUE)

count(Q1_202223_data) + count(Q4_202122_data) + count(Q2_202223_data) # Verifies we've successfully merged all rows

# Remove other data we no longer need
rm(list=setdiff(ls(), "pulse_ts_data"))

# Clean names
pulse_ts_data <- pulse_ts_data %>% 
  clean_names()

## Problem - four missing times - revisit

# Write to csv
write.csv(pulse_ts_data, "pulse_ts_data.csv")
