## Generate histogram of "Global Active Power" and store in plot1.png file 
plot1 <- function(){
    ## Read data from downloaded "Electric powe consumption" file
    data <- read.table(file = "household_power_consumption.txt", header = T, sep = ";",na.strings="?", check.names = T);
    ## Subset for 2007-02-01 and 2007-02-02 days
    selected_data <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]
    ## Add extra column "datetime" to dataframe which adds "Date" and "Time" columns
    selected_data <- within(selected_data, { datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S") })
    
    ## Open png device with required size and
    png(file="plot1.png",width=480,height=480)
    ## Create plotting window for single graph
    op <- par(mfrow=c(1,1)) 

    ## Draw histogram and set appropriate label and color
    hist(selected_data$Global_active_power,xlab="Global Active Power (killowatts)",col = "red",main="Global Active Power")

    ## Finally close the device 
    dev.off()
    ## Reset plotting panel back to original value
    par(op)
}