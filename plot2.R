
# 1 # required packages
library(data.table) 
library(dplyr)

# 2 # download and unzip dataset (un-comment if needed)
zipurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipurl, "power.zip", method="auto")
unzip("power.zip", exdir="powerdata")

# 3 # create required dataframe (using data.table)
file <- "powerdata/household_power_consumption.txt" # note folder name as "powerdata"
power <- read.table(file, header=TRUE, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y") # converts to date

# 4 # sub-set data and clean variables
psub <- power[power$Date>="2007-02-01" & power$Date<="2007-02-02", ] # dataframe subset
psub$dt <- paste(psub$Date, psub$Time) %>% strptime(., format="%F %H:%M:%S")
psub$gap <- as.numeric(as.character(psub$Global_active_power))

for (i in c(5, 7, 8, 9)) {
  psub[, i] <- as.numeric(as.character(psub[, i])) # by column index
}

# 5 # plot2
png(file="plot2.png", width=480, height=480)
plot(psub$dt, psub$gap, type="l", ann=F)
     title(ylab="Global Active Power (kilowatts)")
dev.off()
