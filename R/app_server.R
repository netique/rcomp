#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom DT renderDT
#' @noRd
app_server <- function(input, output, session) {
  main_data <- mod_get_data_server("get_data_ui_1")

  mod_estimate_server("estimate_ui_1", d = main_data)

output$sessinfo <- renderPrint({sessionInfo()})
}
