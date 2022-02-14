# Installing all required packages
install.packages("plumber")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("gapminder")

#calling the packages to get used in the project
library(plumber)
library(dplyr)
library(ggplot2)
library(gapminder)

#* @apiTitle Gapminder API
#* @apiDescription API for exploring Gapminder dataset

#* Returns countries that satisfy condition
#* @param in_continent
#* @param in_lifeExpGT Life expectancy greater than
#* @param in_popGT Population greater than
#* @get /countries

function(in_continent, in_lifeExpGreater, in_popGreater){
  gapminder %>% 
    filter(
      year == 2010,
      continent == in_continent,
      lifeExp > in_lifeExpGreater,
      pop > in_popGreater
    )
}

#* Returns a line plot of life expectancy for country
#* @param in_country
#* @param in_title Chart title
#* @get /plot
#* @serializer contentType list(type='image/png')

my_Func <- function(in_country, in_title){
  subset <- gapminder %>% 
    filter(country == in_country)
  plot <- ggplot(subset, aes(x = year, y = lifeExp)) +
    geom_line(color = "#fadbd8", size = 2) + 
    geom_point(color = "#daf786", size = 5) +
    ggtitle(in_title) +
    theme_dark() +
    theme(aspect.ratio = 9 / 16)
  file <- "plot.png"
  ggsave(file, plot)
  readBin(file, "raw", n = file.info(file)$size)
}

my_Func("Pakistan", "Chart")




  