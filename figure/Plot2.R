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

printplot2 <- function()
{
  testdata <- getData()
  plot(testdata$Date,testdata$Global_active_power,ylab="Global active power (kilowatts)",xlab="",type = "l")
  dev.copy(png,file='Plot2.png')
  dev.off()
}

printplot2()
