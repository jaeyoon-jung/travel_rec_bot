library(rvest)

    # @jaeyoon: The trend is: https://www.tripadvisor.com/A
    # where A = city which is one word = cityname = London
    # where A = city which is two words = city-name = Los_Angeles
    
trips <- read_html(triplink)
  
visit1 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(5) > div > div > div > div.col.attractions > ul > li:nth-child(1) > div.loc > div.name > a") %>% html_text()
visit2 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(5) > div > div > div > div.col.attractions > ul > li:nth-child(2) > div.loc > div.name > a") %>% html_text()
visit3 <- trips %>% html_nodes(css = "#BODYCON > div:nth-child(5) > div > div > div > div.col.attractions > ul > li:nth-child(3) > div.loc > div.name > a") %>% html_text()
  
stayrom <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(1) > div > a.hotel.name") %>% html_text()
stayrom <- gsub("\n", "", stayrom)
stayfam <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(2) > div > a.hotel.name") %>% html_text()
stayfam <- gsub("\n", "", stayfam)
stayvac <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(3) > div > a.hotel.name") %>% html_text()
stayvac <- gsub("\n", "", stayvac)
staybest <- trips %>% html_nodes(css = "#HTL_FAVS > li:nth-child(4) > div > a.hotel.name") %>% html_text()
staybest <- gsub("\n", "", staybest)  


