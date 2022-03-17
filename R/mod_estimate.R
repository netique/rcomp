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
#' @importFrom plotly plotlyOutput renderPlotly ggplotly
#' @importFrom EpiEstim estimate_R make_config
#' @importFrom dplyr select filter transmute rename
#' @import ggplot2
#'
mod_estimate_ui <- function(id) {
  ns <- NS(id)
  tagList(
    sliderInput(ns("mean_si_inc"), "SI mean", min = 1.1, value = 5.2, max = 30, step = .1),
    sliderInput(ns("sd_si_inc"), "SI SD", min = 1.1, value = 4.7, max = 30, step = .1),
    plotlyOutput(ns("plot")),
    verbatimTextOutput(ns("inc_est_out"))
  )
}

#' estimate Server Functions
#'
#' @noRd
mod_estimate_server <- function(id, d) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    inc_data <- reactive({
      d() %>% select(dates = date, I = inc)
    })


    inc_est <- reactive({
      req(input$mean_si_inc, input$sd_si_inc)

      estimate_R(inc_data(),
        method = "parametric_si",
        config = make_config(list(
          mean_si = input$mean_si_inc,
          std_si = input$sd_si_inc
          # t_start = t_start(),
          # t_end = t_end()
        ))
      )
    })

    output$plot <- renderPlotly({
     p <-  inc_est()$R %>%
        ggplot(aes(t_end, `Mean(R)`)) +
        geom_ribbon(aes(ymin = `Quantile.0.025(R)`, ymax = `Quantile.0.975(R)`),
          alpha = .1
        ) +
        geom_ribbon(aes(ymin = `Quantile.0.05(R)`, ymax = `Quantile.0.95(R)`),
          alpha = .33
        ) +
        geom_ribbon(aes(ymin = `Quantile.0.25(R)`, ymax = `Quantile.0.75(R)`),
          alpha = .6
        ) +
        geom_line() +
        coord_cartesian(ylim = c(0, 4))

     p %>% ggplotly
    })

    output$inc_est_out <- renderPrint({
      inc_est()
    })
  })
}

## To be copied in the UI
# mod_estimate_ui("estimate_ui_1")

## To be copied in the server
# mod_estimate_server("estimate_ui_1")
