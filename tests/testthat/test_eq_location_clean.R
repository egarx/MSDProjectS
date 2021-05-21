
library(testthat)
library(MSDCProjectS)

test_that("check date format", {

  table_original <- data.frame(Country = c("Peru", "Mexico", "CUBA", "SRI LANKA", "Spain", "US","US"),
                                           Location.Name = c("Lima", "DF", "Habana", "Island", "Madrid","Maine","Los Angeles"),
                                                 Date=lubridate::as_date(c("1950-01-01","2000-01-01","2000-01-01","2000-01-01","1999-01-04","1966-06-02","1950-05-01")),
                                                 Latitude = c(31.1,38,35.683,34.1,36.4,31.5,35.5),
                                                 Longitude = c(35.5,58.2,35.8,43.2,25.4,35.3,25.5),
                                                 Deaths = c(7,1,2,8,33,20,3),
                                                 Mag=c(7,7,6,5,6,6,7),
                                                 stringsAsFactors = F)

  table_example <- dplyr::select(table_original,Date,Country,Mag,Deaths,Location.Name)

  ggplot2::ggplot(table_example) +
    ggplot2::layer(geom = GeomTimeline,
                   mapping = ggplot2::aes(x = Date,
                                          y = Country,
                                          size = Mag,
                                          color = Deaths),
                   data = table_example,
                   stat = 'identity',
                   position = 'identity',
                   show.legend = NA,
                   inherit.aes = TRUE,
                   params = list(na.rm = FALSE))

  expect_equal("Date", class(table_example$Date[1]))
})
