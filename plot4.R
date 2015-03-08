plot4 <- function(){
    ## Read data from downloaded "Electric powe consumption" file
    data <- read.table(file = "household_power_consumption.txt", header = T, sep = ";",na.strings="?", check.names = T);
    ## Subset for 2007-02-01 and 2007-02-02 days
    selected_data <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
    ## Add extra column "datetime" to dataframe which adds "Date" and "Time" columns
    selected_data <- within(selected_data, { datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S") })
        
    ## Open png device with required size and
    png(file="plot4.png",width=480,height=480)
    ## Create plotting window for four graphs
    op <- par(mfrow=c(2,2)) 
    
    plot(selected_data$datetime,selected_data$Global_active_power, type = "l",xlab = NA,ylab="Global Active Power",main = NA)
    plot(selected_data$datetime,selected_data$Voltage, type = "l",xlab = "datetime",ylab="Voltage",main = NA)
    
    plot(selected_data$datetime,selected_data$Sub_metering_1, type = "n",xlab = NA, ylab = "Energy sub metering",main = NA)
    with(selected_data, points(datetime,Sub_metering_1,col = "black",type="l"))
    with(selected_data, points(datetime,Sub_metering_2,col = "red",type="l"))
    with(selected_data, points(datetime,Sub_metering_3,col = "blue",type="l"))
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty=c(1,1,1),bty="n")
    
    plot(selected_data$datetime,selected_data$Global_reactive_power, type = "l",xlab = "datetime",ylab="Global_reactive_power",main = NA)

    ## Finally close the device 
    dev.off()
    ## Reset plotting panel back to original value
    par(op)
}
