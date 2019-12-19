library(dplyr)
library(readxl)
library(ggplot2)
library(gganimate)
library(sf)
library(fs)
library(shiny)
library(tidyverse)


#Read in the rds files with the locations and tgz data. Created a ggplot and
#used geom_sf to create a map to map both the tgz data and locations data. I
#wanted subject race to be the variable mapped, ans so I set the color to that.
#I used transition_manual to animate the map and labs to create all the labels.
#I then used animate to animate the map.
location_data <- read_rds("clean-data/locations.rds")

tgz_data <- read_rds("clean-data/tgz.rds")

okc_map <- ggplot() +
  geom_sf(data = tgz_data) +
  geom_sf(data = location_data, aes(color = subject_race), alpha = 0.5) +
  transition_manual(subject_race) +
  labs(title = "OK City Map of Citations",
       subtitle = "Citation Locations Among Race",
       xlab = "Latitude",
       ylab = "Longitude",
       color = "Subject Race")


#Copy map for safety
file_copy(path = "/Users/gracerotondo/Desktop/Coding/okc_map/graphics/map.rds", 
          new_path = "/Users/gracerotondo/Desktop/Coding/okc_map/okc_shiny/map.rds", 
          overwrite = FALSE)

okc_map

animate_map <- animate(okc_map)

#Created a new directory called graphics
dir.create("graphics")
write_rds(okc_map, path = "/Users/gracerotondo/Desktop/Coding/okc_map/graphics/map.rds")