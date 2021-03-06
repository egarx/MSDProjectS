% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GeomTimelineLabel.R
\docType{data}
\name{GeomTimelineLabel}
\alias{GeomTimelineLabel}
\title{This function creates a  geom and it describes the center of the top
deadly earthquake and label it with the location.}
\format{
An object of class \code{GeomTimelineLabel} (inherits from \code{Geom}, \code{ggproto}, \code{gg}) of length 6.
}
\usage{
GeomTimelineLabel
}
\value{
Plots the n_max most deadly earthquakes.
}
\description{
This function creates a  geom and it describes the center of the top
deadly earthquake and label it with the location.
}
\examples{

\dontrun{

# Uploads the processed table (it is saved as .rds), not the original one
path <- "data/earthquakes-2021-05-02_07-20-17_-0400.tsv"
table_original <- read.table(file = path, sep = '\t', header = TRUE)
table <-eq_clean_data(table_original)
table_example <- dplyr::filter(table, lubridate::year(Date) > 2000,
                              Country \%in\% c("CHINA","JAPAN"))
table_example <- dplyr::select(table_example,Date,Country,Mag,Deaths,Location.Name)

ggplot2::ggplot(table_example) +
       geom_timeline(aes(x = Date,
                         y = Country,
                         size = Mag,
                         color = Deaths)) +
           ggplot2::layer(geom = GeomTimelineLabel,
                          mapping = aes(x = Date,
                                        label = Location.Name,
                                        y = Country,
                                        mag = Mag,
                                        color = Deaths),
                          stat = 'identity',
                          position = 'identity',
                          show.legend = NA,
                          inherit.aes = TRUE,
                          params = list(na.rm = FALSE))}

}
\keyword{datasets}
