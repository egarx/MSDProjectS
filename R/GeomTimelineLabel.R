

# GeomTimelineLabel
# All the parameter are already defined on purpose.

required_aes = c("x")

optional_aes = c('label','y', 'mag','color','alpha', 'n_max')

default_aes = ggplot2::aes(shape = 21,colour = "black",size = 15.0,n_max = 5,fill = 'black',alpha = 0.4, stroke = 2)

draw_panel <- function(data, panel_params, coord) {
  data <- dplyr::arrange(data,dplyr::desc(.data$mag))
  data <- utils::head(data, unique(data$n_max))
  coords <- coord$transform(data, panel_params)
  lines <- grid::segmentsGrob(x0 = coords$x,
                              y0 = coords$y,
                              x1 = coords$x,
                              y1 = coords$y + 0.15,
                              default.units = "npc",
                              gp = grid::gpar(col =      coords$colour,
                                              alpha =    coords$alpha,
                                              fontsize = coords$size,
                                              lwd =      coords$stroke))

  texts <- grid::textGrob(label = coords$label,
                          x = coords$x,
                          y = coords$y + 0.15,
                          just = "left",
                          rot = 45,
                          check.overlap = TRUE,
                          default.units = "npc",
                          gp = grid::gpar(col =      coords$colour,
                                          fontsize = coords$size,
                                          lwd =      coords$stroke))

  grid::gTree(children = grid::gList(lines, texts))
}


#' This function creates a  geom and it describes the center of the top
#' deadly earthquake and label it with the location.
#'
#' @importFrom rlang .data
#'
#' @importFrom ggplot2 ggproto aes draw_key_polygon Geom
#'
#' @importFrom grid textGrob gTree gpar gList segmentsGrob
#'
#' @importFrom dplyr arrange desc
#'
#' @importFrom utils head
#'
#' @return Plots the n_max most deadly earthquakes.
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
#'ggplot2::ggplot(table_example) +
#'        geom_timeline(aes(x = Date,
#'                          y = Country,
#'                          size = Mag,
#'                          color = Deaths)) +
#'            ggplot2::layer(geom = GeomTimelineLabel,
#'                           mapping = aes(x = Date,
#'                                         label = Location.Name,
#'                                         y = Country,
#'                                         mag = Mag,
#'                                         color = Deaths),
#'                           stat = 'identity',
#'                           position = 'identity',
#'                           show.legend = NA,
#'                           inherit.aes = TRUE,
#'                           params = list(na.rm = FALSE))}
#'
#' @export

GeomTimelineLabel <- ggplot2::ggproto(`_class`     = "GeomTimelineLabel",
                                      `_inherit`   = ggplot2::Geom,
                                      required_aes = required_aes,
                                      optional_aes = optional_aes,
                                      default_aes  = default_aes,
                                      draw_key     = ggplot2::draw_key_point,
                                      draw_panel   = draw_panel)
