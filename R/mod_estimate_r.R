#' estimate_r UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_estimate_r_ui <- function(id) {
  ns <- NS(id)
  tagList()
}

#' estimate_r Server Functions
#'
#' @noRd
mod_estimate_r_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}

## To be copied in the UI
# mod_estimate_r_ui("estimate_r_ui_1")

## To be copied in the server
# mod_estimate_r_server("estimate_r_ui_1")
