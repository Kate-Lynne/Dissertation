#Install Packages
install.packages("Hmisc")

#Import Data
corr <- read.csv("/Users/kate-lynnethomson/Desktop/corr.csv")

#Load Data
data("corr")
corr <- corr[, c(1,2)]

#Print first 14 rows
head(corr, 14)


#Correlation Matrix
cor(corr, use = "complete.obs")

library("Hmisc")
#Correlation Matrix with Significance levels (p-value)
#rcorr(x, type = c("Patients", "Deprivation"))

res2 <- rcorr(as.matrix(corr))
res2


#Draw a Correlogram

install.packages("corrplot")

library(corrplot)
#corrplot(res, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)


#Scatterplots

install.packages("PerformanceAnalytics")

library(PerformanceAnalytics)
corr <- corr[, c(1,2)]
chart.Correlation(corr, histogram = TRUE, pch=19)


