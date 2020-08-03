library(plotly)
library(rjson)

data <- fromJSON(file="https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json")

data$features[[1]]

df = read.csv("https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv", header = T, colClasses = c("fips"="character"))
head(df)

