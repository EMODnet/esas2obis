#' Get code list
#'
#' Returns all codes for the given code type as a data frame. Uses the
#' [`GetCodeList`](http://vocab.ices.dk/services/POX.aspx#GetCodeList) API.
#'
#' @param codeType Code type, e.g. `SEXCO`.
#' @return A data frame with all codes for that code type. Will return an empty
#'   data frame for unrecognized code type.
getCodeList <- function(codeType) {
  endpoint <- paste0("https://vocab.ices.dk/services/pox/GetCodeList/", codeType)
  result <- xml2::read_xml(endpoint)
  listOfCodes <- xml2::as_list(result)$GetCodeListResponse$Code

  df <- purrr::map_dfr(listOfCodes, function(x) {
    x <- purrr::modify(x, ~ ifelse(length(.) == 0, list(NA), .))
    x <- purrr::map_dfc(x, function(x) {
      value <- unlist(x)
      purrr::set_names(value, names(x))
    })
    x
  })
  return(df)
}
