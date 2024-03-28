
# install.packages("forestly")
# install.packages("remotes")
# remotes::install_github("Merck/forestly")
# remotes::install_github("Merck/boxly")
# install.packages("metalite")
# rsconnect::writeManifest()

library(metalite)
library(forestly)
library(boxly)
library(shiny)

adsl <- forestly::forestly_adsl
adae <- forestly::forestly_adae
adsl$TRTA <- factor(adsl$TRT01A, levels = c("Xanomeline Low Dose", "Placebo"), labels = c("Low Dose", "Placebo"))
adae$TRTA <- factor(adae$TRTA, levels = c("Xanomeline Low Dose", "Placebo"), labels = c("Low Dose", "Placebo"))



ui <- fluidPage(
  h1("Arcus Example Study XYZ"),
  br(),
  
  h2("Adverse Events"),
  div(style = "padding-left:70px",
    meta_forestly(
      adsl,
      adae,
      population_term = "apat",
      observation_term = "wk12"
    ) |>
    prepare_ae_forestly(parameter = "any;rel;ser") |>
    format_ae_forestly() |>
    ae_forestly()
  ),
  br(),
  
  h2("Labs"),
  div(style = "padding-left:60px",
    meta_boxly(
      boxly_adsl,
      boxly_adlb,
      population_term = "apat",
      observation_term = "wk12",
      observation_subset = AVISITN <= 12 & !is.na(CHG)
    ) |>
      prepare_boxly() |>
      boxly()
  ),
  br(),
  
  h2("Vital Signs"),
  
  div(style = "padding-left:60px",
    meta_boxly(
      boxly_adsl,
      boxly_advs,
      population_term = "apat",
      observation_term = "wk12",
      observation_subset = AVISITN <= 12 & !is.na(CHG)
    ) |>
      prepare_boxly() |>
      boxly()
  ),
  br(),
  
  h2("ECGs"),
  div(style = "padding-left:60px",
    meta_boxly(
      boxly_adsl,
      boxly_adeg,
      population_term = "apat",
      observation_term = "wk12",
      observation_subset = AVISITN <= 12 & !is.na(CHG)
    ) |>
      prepare_boxly() |>
      boxly()
  )

)


server <- function(input, output, session) {}
shinyApp(ui, server)
