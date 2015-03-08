# plot2.R



library(plyr)
library(dplyr)
library(lubridate)

# Data Soure: UC IRvine Machine Learning Repository:  “Individual household electric power consumption Data Set”
#             http://archive.ics.uci.edu/ml/

# Load data for February 1-2, 2007 - There are over 2 million rows in the data file which is sorted in date-time
#    ascending order. Using grep I found out that there are only 1440 rows per day and at what line the data
#    starts. Using read.table with skip ignores the existing header - so I will add the column names in the code.

# Read the data in
df = read.table("household_power_consumption.txt", header=TRUE, sep=';', skip=66636, nrow=2880, stringsAsFactors = FALSE)

# Rename the columns
column_names <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity",
                  "sub_meter1", "sub_meter2", "sub_meter3")
names(df) <- column_names

# Concatenate date and time
df <- mutate(df, time_stamp =  dmy_hms(paste(df$date, df$time)))

# Save to a png - open the device
png(filename="Plot2.png", width=480, height=480)

plot(df$time_stamp, df$global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Close the device
dev.off()
