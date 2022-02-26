#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom bslib page_navbar bs_theme nav
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    bslib::page_navbar(
      title = "\\(R_t\\) in Czechia",
      position = "fixed-top",
      collapsible = TRUE,
      bg = "#0062cc",
      theme = bs_theme(version = 5),
      footer = withTags(footer(
        class = "footer mt-auto py-2 bg-light text-muted",
        fluidRow(
          class = "align-items-center justify-content-between",
          div(
            class = "col-md",
            "©", script("document.write(new Date().getFullYear())"),
            "Jan Netík |", "Source code available at", a(href = "https://github.com/netique/rcomp", "GitHub", .noWS = "after"),
            ".", br(),
            "Hosted free of charge by",
            a(href = "https://www.vas-hosting.cz/dobro", "Váš Hosting s.r.o.", .noWS = "after"),
            ", Initial development kindly supported by a",
            a(
              href = "https://www.olejann.net/research-against-covid-19/",
              "TACR GAMA grant at CERGE-EI and Charles University)", .noWS = "after"
            ), "."
          )
        )
      )),
      nav("Estimate",
        icon = icon("calculator"),
        mod_estimate_ui("estimate_ui_1")
      ),
      nav(
        "About",
        icon = icon("info"),
        mod_about_ui("about_ui_1")
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www", app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "rcomp"
    ),

    # other custom scripts loaded from web, to be included in head tag
    tags$script(
      src = "https://cdnjs.cloudflare.com/ajax/libs/headroom/0.12.0/headroom.min.js",
      integrity = "sha512-9UsrKTYzS9smDm2E58MLs0ACtOki+UC4bBq4iK5wi7lJycwqcaiHxr1bdEsIVoK0l5STEzLUdYyDdFQ5OEjczw==",
      crossorigin = "anonymous", referrerpolicy = "no-referrer"
    ),
    tags$script(
      src = "https://cdnjs.cloudflare.com/ajax/libs/headroom/0.12.0/jQuery.headroom.js",
      integrity = "sha512-pmwEYLNG99yaAFqU2lDdLO/34xv4lQSHo+STfaRqxY57FeIBKvQv72A1F3xMYNphxxUwO+jnnYiEDdqpT4dKfQ==",
      crossorigin = "anonymous", referrerpolicy = "no-referrer"
    ),
    # syntax highlighting
    tags$script(src = "//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.1.0/highlight.min.js"),
    tags$link(
      rel = "stylesheet",
      href = "//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.1.0/styles/stackoverflow-light.min.css"
    ),
    tags$script(
      "hljs.configure({cssSelector: 'pre', languages: ['r']}); hljs.highlightAll();"
    ),

    # math typesetting
    tags$link(
      rel = "stylesheet",
      href = "https://cdn.jsdelivr.net/npm/katex@0.13.13/dist/katex.min.css",
      integrity = "sha384-RZU/ijkSsFbcmivfdRBQDtwuwVqK7GMOw6IMvKyeWL2K5UAlyp6WonmB8m7Jd0Hn",
      crossorigin = "anonymous"
    ),
    tags$script(
      defer = "defer",
      src = "https://cdn.jsdelivr.net/npm/katex@0.13.13/dist/katex.min.js",
      integrity = "sha384-pK1WpvzWVBQiP0/GjnvRxV4mOb0oxFuyRxJlk6vVw146n3egcN5C925NCP7a7BY8",
      crossorigin = "anonymous"
    ),
    tags$script(
      defer = "defer",
      src = "https://cdn.jsdelivr.net/npm/katex@0.13.13/dist/contrib/auto-render.min.js",
      integrity = "sha384-vZTG03m+2yp6N6BNi5iM4rW4oIwk5DfcNdFfxkk9ZWpDriOkXX8voJBFrAO7MpVl",
      crossorigin = "anonymous",
      onload = "renderMathInElement(document.body);"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
