#hotel read link
topcities <- read.csv("100 Top Cities.csv")

location <- sample(topcities[,1], 1, replace = FALSE)
location <- as.character(location) #city name
locationkey <- gsub(" ", "_", location)


triplink <- paste("https://www.tripadvisor.com/", locationkey, sep = "")


