
context("update_forecast_locations")

# If input is no, don't proceed ------------------------------------------------
test_that("update_forecast_towns() stops if 'no'", {
  skip_on_cran()
  
  f <- file()
  options(bomrang_connection = f)
  ans <- "no"
  write(ans, f)
  expect_error(update_forecast_towns())
  options(bomrang_connection = stdin())
  close(f)
})

# update_forecast_locations() downloads and imports the proper file ------------
test_that("update_forecast_towns() downloads and imports proper file", {
  skip_on_cran()
  f <- file()
  options(bomrang_connection = f)
  ans <- "yes"
  write(ans, f)
  update_forecast_towns()
  AAC_codes <- NULL
  load(system.file("extdata", "AAC_codes.rda", package = "bomrang"))
  expect_equal(ncol(AAC_codes), 5)
  expect_named(AAC_codes, c("AAC", "PT_NAME", "LON", "LAT", "ELEVATION"))
  expect_equal(options("timeout")[[1]], 60)
})
