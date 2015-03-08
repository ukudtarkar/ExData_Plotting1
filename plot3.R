## Generate plot of days vs three Energy submetering values and store in plot3.png file 
plot3 <- function(){
    ## Read data from downloaded "Electric powe consumption" file
    data <- read.table(file = "household_power_consumption.txt", header = T, sep = ";",na.strings="?", check.names = T);
    ## Subset for 2007-02-01 and 2007-02-02 days
    selected_data <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
    ## Add extra column "datetime" to dataframe which adds "Date" and "Time" columns
    selected_data <- within(selected_data, { datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S") })
    
    ## Open png device with required size and
    png(file="plot3.png",width=480,height=480)
    ## Create plotting window for single graph
    op <- par(mfrow=c(1,1)) 
    
    ## Plot days vs three line plots with energy metering values 
    plot(selected_data$datetime,selected_data$Sub_metering_1, type = "n",xlab = NA, ylab = "Energy sub metering",main = NA)
    with(selected_data, points(datetime,Sub_metering_1,col = "black",type="l"))
    with(selected_data, points(datetime,Sub_metering_2,col = "red",type="l"))
    with(selected_data, points(datetime,Sub_metering_3,col = "blue",type="l"))
    ## Set legend with appropriate title and line color
    legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"),lty=c(1,1,1))    
    
    ## Finally close the device 
    dev.off()
    ## Reset plotting panel back to original value
    par(op)
}
