#' estimate UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom DT DTOutput
#'
mod_estimate_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h4("Resource data"),
    div(
      style = "overflow-x: scroll;",
      DTOutput(ns("main_data"))
    )
  )
}

#' estimate Server Functions
#'
#' @noRd
mod_estimate_server <- function(id, d) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$main_data <- renderDT(d())
  })
}

## To be copied in the UI
# mod_estimate_ui("estimate_ui_1")

## To be copied in the server
# mod_estimate_server("estimate_ui_1")
