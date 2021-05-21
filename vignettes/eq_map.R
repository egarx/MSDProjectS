## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(MSDCProjectS)

## -----------------------------------------------------------------------------
path <- "data/earthquakes-2021-05-02_07-20-17_-0400.tsv"
table_original <- read.table(file = path, sep = '\t', header = TRUE)
table <-eq_clean_data(table_original)
table_example <- dplyr::filter(table, lubridate::year(Date) > 2000, Country %in% c("CHINA","JAPAN"))
table_example <- dplyr::select(table_example,Date,Country,Mag,Deaths,Location.Name, Longitude, Latitude)

## -----------------------------------------------------------------------------
eq_map(table_example, annot_col = "Date")

