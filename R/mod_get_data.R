#' get_data UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom httr GET content accept_json
#' @importFrom jsonlite fromJSON
#' @importFrom purrr pluck
#' @importFrom dplyr bind_rows
#'
mod_get_data_ui <- function(id) {
  ns <- NS(id)
  tagList()
}

#' get_data Server Functions
#'
#' @noRd
mod_get_data_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns


    total_items <- reactive({
      r <- GET("https://onemocneni-aktualne.mzcr.cz/api/v3/nakazeni-vyleceni-umrti-testy",
        query = list(
          apiToken = Sys.getenv("mzcr_covid_token"),
          itemsPerPage = 1
        )
      )

      r %>%
        content(type = "text", encoding = "UTF-8") %>%
        fromJSON() %>%
        pluck("hydra:totalItems")
    })

    output$total_items <- renderPrint(total_items())


    d <- reactive({
      r <- GET("https://onemocneni-aktualne.mzcr.cz/api/v3/nakazeni-vyleceni-umrti-testy",
        accept_json(),
        query = list(
          apiToken = Sys.getenv("mzcr_covid_token"),
          itemsPerPage = 10000
        )
      )

      r %>%
        content(encoding = "UTF-8") %>%
        bind_rows()
    }) %>% bindCache(total_items())



    return(d)
  })
}

## To be copied in the UI
# mod_get_data_ui("get_data_ui_1")

## To be copied in the server
# mod_get_data_server("get_data_ui_1")
