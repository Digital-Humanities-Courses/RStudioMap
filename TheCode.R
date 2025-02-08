# Set working directory
setwd("C:/Users/admin/Desktop/MAP")

install.packages(c("leaflet", "leaflet.extras", "htmlwidgets"))


library(leaflet)
library(leaflet.extras)
library(htmlwidgets)


locations <- data.frame(
  name = c(
    "London", "Verona", "Elsinore", "Athens", "Caius", 
    "York", "Newcastle", "Stratford-upon-Avon", "Venice", 
    "Padua", "Rome", "Paris", "Vienna", "Mantua", 
    "Syracuse", "Ephesus", "Messina", "Naples", "Milan"
  ),
  latitude = c(
    51.5074, 45.4375, 55.6700, 37.9838, 51.5074, 
    53.959, 54.9783, 52.1915, 45.4408, 
    45.4064, 41.9028, 48.8566, 48.2082, 45.1564, 
    37.0629, 37.9496, 38.1925, 40.8518, 45.4642
  ),
  longitude = c(
    -0.1278, 10.9916, 12.5842, 23.7275, -0.1278, 
    -1.0815, -1.6174, -1.7070, 12.3155, 
    11.8768, 12.4964, 2.3522, 16.3738, 10.7901, 
    15.2902, 27.3643, 15.5564, 14.2681, 9.1895
  ),
  play = c(
    "Henry IV", "Romeo and Juliet", "Hamlet", "A Midsummer Night's Dream", "Julius Caesar", 
    "Richard III", "Henry IV", "Shakespeare's birthplace", "The Merchant of Venice", 
    "The Taming of the Shrew", "Julius Caesar", "All's Well That Ends Well", "Measure for Measure", "Romeo and Juliet", 
    "The Comedy of Errors", "The Comedy of Errors", "Much Ado About Nothing", "The Tempest", "The Two Gentlemen of Verona"
  )
)

pastel_colors <- c(
  "#FADADD", "#FFB6C1", "#FFD1DC", "#FFABAB", "#FFE4E1", 
  "#FAE1DD", "#D5AAFF", "#BFA2DB", "#AFCBFF", "#BDE0FE", 
  "#CAFFBF", "#FDFFB6", "#FFB5A7", "#FFD6A5", "#FFE7A9", 
  "#C2C2F0", "#D4A5A5", "#FFDAC1", "#B5EAD7"
)

locations$color <- pastel_colors[1:nrow(locations)]

map <- leaflet(locations) %>%
  addProviderTiles("CartoDB.Voyager") %>%
  addCircleMarkers(
    ~longitude, ~latitude, 
    color = ~color,
    fillColor = ~color,
    fillOpacity = 0.7,
    radius = 8,
    popup = ~paste0("<b>City:</b> ", name, "<br><b>Play:</b> ", play),
    label = ~name
  ) %>%
  addMiniMap(toggleDisplay = TRUE) %>%
  addLegend(
    "bottomright", 
    colors = pastel_colors[1:nrow(locations)], 
    labels = locations$name,
    title = "Shakespeare's Cities",
    opacity = 0.7
  )


map <- addScaleBar(map, position = "bottomleft")

saveWidget(map, "Shakespeare_Map.html", selfcontained = TRUE)

map

