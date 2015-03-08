# plot1.R
# 

# Data Soure: UC IRvine Machine Learning Repository:  “Individual household electric power consumption Data Set”
#             http://archive.ics.uci.edu/ml/

# Load data for February 1-2, 2007 - There are over 2 million rows in the data file which is sorted in date-time
#    ascending order. Using grep I found out that there are only 1440 rows per day and at what line the data
#    starts. Using read.table with skip ignores the existing header - so I will add the column names in the code.

column_names <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity",
        "sub_meter1", "sub_meter2", "sub_meter3")
  
# Read the data in
df = read.table("household_power_consumption.txt", header=T, sep=';', skip=66636, nrow=2880, stringsAsFactors = F)

# Rename the columns
column_names <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity",
                  "sub_meter1", "sub_meter2", "sub_meter3")
names(df) <- column_names

# Save to a png - open the device
png(filename="Plot1.png", width=480, height=480)

# Generate the histogram
hist(df$global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Close the device
dev.off()