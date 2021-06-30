library(testthat)


# create_fake_rmd
#
create_fake_rmd  <- function() {
  writeLines(c("---","TAGS:  fakeTag, fakeTag2","---"), 
           here("tests", "testthat", "fake.Rmd")
           )
}

remove_fake_rmd  <- function(fake_file = 
                       here("tests", "testthat", "fake.Rmd")
) {
  

    if (file.exits(fake_file)) file.remove( fake_file)
}


testthat::test_that("process fake yaml", {
  create_fake_rmd()

  files  <- here("tests", "testthat", "fake.Rmd")
  cat(readLines(files), "\n")


  headers <- lapply(files, get_header)
  headers
  names(headers)  <- files
  headers

  #TAGS  <- lapply(headers, get_TAGS)
  TAGS  <- lapply(headers, get_TAGS.1)
  TAGS

  expect_invisible(get_files())
  x  <- get_files() 
  expect_vector(x) 

  expect_invisible(get_files("."))
  x  <- get_files(".")
  expect_vector(x)

  y  <- double()

  expect_vector(y)

  expect_error(expect_vector(y, size=3))
  remove_fake_rmd()
}
)







