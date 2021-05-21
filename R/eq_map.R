
#' eq_map
#'
#' It plots circles on a map to determine the eartquake location. The radius
#' of the circle is relative to its magnitude.
#'
#' @param map_table_example a data frame with Date, Longitude, Latitude, and Mag columns.
#'
#' @param annot_col information to be displayed as popup when hovering.
#'
#' @importFrom magrittr %>%
#'
#' @importFrom leaflet addTiles addCircles
#'
#' @importFrom rlang .data
#'
#' @return A map with earthquakes' circles.
#'
#' @examples
#' #'
#' \dontrun{
#' # Creating a Dataset.
#'path <- "data/earthquakes-2021-05-02_07-20-17_-0400.tsv"
#'table_original <- read.table(file = path, sep = '\t', header = TRUE)
#'table <-eq_clean_data(table_original)
#'table_example <- dplyr::filter(table, lubridate::year(Date) > 2000,
#'                               Country %in% c("CHINA","JAPAN"))
#'table_example <- dplyr::select(table_example,Date,Country,Mag,Deaths,
#'Location.Name, Longitude, Latitude)
#'
#' eq_map(table_example, annot_col = "Date")
#'}
#'
#' @export

eq_map <- function(map_table_example = rlang::.data, annot_col) {

  # Using Leaflet to plot a map.
  aux <- leaflet::leaflet(map_table_example)
  aux <- leaflet::addTiles(aux)
  # Adding circles in each Earthquake point.
  aux<-leaflet::addCircles(aux,lng = ~Longitude,
                           lat = ~Latitude,
                           weight = 1,
                           radius = ~Mag * 20000,
                           # Plotting a simple information inside of the popup.
                           popup = ~eval(parse(text = annot_col)) ) -> map_to_plot

  # Returning the map with circles.
  return(map_to_plot)
}
