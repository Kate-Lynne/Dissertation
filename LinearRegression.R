#Linear regression for PatientsxHealthboard
library(readxl)
HealthBoardandPatients <- read_excel("/Users/kate-lynnethomson/Desktop/HealthBoardNo.xlsx", sheet = "Sheet2") #Upload the data
lmHB = lm(HB~Patients, data = HealthBoardandPatients) #Create the linear regression
summary(lmHB) #Review the results

#Linear regression for PatientsxSIMD
library(readxl)
SimdandPatients <- read_excel("/Users/kate-lynnethomson/Desktop/HealthBoardNo.xlsx", sheet = "Sheet3") #Upload the data
lmSIMD = lm(SIMD~Patients, data = SimdandPatients) #Create the linear regression
summary(lmSIMD) #Review the results