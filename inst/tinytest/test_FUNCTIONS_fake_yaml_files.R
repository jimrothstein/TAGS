{
library(tinytest)
library(ymlthis)
load_all()
## DEFAULT tmp dir:


the_dir  <- here("inst", "tinytest", "tmp/")
}

{ ## Create yml of arbitrary content, either:
    as_yml(list("author:  jim", "topic:  TAGS"))
    as_yml(c("author:  jim", "topic:  TAGS"))

    
}


## create_fake_dir (keep as `tmp`, but still check the_dir, first)
{
create_fake_dir  <- function(the_dir=the_dir){
    ## TODO, 1st remove old one, if exits
    ##
    if (is.null(the_dir) || 
        identical(the_dir, "") ||
        identical(grepl("tmp", the_dir), F)) stop("need the_dir")
    dir.create(the_dir)
}

## test `create_fake_dir`
{
    the_dir  <- NULL
    the_dir  <- ""
    the_dir = "junk"
    grepl("tmp", the_dir)
    identical(grepl("tmp", the_dir), F) 
    create_fake_dir()
    list.dirs(the_dir)
}


## remove_fake_dir
{
remove_fake_dir  <- function(the_dir = the_dir) {
    # TODO, check if exists
    # TODO, why `unlink` never works??
    if (!identical(the_dir, "/home/jim/code/TAGS/tests/testthat/tmp/")) stop("DANGER:  what directory are you deleting??")
    if (!dir.exists(the_dir)) stop("the_dir does not exist")
    file.remove(the_dir)
}
remove_fake_dir()




## remove_fake_rmd
{
remove_fake_rmd  <- function(fake_file = here("tests", "testthat","tmp", "fake.Rmd")) {
        if (file.exists(fake_file)) file.remove( fake_file)
    }
}
remove_fake_rmd()


## create_fake_rmd
{
#  GOAL:   create 4 use cases to test TAGS: ....
#  (1) all correct
#  (2) no yaml of any kind, no TAGS
#  (3) has yaml, no TAGS: line
#  (4) has yaml, has TAGS:  but no acutal tags (blank)
create_fake_rmd  <- function(the_yml = NULL) {
     .yml  <- yml() %>% 
         yml_output(pdf_document(toc =  TRUE, toc_depth=4)) %>%
         yml_latex_opts(
                    fontfamily = "Fira Sans Thin",
                    fontsize = "11pt",
                    links_as_notes = TRUE) %>%  
         # adds suffix `:` to LHS
         yml_toplevel(TAGS = the_yml)
    return(.yml)
}
create_fake_rmd(the_yml="tag1,tag2, tag3")
create_fake_rmd(the_yml="")
create_fake_rmd(the_yml=)
create_fake_rmd(the_yml=  )
create_fake_rmd()
}

## create_fake_rmd_custom (w/o ymlthis::)
{
create_fake_rmd_custom  <- function(the_file = NULL) {
  writeLines(c("---","TAGS:  fakeTag, fakeTag2","---"), 
          paste0(the_dir, the_file ) 
           )
}
}
the_file = NULL
create_fake_rmd_custom(the_file)
{  ## NOTE:  work
     as_yml("tag1: hi\ntag2: bye") 
     as_yml("tag1: hi\ntag2: bye") %>% yml()
     yml(as_yml("tag1: hi\ntag2: bye\nTAGS:  NULL\n"))
     yml(as_yml("tag1: hi\ntag2: bye\nTAGS:  \n"))
}

{
     ## FAIL
     if (F) {
     yml(as_yml(list("author: jim", "TAGS: tag1,tag2")))
     yml(as_yml(c("author: jim", "TAGS: tag1,tag2")))
     yml_toplevel(c("author: jim", "TAGS: tag1,tag2")) %>% yml()
    }
}




     file.remove(here("tests", "testthat", "fake.Rmd"))

    # asks before overwriting (so delete old 1st)
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


#------------------ T E S T I N G 

##  Test get_files
{
      the_dir  <- here("tests","testthat","tmp")
      the_pattern  <- '[.]([Rr]|md|[Rr]md)$'   # no spaces
      the_files  <- get_files(path = the_dir, pattern = the_pattern)
      the_files
}

