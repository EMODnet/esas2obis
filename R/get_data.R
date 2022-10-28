# This function queries the ESAS API and deals with pagination

get_data <- function(table, querystring = "") {
  # Check table
  tables <- c("campaigns", "samples", "positions", "observations")
  assertthat::assert_that(
    table %in% tables,
    msg = glue::glue(
      "`table` must be one of `{tables}`.",
      tables = paste(tables, collapse = "`, `")
    )
  )

  # Parse querystring
  # TODO: querystring should be passed as named vector c("campaignID" = "001")

  # Create url
  service <- switch(table,
    "campaigns" = "getCampaignRecords",
    "samples" = "getSampleRecords",
    "positions" = "getPositionRecords",
    "observations" = "getObservationRecords"
  )

  # Query API in steps of 10000 records until it no longer returns results
  data <- data.frame()
  end <- FALSE
  offset <- 0
  limit <- 10000
  while(!end) {
    url <- paste0(
      "https://esas.ices.dk/api/", service,
      "?offset=", offset,
      "&limit=", limit,
      "&", querystring
    )
    response <- jsonlite::fromJSON(url, simplifyDataFrame = TRUE)
    if (offset == 0) {
      message(glue::glue("Retrieving {response$recordsCount} records ..."))
    }
    message(offset)
    data <- dplyr::bind_rows(data, response$results)
    end <- response$endOfRecords
    offset <- offset + limit
  }

  return(data)
}
