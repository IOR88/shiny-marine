source("observations.R", chdir = TRUE)
library(testthat)

test_that("test_case_getLongestObservation__default", {
  LON <- c(18.99692, 18.99361, 18.99059, 18.98753)
  LAT <- c(54.77127, 54.76542, 54.76007, 54.75468)
  
  OBSERVATIONS <- data.frame(LON, LAT)
  
  results <- getLongestObservation(OBSERVATIONS)
  expect_type(results, "list")
  expect_type(attributes(results)$distance, "double")
  expect_type(attributes(results)$observations, "list")
  expect_equal(length(attributes(results)$observations), 2)
})

test_that("test_case_getLongestObservation__empty_data_set", {
  LON <- c()
  LAT <- c()
  
  OBSERVATIONS <- data.frame(LON, LAT)
  results <- getLongestObservation(OBSERVATIONS)
  expect_equal(attributes(results)$distance, 0)
  expect_type(attributes(results)$observations, "NULL")
  expect_equal(length(attributes(results)$observations), 0)
})

test_that("test_case_getLongestObservation__too_small_data_set", {
  LON <- c(18.99692)
  LAT <- c(54.77127)
  
  OBSERVATIONS <- data.frame(LON, LAT)
  results <- getLongestObservation(OBSERVATIONS)
  expect_equal(attributes(results)$distance, 0)
  expect_type(attributes(results)$observations, "NULL")
  expect_equal(length(attributes(results)$observations), 0)
})