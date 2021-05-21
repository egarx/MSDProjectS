## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(MSDCProjectS)
   
# devtools::check_win_release()

## -----------------------------------------------------------------------------
path <- "data/earthquakes-2021-05-02_07-20-17_-0400.tsv"
table_original <- read.table(file = path, sep = '\t', header = TRUE)
table <-eq_clean_data(table_original)

## -----------------------------------------------------------------------------
tail(table,3)

