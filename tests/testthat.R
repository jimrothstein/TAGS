library(testthat)
context("1st Test for TAGS")
rmd_pattern  <- '[.][Rr](md|markdown)$'
md_pattern  <- '[.][Rr]?(md|markdown)$'

#test_check("TAGS")
# test_package("TAGS")

testthat("simple tests", {
testthat::expect_identical(here("rmd"),"rmd")
testthat::expect_identical(getwd(),"/home/jim/code/TAGS/")
testthat::expect_match("[ab]", "a")
testthat::expect_match(rmd_pattern,"junk.Rmd")
testthat::expect_match(rmd_pattern,"_junk.Rmd")
testthat::expect_match(rmd_pattern,"abcd_junk.xyz")
testthat::expect_equal("5", "5")
})

   # MOVE TO TEST
   # dir = "."
   #    dir = "~/code/try_things_here/rmd"
   #     x  <- get_RMD_files(path=dir)
   # x
