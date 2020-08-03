library(openxlsx)
Histogram <- read.xlsx("/Users/kate-lynnethomson/Desktop/Histograms.xlsx" )

library(ggplot2)

# reminding myself of the names of the columns     
colnames(Histograms)


hist(Histogram$Patients, col="yellow")


Histogram <- Patients[,1];
hist(Histogram,main = "Patients")






