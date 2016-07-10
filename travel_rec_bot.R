library(twitteR)
library(streamR)
library(ggplot2)
library(ggmap)
library(rvest)
library(stringr)
#reads city dataset
topcities <- read.csv("100 Top Cities.csv")
#picks a random city
location <- sample(topcities[,1], 1, replace = FALSE)
location <- as.character(location) #city name
locationkey <- gsub(" ", "_", location)

triplink <- paste("https://www.tripadvisor.com/", locationkey, sep = "")

#webscrapng from Tripadvisor
trips <- read_html(triplink)
#top 3 places to visit within a given location
visit1 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(5) > div > div > div > div.col.attractions > ul > li:nth-child(1) > div.loc > div.name > a") %>% html_text()
if (length(visit1) == 0) {
  visit1 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(3) > div > div > div > div.col.attractions > ul > li:nth-child(1) > div.loc > div.name > a") %>% html_text()
}
visit2 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(5) > div > div > div > div.col.attractions > ul > li:nth-child(2) > div.loc > div.name > a") %>% html_text()
if (length(visit2) == 0) {
  visit2 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(3) > div > div > div > div.col.attractions > ul > li:nth-child(2) > div.loc > div.name > a") %>% html_text()
}
visit3 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(5) > div > div > div > div.col.attractions > ul > li:nth-child(3) > div.loc > div.name > a") %>% html_text()
if (length(visit3) == 0) {
  visit3 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(3) > div > div > div > div.col.attractions > ul > li:nth-child(3) > div.loc > div.name > a") %>% html_text()
}
#Recommendation for romantic stay
stayrom <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(1) > div > a.hotel.name") %>% html_text()
stayrom <- gsub("\n", "", stayrom)
#Recommendation for family
stayfam <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(2) > div > a.hotel.name") %>% html_text()
stayfam <- gsub("\n", "", stayfam)
#Recommendation for vacation
stayvac <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(3) > div > a.hotel.name") %>% html_text()
stayvac <- gsub("\n", "", stayvac)
#Recommendation for best value
staybest <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(4) > div > a.hotel.name") %>% html_text()
staybest <- gsub("\n", "", staybest)  

visitlink1 <- as.character(visit1)
visitlink1 <- gsub(" ", "", visitlink1)
visitlink2 <- as.character(visit2)
visitlink2 <- gsub(" ", "", visitlink2)
visitlink3 <- as.character(visit3)
visitlink3 <-gsub(" ", "", visitlink3)

imagelink1 <- paste("https://www.flickr.com/photos/tags/", visitlink1, sep = "")
imagelink2 <- paste("https://www.flickr.com/photos/tags/", visitlink2, sep = "")
imagelink3 <- paste("https://www.flickr.com/photos/tags/", visitlink3, sep = "")

html1 <- imagelink1
flickr1 <- read_html(html1)
linkend1 <- flickr1 %>% html_nodes(css = "div.photo-list-photo-interaction > a") %>% .[[2]] %>% html_attr("href") ##getting the href from the first link
newlink1 <- str_c("http://flickr.com", linkend1, collapse ="")
photohtml1 <- read_html(newlink1)
imagelink1 <- photohtml1 %>% html_nodes("img")  %>% .[[2]] %>% html_attr("src")
imagelink1 <- str_c("http:", imagelink1, collapse="")
download.file(imagelink1, "1.jpg", mode = "wb")

html2 <- imagelink2
flickr2 <- read_html(html2)
linkend2 <- flickr2 %>% html_nodes(css = "div.photo-list-photo-interaction > a") %>% .[[2]] %>% html_attr("href") ##getting the href from the first link
newlink2 <- str_c("http://flickr.com", linkend2, collapse ="")
photohtml2 <- read_html(newlink2)
imagelink2 <- photohtml2 %>% html_nodes("img")  %>% .[[2]] %>% html_attr("src")
imagelink2 <- str_c("http:", imagelink2, collapse="")
download.file(imagelink2, "2.jpg", mode = "wb")

html3 <- imagelink3
flickr3 <- read_html(html3)
linkend3 <- flickr3 %>% html_nodes(css = "div.photo-list-photo-interaction > a") %>% .[[2]] %>% html_attr("href") ##getting the href from the first link
newlink3 <- str_c("http://flickr.com", linkend3, collapse ="")
photohtml3 <- read_html(newlink3)
imagelink3 <- photohtml3 %>% html_nodes("img")  %>% .[[2]] %>% html_attr("src")
imagelink3 <- str_c("http:", imagelink3, collapse="")
download.file(imagelink3, "3.jpg", mode = "wb")

#Twitterbot- authentiation
consumer_key = "x3XSvMHzMHt2qG9ZJwoHcGlwZ"
consumer_secret = "jqkG3oayg2zjddHB24Xw0NsRxfWzgM1ItbXyCmBEzFLACtUhQW"
access_token = "751084486008406016-iSjfil2rUFm24LleCIyqGEDbshMptUk"
access_secret = "ZwLn1Xsashsa0s1pkf33E9BYxVErYwgKjM6s0eYCG3HKV"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#3 versions of recommendation of places to visit
visitrec1 <- paste("Traveling to ", location, "? We recommend ", visit1, ", ", 
                   visit2, ", and ", visit3, "!", sep = "")
visitrec2 <- paste("If you are in ", location, ", you HAVE to visit ", visit1, 
                   ", ", visit2, ", and ", visit3, "!", sep = "")
visitrec3 <- paste("Our top 3 must-see sites in ", location, " are ", visit1, 
                   ", ", visit2, ", and ", visit3, "!", sep = "")

#randomly picksone from above
visittweet <- sample(c(visitrec1, visitrec2, visitrec3), 1, replace = FALSE)

#tweet for each hotel recommendation
romanticRec <- paste("Planning a trip to ", location, " with your significant other? Check out \'", stayrom, "\'!", sep = "")

famRec <- paste("Here's our pick of hotel for your family trip to ", location, ". Book your room at \'", 
                stayfam, "\' now.", sep = "")

vacRec <- paste("Looking for a hotel in ", location, "? Take a look at \'", 
                stayvac, "\' and avoid the hassle!", sep = "")

bestRec <- paste("We recommend that you stay at \'", staybest, "\' if you are going to ", location, "!", sep ="")

#picks one of the 4 tweets for hotel 
hoteltweet <- sample(c(romanticRec, famRec, vacRec, bestRec), 1, replace = FALSE)

#create a world map, with the destination marked on it
latitude <- geocode(location)$lat
longtitude <- geocode(location)$lon
ggplot() + borders(database = "world") + 
  geom_point(mapping = aes(x = longtitude, y = latitude), color = "blue")
ggsave("map.png")

#tweet recommendations for places to visit and stay
tweet(text = visittweet, mediaPath = "/Users/jaeyoon/Desktop/Data Science/project2/HotelBot/map.png", bypassCharLimit = TRUE)
tweet(text = visit1, mediaPath = "/Users/jaeyoon/Desktop/Data Science/project2/HotelBot/1.jpg", bypassCharLimit = TRUE)
tweet(text = visit2, mediaPath = "/Users/jaeyoon/Desktop/Data Science/project2/HotelBot/2.jpg", bypassCharLimit = TRUE)
tweet(text = visit3, mediaPath = "/Users/jaeyoon/Desktop/Data Science/project2/HotelBot/3.jpg", bypassCharLimit = TRUE)
tweet(hoteltweet)

file.remove(c("map.png", "1.jpg", "2.jpg", "3.jpg"))