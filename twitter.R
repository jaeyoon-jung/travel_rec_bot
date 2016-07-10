library(twitteR)
library(streamR)
library(ggplot2)


consumer_key = "x3XSvMHzMHt2qG9ZJwoHcGlwZ"
consumer_secret = "jqkG3oayg2zjddHB24Xw0NsRxfWzgM1ItbXyCmBEzFLACtUhQW"
access_token = "751084486008406016-iSjfil2rUFm24LleCIyqGEDbshMptUk"
access_secret = "ZwLn1Xsashsa0s1pkf33E9BYxVErYwgKjM6s0eYCG3HKV"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

visitrec1 <- paste("Traveling to ", location, "? We recommend ", visit1, ", ", 
                   visit2, ", and ", visit3, "!", sep = "")
visitrec2 <- paste("If you are in ", location, ", you HAVE to visit ", visit1, 
                   ", ", visit2, ", and ", visit3, "!", sep = "")
visitrec3 <- paste("Our top 3 must-see sites in ", location, " are ", visit1, 
                   ", ", visit2, ", and ", visit3, "!", sep = "")

visittweet <- sample(c(visitrec1, visitrec2, visitrec3), 1, replace = FALSE)



romanticRec <- paste("Planning a trip to ", location, " with your significant other? Check out \'", stayrom, "\'!", sep = "")

famRec <- paste("Here's our pick of hotel for your family trip to ", location, ". Book your room at \'", 
                stayfam, "\' now.", sep = "")

vacRec <- paste("Off to ", location, " for your vacation? Take a look at \'", 
                stayvac, "\' and avoid the hassle!", sep = "")

bestRec <- paste("We recommend that you stay at \'", staybest, "\' if you are going to ", location, "!", sep ="")

hoteltweet <- sample(c(romanticRec, famRec, vacRec, bestRec), 1, replace = FALSE)


latitude <- geocode(location)$lat
longtitude <- geocode(location)$lon
ggplot() + borders(database = "world") + 
  geom_point(mapping = aes(x = longtitude, y = latitude), color = "blue")
ggsave("map.png")

tweet(text = visittweet, mediaPath = "/Users/jaeyoon/Desktop/Data Science/project2/HotelBot/map.png")
tweet(hoteltweet)

file.remove("map.png")


#dynamic interaction
queries <- searchTwitter(searchString = "\\@travel_rec_bot", n =25, lang = "en", since = as.character(Sys.Date()))
