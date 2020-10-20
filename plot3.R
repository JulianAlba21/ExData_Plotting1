#THIS IS THE PROGRAMM FOR THE PLOT3 GRAPHIC

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

#subset the data you want, in this case is by the date
subseted<-subset(hpc, grepl("2007-02-01|2007-02-02", hpc$Date))
head(subseted)
dim(subseted)

#Created the vector with date and time combined
subseted$Date<-as.character(subseted$Date)
dateTime<-paste(subseted$Date,subseted$Time)
head(ydm_hms(dateTime))

#deleate separate vectors of Date and Time
arrenged<-subseted[,3:9]
#join the data with the vector of date and time combined
arrenged<-cbind(dateTime,arrenged)
head(arrenged)

#change the data and time column format
arrenged$dateTime<-ymd_hms(arrenged$dateTime)
head(arrenged)
#create the plot
with(arrenged, {plot(dateTime,Sub_metering_1, type = "l",xlab = "",ylab = "Energy sub metering")
                lines(dateTime,Sub_metering_2,col="red")
                lines(dateTime,Sub_metering_3,col="blue")
                legend("topright",col = c("black","red","blue"),lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))})

#copy to create the png file
dev.copy(png, "plot3.png", width=480,height=480, units="px")
#close and save the plot
dev.off()
