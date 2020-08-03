##################################
#  GET THE DATA
##################################
#  go here to get the mapping data:  http://www.diva-gis.org/gdata  
#
#    choose UK as the country, leave 'Administrative areas' as it is, click OK
#    download, and the extract (unzip)
#     on my machine I put them in this folder: 
#      "C:/Users/david.corne/Desktop/Rlib/GBR_adm"
#      "C:/Users/kate-lynnethomson/Desktop/GBR_adm"

######################################
#  READ THE DATA INTO AN R OBJECT
#####################################

# this library brings in 'readOGR', which we need here
install.packages(rgdal)
library(rgdal)

# on my system, doing the above, it tells me it loads 'sp' also -- but if yours doesn't say that,
# it might be a good idea to try 'library(sp)' as well, obviously install.package("sp") if necessary

# so, this below puts the data into uk_shapefile (or, obvs, any variable name of your choice)
# the data is now  what R calls a 'Spatial Vector Object'
# (this particular file, adm2, contains area boundaries - I think adm1 only provides
# nation boundaries)
# obvs, put the correct path to the file for your own machine

uk_shapefile = readOGR("/Users/kate-lynnethomson/Desktop/GBR_adm/GBR_adm2.shp")

scot_shape <- subset(uk_shapefile,NAME_1=="Scotland")

####################################
# EXPLORE THE OBJECT 
####################################

# see the 'names' in the object - this is a bit like 'column headings'

names(scot_shape)


# hmm... we saw NAME_1 and NAME_2 ..  what is NAME_1 all about?

print(scot_shape$NAME_1)
# == "Scotland" tried this to get it specific to Scotland -- just shows true and false

# OK that looks like 192 separate things - probably areas in the map, but with
# NAME_1 being the country name; so, NAME_2 might be interesting:

print(scot_shape$NAME_2)

# great - NAME_2  gives us names at county level: this will be useful later



#################
# So, we have found that uk_shapefile includes a list of 192 area names;
# Now, if we can create an array - let's call it 'datatoplot' -- with 192
# numbers in it, then we will be able to combine it with uk_shapefile
# and plot a heatmap of those numbers
# that's what happens next
#################4  

######################################
# BUILD ARRAY OF VALUES FOR HEATMAP
######################################

# first, we need to make our array a certain length, i.e. same as length of 
# uk_shapefile$NAME_2  which is 192

#len = length(scot_shape$NAME_2) 

#or, if we were certain we had the right number, we could have just done this:
 len = 32

# now, we generate a vector, called 'heatvals' of 192 random numbers between 100 and 1000

heatvals = sample(100:1000,len)

# now we make our 'datatoplot' data frame, which combines the area names (in uk_shapefile$NAME_2)
# with the 'heatvals' data

datatoplot = data.frame(id=scot_shape$ID_2, NAME_2=scot_shape$NAME_2, heatvals)

# have a cheeky look at datatoplot to see what we have
datatoplot

#########################################################
# MERGE THE HEATMAP DATA INTO THE ATUAL MAP/SHAPEFILE DATA
#########################################################

# first thing we need to do, it turns out, is to produce a 'data frame' version of uk_shapefile 
# (recall that it is a 'spatial object' not a df)

# for this we need 'fortify' which is in this library

library(ggplot2)

# now we get the data frame version of uk_shapefile
df_scot_shape  <- fortify(scot_shape)

# now we merge!   
merged_data = merge(df_scot_shape, datatoplot, by="id", all.x=TRUE)

#########################################################
#       PLOT IT !
#########################################################

# this piece of magic prints the heatmap
# note that:   'data = merged_data'  is where we tell it where all the map data is
#              'fill = heatvals'  is where we tell it which part of the data contains the heat values

ggplot() +
  geom_polygon(data = merged_data,
               aes(x = long, y = lat, group = group, fill = heatvals),
               color = "white", size = 0.5) +
  coord_map()

