# Twitterbot - JetSetR - @travel_rec

# This GITHUB repo contains the code for out twitterbot.

#Functionality 1:
Automated random selection of a city from a pre-sorted database.
City is input into Tripadvisor website and then code retrieves:
Top 3 things to do in that city and 4 options on where to stay.

Things to do places are input into Flickr and image is retrieved.

With regard to where to visit, three different types of tweets are randomly generated, but only one of them is chosen at random for the actual tweet.

Due to the limitation in twitteR which does not allow the bot to tweet multiple images at once, 
JetSetR tweets in series. 
1st tweet lists top 3 things to do in the area, along with visualization of the location on world map.
2nd ~ 4th on tweets contain images of the three suggested destinations. 
5th gives a suggestion on accomodation, chosen ramdomly from the 4 options generated earlier.

# Functionality 2:
If the bot is tweeted at using handle with a city name, it will send dms to the user with recommendations on
where to visit and stay.
