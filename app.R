
install.packages("forestly")
install.packages("metalite")

library(metalite)
library(forestly)

forestly_adsl$TRTA <- factor(forestly_adsl$TRT01A, levels = c("Xanomeline Low Dose", "Placebo"), labels = c("Low Dose", "Placebo"))

forestly_adae$TRTA <- factor(forestly_adae$TRTA, levels = c("Xanomeline Low Dose", "Placebo"), labels = c("Low Dose", "Placebo"))



meta_forestly(
  forestly_adsl,
  forestly_adae,
  population_term = "apat",
  observation_term = "wk12"
) |>
  prepare_ae_forestly(parameter = "any;rel;ser") |>
  format_ae_forestly() |>
  ae_forestly()
