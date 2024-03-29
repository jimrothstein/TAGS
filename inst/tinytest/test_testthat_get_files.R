library(testthat)

path  <- "."

testthat::test_that("??", {
                    testthat::test_path(path)
}
)


rmd_pattern  <- '[.][Rr](md|markdown)$'
md_pattern  <- '[.][Rr]?(md|markdown)$'

testthat::test_that("simple tests, paths, wd", {
  expect_equal(2 * 2, 4)
})

testthat::test_that("simple tests", {
    testthat::expect_identical(here("rmd"),"rmd")
    testthat::expect_identical(getwd(),"/home/jim/code/TAGS/")
    if (F) {
    testthat::expect_match("[ab]", "a")
    testthat::expect_match(rmd_pattern,"junk.Rmd")
    testthat::expect_error(rmd_pattern,"_junk.Rmd")
    testthat::expect_error(rmd_pattern,"abcd_junk.xyz")
}
    testthat::expect_equal("5", "5")


})

testthat::test_that("check get_files", {
  expect_visible(get_files())
  x  <- get_files() 
  expect_vector(x) 

  expect_invisible(get_files("."))
  x  <- get_files(".")
  expect_vector(x)

  y  <- double()

  expect_vector(y)
  expect_error(expect_vector(y, size=3))
}
)


testthat::test_that("test function: get_header", {
})


