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
table_example <- dplyr::filter(table, lubridate::year(Date) > 2000,
                               Country %in% c("CHINA","JAPAN"))
table_example <- dplyr::select(table_example,Date,Country,Mag,Deaths,Location.Name)

## -----------------------------------------------------------------------------
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

