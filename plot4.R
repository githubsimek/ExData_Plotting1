# plot4.R
# Plot 4 charts

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
png(filename="Plot4.png", width=480, height=480)

# Plot 4 chart

par(mfrow=c(2,2))

# plot 1
plot(df$time_stamp, df$global_active_power, xlab="",  ylab="Global Active Power (kilowatts)", type="l")

#plot 2
plot(df$time_stamp, df$voltage, xlab="",  ylab="Voltage", type="l")

# plot 3

plot(df$time_stamp, df$sub_meter1, type="l", xlab="", ylab="Energy sub metering")
axis(side=2, at=seq(10,30, by=10))
par(new=TRUE)
plot(df$time_stamp, df$sub_meter2, type="l", col="red", axes=FALSE, ylim=c(1,30), xlab="", ylab="")
par(new=TRUE)
plot(df$time_stamp, df$sub_meter3, type="l", col="blue", axes=FALSE, ylim=c(1,30), xlab="", ylab="")

# Add legend

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), fill=0, bty="n",
       lty=c(1,1,1), # gives the legend lines
       lwd=c(2.5,2.5,2.5), col=c("black", "red", "blue") )  # gives the color

# plot 4

plot(df$time_stamp, df$global_reactive_power, xlab="datetime",  ylab="Global_reactive_power", type="l")




# Close the device
dev.off()
