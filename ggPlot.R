#Data Cleaning - NHSDataKL
library(tidyverse)
library(openxlsx)
library(plotly)
library(zoo)
install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)
install.packages("ggExtra", dependencies = TRUE)
library(ggExtra)


#Check existence of file in R
file.exists("/Users/kate-lynnethomson/Desktop/NHSDataKL")

#Load the data - demographic use of health service across Scotland 
NHSDataKL <-read_excel(Users/kate-lynnethomson/Desktop/NHSDataKL)

#1) Assign better column names
names(NHSDataKL)[2]<-"HealthBoard"

#2) Convert Data field to correct datatype
# Data already correct due to the NHS data being prechecked
#Checking for outliers

#ggplot(NHSDataKL, aes(x=HBName, y=AdmissionType)) + geom_point()
ggplot(NHSDataKL, aes(x=HBName, y=Stays)) + geom_point()

#Sebset() function to only take years 2016-2019

#NHSDataKL<-subset(NHSDataKL, Quarter>=2016)
#NHSDataKL





