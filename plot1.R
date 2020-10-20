#THIS IS THE PROGRAMM FOR THE PLOT1 GRAPHIC

#Call the libraries
library(data.table)
library(lubridate)

#save the main file name
file="household_power_consumption.txt"

#read the mainfilename, using the corresponidng characteristics
hpc=read.table(file=file, sep= ";", na.strings = "?",skip = 0, header = TRUE)

names(hpc)
head(hpc)

#transform date and time
hpc$Date=as.Date(dmy(hpc$Date))
hpc$Time=hms(hpc$Time)

#subset the data you want, in this case is by the date
subseted<-subset(hpc, grepl("2007-02-01|2007-02-02", hpc$Date))
head(subseted)
dim(subseted)

#create the plot
hist(subseted$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active power(kilowatts)")

#copy to create the png file
dev.copy(png, "plot1.png", width=480,height=480)
#close and save the plot
dev.off()
