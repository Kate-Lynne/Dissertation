##################################
#  GET THE DATA
##################################
#  go here to get the mapping data:  http://www.diva-gis.org/gdata  
#
#    choose UK as the country, leave 'Administrative areas' as it is, click OK
#    download, and the extract (unzip)
#     on my machine I put them in this folder:
#     "/Users/kate-lynnethomson/Desktop/GBR_adm"

######################################
#  READ THE DATA INTO AN R OBJECT
#####################################

# this library brings in 'readOGR', which we need here

library(rgdal)

# so, this below puts the data into uk_shapefile 
# the data is now  what R calls a 'Spatial Vector Object'
# (this particular file, adm2, contains area boundaries - I think adm1 only provides
# nation boundaries)


library(rgdal)

uk_shapefile <- readOGR("/Users/kate-lynnethomson/Desktop/GBR_adm/GBR_adm2.shp")

##################################
# GET SCOTLAND
##################################

scot_shape <- subset(uk_shapefile,NAME_1=="Scotland")


#################################
# EXPLORE IT A BIT
#################################

names(scot_shape)
print(scot_shape$NAME_2)

# NAME_2  gives us 32 names at county level

#################
# So, we have found that scot_shape has a list of 32 area names in $NAME_2;
# Now, if we create an array -  'linkdata' -- which associates
# those  32 names with 32 heatmap values, we can be used 
# to stitch those heatmap values into the shapefile in the right places 
# All of that happens next
#################4  

######################################
# BUILD THE LINKING DATA
######################################

# first, we need to make our array a certain length:
# scot_shape$NAME_2  which is 32
# were certain we had the right numbers:
len = 32

# now, we generate a vector, called 'heatvals' of 32 random numbers either 0 or 1
# These are our initial heatmap values - we can change them later with ease


heatvals <- read_xlsx("/Users/kate-lynnethomson/Desktop/PatientValues2.xlsx")


######## regenerate linkdata  and mergedata as before

# now we make our 'linkdata' data frame, which links the NAME_2 values (in scot_shape$NAME_2)
# with the 'heatvals' numbers.  

linkdata <- data.frame(id=scot_shape$NAME_2, heatvals)

# shows that it links the area names directly to heatval values
linkdata

#########################################################
# MERGE THE HEATMAP DATA INTO THE ACTUAL MAP/SHAPEFILE DATA
#########################################################

# produce a 'data frame' version of scot_shapefile
# (recall that it is a 'spatial object' not a df)

# we need 'fortify' which is in this library

library(ggplot2)

# now we get the data frame version of scot_shapefile
# note that we say 'region = "NAME_2"', because this is the name that 
# we use above to split the data into regions

df_scot_shape <- fortify(scot_shape,region="NAME_2")

# now we merge!  This line produces 'merged_data' which is a big data 
# from that contains the scot_shape spatial data directly lined to the heatmap values
# via linkdata

merged_data <- merge(df_scot_shape, linkdata, by="id", all.x=TRUE)


#########################################################
#       PLOT IT !
#########################################################

# this piece of magic prints the heatmap
# note that:   'data = merged_data'  is where we tell it where all the map data is
#              'fill = heatvals'  is where we tell it which part of the data contains the heat values

# ggplot() +
#   geom_polygon(data = merged_data,
#                aes(x = long, y = lat, group = group, fill = heatvals),
#                color = "black", size = 0.5) +
#   coord_map()

# you will see that the plot is randomly two-tone . At the moment it is based
# on the random 0/1 values that are currently in heatvals

#########################################################
#       ADD YOUR OWN VALUES TO HEATMAP
#########################################################

# let's look at the NAME_2 list again:

print(scot_shape$NAME_2)

# you can see, for example, that "Scottish Borders" is number 26

# so, let's  set heatvals[26] to 100 (Some of these have been played around with and changed)
# this should make borders a light colour, while everything else (still with vals 0 or 1) is dark

#heatvals[23] = 50

# we need to regenerate some things which depended on heatvals

#linkdata <- data.frame(id=scot_shape$NAME_2, heatvals)
#merged_data = merge(df_scot_shape, linkdata, by="CountofHBName", all.x=TRUE)

# finally we can try the plot again


#ggplot() +
#  geom_polygon(data = merged_data,
   #            aes(x = long, y = lat, group = group, fill = heatvals),
   #            color = "black", size = 0.5) +
 # coord_map()



####### and here is the plotting line which gives prettier colours including the heat vals
ggplot() +
  geom_polygon(data = merged_data,
             aes(x = long, y = lat, group = group, fill = heatvals),
             color = "black")+
  scale_fill_viridis_c(option = "c", direction = -1)+
  theme_classic()
#--------------------------------
  
  