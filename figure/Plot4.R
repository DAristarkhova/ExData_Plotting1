fileName <- "household_power_consumption.txt"

downloadData <- function()
{
  download.file("http://archive.ics.uci.edu/ml/","exdata-data-household_power_consumption.zip")
  unzip("exdata-data-household_power_consumption.zip")
}


correctDate <- function(Date,Time)
{
  strDateTime <-paste(Date,Time,sep=" ")
  strptime(strDateTime,"%d/%m/%Y %H:%M:%S")
}

is.between <- function(x,minValue,maxValue)
{
  x>=minValue&x<=maxValue
}

getData <- function()
{
  if (!file.exists(fileName))
  {
    downloadData()
  }
  
  testdata <- read.csv(fileName,sep=";",na.strings = "?")
  testdata$Global_active_power <- as.numeric(testdata$Global_active_power)
  testdata$Date <- correctDate(testdata$Date,testdata$Time)
  
  startDate = correctDate("1/2/2007","00:00:00")
  endDate = correctDate("2/2/2007","23:59:59")
  testdata <- subset(testdata, is.between(Date,startDate,endDate))
  
  testdata
}

printplot4 <- function()
{
  testdata <- getData()
  
  par(mfrow=c(2,2))
  par(mar=c(4,4,2,2))
  
  ## Plot 1
  plot(testdata$Date,testdata$Global_active_power,ylab="Global active power (kilowatts)",xlab="",type = "l")
  
  ## Plot 2
  plot(testdata$Date,testdata$Voltage,ylab="Voltage",xlab="datetime",type = "l")
  
  ## Plot 3
  with(testdata, plot(Date,Sub_metering_1,type="l",ylab = "Energy sub metering",xlab = ""))
  with(testdata, lines(Date,Sub_metering_2,type="l",col="red"))
  with(testdata, lines(Date,Sub_metering_3,type="l",col="blue"))
  legend("topright",lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ## Plot 4
  plot(testdata$Date,testdata$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type = "l")
  
  dev.copy(png,file='Plot4.png')
  dev.off()
}

printplot4()
