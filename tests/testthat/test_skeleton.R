library(testthat)


## SKELTON for testing.
##
##
# =======================
if (F) {
testthat::test_path(here("tests","testthat", "test_test01.R"))
testthat::test_file(here("tests","testthat", "test_test01.R"))
}

# =======================
#
# PURPOSE:  Run this file from command line, test_file()



path  <- here("tests", "testthat", "test_test01.R")
path

testthat::test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

testthat::test_that("simple tests", {
  testthat::expect_identical(
    testthat::test_path(path),
    testthat::test_path(here("tests/testthat","test_test01.R"))
    ) }
  ) 


testthat::test_that("misc tests", {
  #browser()
  # explain environment:  why next line false?
  testthat::expect_identical(getwd(),"/home/jim/code/TAGS")
  testthat::expect_match("[ab]", "a")
  testthat::expect_equal("5", "5")
  }
)





