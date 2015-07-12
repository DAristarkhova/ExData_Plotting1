fileName <- "household_power_consumption.txt"

downloadData <- function()
{
  download.file("http://archive.ics.uci.edu/ml/","exdata-data-household_power_consumption.zip")
  unzip("exdata-data-household_power_consumption.zip")
}


correctData <- function(Date,Time)
{
  strDateTime <-paste(Date,Time,sep=" ")
  strptime(strDateTime,"%d/%m/%Y %H:%M:%S")
}

getData <- function()
{
  if (!file.exists(fileName))
  {
    downloadData()
  }
  
  testdata <- read.csv(fileName,sep=";",na.strings = "?")
  testdata$Global_active_power <- as.numeric(testdata$Global_active_power)
  testdata <- subset(testdata,Date=="1/2/2007" | Date == "2/2/2007")
  testdata$Date <- correctData(testdata$Date,testdata$Time)
  testdata
}

printplot2 <- function()
{
  testdata <- getData()
  plot(testdata$Date,testdata$Global_active_power,ylab="Global active power (kilowatts)",xlab="")
}

printplot2()
