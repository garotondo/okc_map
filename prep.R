library(dplyr)
library(readxl)
library(ggplot2)
library(sf)
library(fs)
library(tidyverse)


#Create two folders for organization.
dir.create("raw-data")
dir.create("clean-data")

#Download RDS file
download.file("https://stacks.stanford.edu/file/druid:hp256wp2687/hp256wp2687_ok_oklahoma_city_2019_08_13.rds", destfile = "raw-data/okc.rds")
rds_data <- read_rds("raw-data/okc.rds")


#Download TGZ file
download.file("https://stacks.stanford.edu/file/druid:hp256wp2687/hp256wp2687_ok_oklahoma_city_shapefiles_2019_08_13.tgz", destfile = "raw-data/okc.tgz")
untar("raw-data/okc.tgz", exdir = "raw-data")


#Filter RDS data
new_rds <- rds_data %>% 
  drop_na() %>% 
  filter(division %in% c("Santa Fe", "Springlake"),
         vehicle_registration_state == "OK")

#Create 2 R objects
tgz_data <- read_sf("raw-data/ok_oklahoma_city_shapefiles/City_Boundaries.shp")
locations <- st_as_sf(new_rds, coords = c("lng", "lat"), crs=4326)


#write RDS
write_rds(locations, "/Users/gracerotondo/Desktop/Coding/okc_map/clean-data/locations.rds")
write_rds(tgz_data, "/Users/gracerotondo/Desktop/Coding/okc_map/clean-data/tgz.rds")
write_rds()


#Delete raw data folder
file_delete("raw-data")






