library(testthat)
load_all()


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


#  GOAL:   create 4 use cases to test TAGS: ....
#  (1) all correct
#  (2) no yaml of any kind, no TAGS
#  (3) has yaml, no TAGS: line
#  (4) has yaml, has TAGS:  but no acutal tags (blank)
create_fake_rmd2  <- function(yaml = NULL) {
    library(ymlthis)

    # Problems:
     # as_yml must be single string
     yml(as_yml("tag1: hi\ntag2: bye"))

    # Problems:
    # Lot of rules about punctuation, quote, string etc.

    # works (case 1)
    fake_tags  <- "t1, t2, t3,  tag1"

    # completely omits TAGS: line (case 3)
    fake_tags  <- NULL

    # adds  TAGS:  ' '    (single quotes!)
    fake_tags  <- " "

    # works
     .yml  <- yml() %>% 
         yml_output(pdf_document(toc =  TRUE, toc_depth=4)) %>%
         yml_latex_opts(
                    fontfamily = "Fira Sans Thin",
                    fontsize = "11pt",
                    links_as_notes = TRUE
        ) %>% 
         yml_toplevel(TAGS = fake_tags)


     file.remove(here("tests", "testthat", "fake.Rmd"))

    # asks before overwriting (delete 1st)
     # WORKS
ymlthis::use_rmarkdown(.yml = .yml, 
                       path = here("tests", "testthat", "fake.Rmd"),
                       open_doc = F, # do not open file
                       quiet = T,
                       body="Main body of file.")



}

## redo with tinytest::
if (F) { 

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


}




