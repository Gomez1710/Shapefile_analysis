library(tigris)
library(dplyr)
library(ggplot2)
library(showtext)
library(stringr)
library(sf)
library(tidygeocoder)
library(ggmap)

#unzip("Primary_Care_Shortage_Areas_(PCSA)-shp.zip")

font_add_google("Montserrat", "Montserrat")


#read in PCSA shortage area
pcsa <- read_sf("cccbc3ad-d29a-48cc-97c4-4c35f5d8fb472020329-1-93tn1l.un4m.shp")

# read in clinic data
#df <- read.csv("fy22-23_data.csv", stringsAsFactors = FALSE)

# get lat and long of every address
#df2 <- df %>% geocode(address = fullAddress, method = "census", verbose =  TRUE)


#df2 <- df %>% geocode(address = fullAddress, method = "arcgis", verbose = TRUE)


#wrtie out csv for df2
#write.csv(df2, "testing.csv", row.names = FALSE)
#rm(df, df2)

df <- read.csv("testing.csv", stringsAsFactors = FALSE)

#rename column 4
#colnames(df)[4] <- "County"

#remove "County"

#df$County <- str_remove_all(df$County, "County")

#remove extra whitespace
#df$County <- str_trim(df$County, side = "both")

#select only wanted columns
#df <- df %>% select(Grant.ID, fullAddress, long, lat)

df_sf <- st_as_sf(df, coords = c("long", "lat"), crs = 4326)

#sf_use_s2(FALSE)

# joining both sf frames
x <- st_join(df_sf, pcsa, join = st_within, left =  FALSE)


st_write(x, "FY2223_PCSA.csv", layer_options = "GEOMETRY=AS_XY")

#build a map
#build a map

#read cali county data
cali <- counties("California", cb = TRUE)

showtext_auto()

#start mapping process
cmap <- ggplot()

#to get rid of axis
ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

cmap +
  geom_sf(data = cali, fill = "white") +
  geom_sf(data = pcsa, aes(fill = as.factor(PCSA))) +
  geom_sf(data = x, color = "firebrick") +
  scale_fill_manual(values = c("white",
                               "#042B46")) +
  labs(fill = "PCSA") +
  theme(legend.title = element_text(size = 22, family = "Montserrat"),
        legend.text = element_text(size = 20, family = "Montserrat")) +
  theme_nothing(legend = TRUE) +
  ditch_the_axes


ggsave("pcsa_points.png", width = 15, height = 12, dpi = 96)
