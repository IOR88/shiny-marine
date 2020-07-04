source("observations.R", chdir = TRUE)
#library(testthat)

LON <- c(18.99692, 18.99361, 18.99059, 18.98753)
LAT <- c(54.77127, 54.76542, 54.76007, 54.75468)

OBSERVATIONS <- data.frame(LON, LAT)

test_that("default_test_case", {
  results <- getLongestObservation(OBSERVATIONS)
})