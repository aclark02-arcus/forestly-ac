
# install.packages("forestly")
# install.packages("remotes")
# remotes::install_github("Merck/forestly")
# install.packages("metalite")
# rsconnect::writeManifest()

library(metalite)
library(forestly)
library(shiny)

adsl <- forestly::forestly_adsl
adae <- forestly::forestly_adae
adsl$TRTA <- factor(adsl$TRT01A, levels = c("Xanomeline Low Dose", "Placebo"), labels = c("Low Dose", "Placebo"))
adae$TRTA <- factor(adae$TRTA, levels = c("Xanomeline Low Dose", "Placebo"), labels = c("Low Dose", "Placebo"))


ui <- meta_forestly(
    adsl,
    adae,
    population_term = "apat",
    observation_term = "wk12"
  ) |>
  prepare_ae_forestly(parameter = "any;rel;ser") |>
  format_ae_forestly() |>
  ae_forestly()

server <- function(input, output, session) {}
shinyApp(ui, server)
