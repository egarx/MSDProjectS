

# GeomTimeline
# All the parameter are already defined on purpose. Table has to be uploaded as explained below

required_aes = c("x")

optional_aes = c('y', 'color', 'size',  'alpha')

default_aes = ggplot2::aes(pch = 21, colour = "black",size = 0.01,fill = 'grey',alpha = 0.4,stroke = 1)

draw_panel <- function(data,
                       panel_params,
                       coord) {

  data$size <- data$size/max(data$size)

  coords <- coord$transform(data, panel_params)

  grid::circleGrob(
    coords$x,coords$y,
    r = coords$size/25, gp = grid::gpar(col = scales::alpha(coords$colour, coords$alpha),
                                        fill =     scales::alpha(coords$colour, coords$alpha),
                                        alpha =    coords$alpha,
                                        fontsize = coords$size,
                                        lwd =      coords$stroke))
}

#' This function is the Geom.
#'
#' @importFrom ggplot2 ggproto aes draw_key_point Geom
#'
#' @importFrom grid circleGrob gpar
#'
#' @importFrom scales alpha
#'
#' @return Creates the setup to be plotted by the geom_timeline.
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
# Plotting using layer.
#'ggplot2::ggplot(table_example) +
#'  ggplot2::layer(geom = GeomTimeline,
#'                 mapping = ggplot2::aes(x = Date,
#'                                        y = Country,
#'                                        size = Mag,
#'                                        color = Deaths),
#'                 data = table_example,
#'                 stat = 'identity',
#'                 position = 'identity',
#'                 show.legend = NA,
#'                 inherit.aes = TRUE,
#'                 params = list(na.rm = FALSE))}
#'
#' @export

GeomTimeline <- ggplot2::ggproto(`_class`     = "GeomTimeline",
                                 `_inherit`   = ggplot2::Geom,
                                 required_aes = required_aes,
                                 optional_aes = optional_aes,
                                 default_aes  = default_aes,
                                 draw_key     = ggplot2::draw_key_point,
                                 draw_panel   = draw_panel)
