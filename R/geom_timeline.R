

#' geom_timeline
#'
#' It creates the output of GeomTimeline function, meking the timeline.
#'
#' @importFrom ggplot2 layer
#'
#' @inheritParams ggplot2::geom_point
#'
#' @return Creates a layer to plot the GeomTimeline output function.
#'
#' @examples
#'
#' \dontrun{
#'
#' # Uploads the processed table (it is saved as .rds), not the original one
#'path <- "data/earthquakes-2021-05-02_07-20-17_-0400.tsv"
#'table_original <- read.table(file = path, sep = '\t', header = TRUE)
#'table <-eq_clean_data(table_original)
#'table_example <- dplyr::filter(table, lubridate::year(Date) > 2000,
#'                               Country %in% c("CHINA","JAPAN"))
#'table_example <- dplyr::select(table_example,Date,Country,Mag,Deaths,Location.Name)
#'
#' ggplot2::ggplot(table_example) +
#'      geom_timeline(ggplot2::aes(x = Date,
#'                        y = Country,
#'                        size = Mag,
#'                        color = Deaths))}
#'
#' @export

geom_timeline <- function(mapping = NULL,
                          data = NULL,
                          stat = "identity",
                          position = "identity",
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE, ...){

  ggplot2::layer(geom = GeomTimeline,
                 mapping = mapping,
                 data = data,
                 stat = stat,
                 position = position,
                 show.legend = show.legend,
                 inherit.aes = inherit.aes,
                 params = list(na.rm = na.rm,...)
  )}
