
library(testthat)
library(MSDCProjectS)

test_that("Check output map leaflet", {

  table_original <- data.frame(Country = c("Peru", "Mexico", "CUBA", "SRI LANKA", "Spain", "US","US"),
                               Location.Name = c("Lima", "DF", "Habana", "Island", "Madrid","Maine","Los Angeles"),
                               Date=lubridate::as_date(c("1950-01-01","2000-01-01","2000-01-01","2000-01-01","1999-01-04","1966-06-02","1950-05-01")),
                               Latitude = c (-12.04,19.43,23.12,6.93,40.41,42.25,34.01),
                               Longitude = c(-77.03,-99.13,-82.39,79.85,-3.70,-76.04,-118.4),
                               Deaths = c(7,1,2,8,33,20,3),
                               Mag=c(7,7,6,5,6,6,7),
                               stringsAsFactors = F)

  table_example <- dplyr::select(table_original,Date,Country,Mag,Deaths,Location.Name, Longitude, Latitude)


  table_example <- dplyr::select(table_example,Date,Country,Mag,Deaths,Location.Name, Longitude, Latitude)


  g<-eq_map(table_example, annot_col = "Date")

  expect_equal("leaflet", class(g)[1])
  expect_equal("htmlwidget", class(g)[2])


})
