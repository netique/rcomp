#' estimate_r
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
r_inc_data <- function(d) {
estimate_R(
 d%>% transmute(dates = date, I = inc),
             method = "parametric_si",
             config = make_config(list(
               mean_si = input$mean_si_inc,
               std_si = input$std_si_inc,
               t_start = t_start(),
               t_end = t_end()
             ))
  ) %>%
    plot("R") %>%
    ggplot_build() %$% .$plot$data %>%
    add_column(.before = 1, ts_source = "incidence")

  }
