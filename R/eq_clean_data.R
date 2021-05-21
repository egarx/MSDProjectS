
#' eq_clean_data
#'
#' Assigning the path's file_name +  processing columns & obtain a cleaned data frame
#'
#' @param table insert the table (data frame).
#'
#' @return a processed data frame version of the original file.
#'
#' @importFrom dplyr select filter mutate select
#'
#' @importFrom lubridate make_datetime as_date
#'
#' @importFrom tidyr replace_na
#'
#' @importFrom stats na.omit
#'
#' @examples
#'
#' \dontrun{
#'
#' #Loading using a third party function and then cleaning the data frame.
#'
#' path <- ".../earthquakes-2021-05-02_07-20-17_-0400.tsv"
#' table_original <- read.table(file = path, sep = '\t', header = TRUE)
#'
#' #Insert table
#'
#' eq_clean_data(table_original)}
#'
#' @export

eq_clean_data <- function(table=table){
  table <- dplyr::select(table,-c(1,6,7,11,14))
  table <- dplyr::filter(table,!is.na(Year))
  table <- dplyr::mutate(table, Mo = tidyr::replace_na(Mo, 12),Dy = tidyr::replace_na(Dy, 31), Date=lubridate::make_datetime(Year, Mo, Dy))
  table <- dplyr::mutate(table,Date = lubridate::as_date(Date,tz = NULL))
  table <- dplyr:: select(table,-c(1,2,3))
  table <- na.omit(table)
  table <- dplyr::mutate(table,Location.Name = gsub(".*: ","",Location.Name))
  return(table)
}

