library(data.table)
fileName <- "household_power_consumption.txt"

downloadData <- function()
{
  download.file("http://archive.ics.uci.edu/ml/","exdata-data-household_power_consumption.zip")
  unzip("exdata-data-household_power_consumption.zip")
}

getData <- function()
{
  if (!file.exists(fileName))
  {
    downloadData()
  }
  testdata <- fread(fileName,sep=";",na.strings = "?")
  testdata$Global_active_power <- as.numeric(testdata$Global_active_power)
  testdata$Date <- as.Date(testdata$Date)
  testdata[testdata$Date == "1/2/2007" | testdata$Date == "2/2/2007"]
}

printplot1 <- function()
{
  testdata <- getData()
  hist(testdata$Global_active_power,col ="red",main = "Global active power", xlab="Global active power (kilowatts)")
  
  dev.copy(png,file='Plot1.png')
  dev.off()
}

printplot1()