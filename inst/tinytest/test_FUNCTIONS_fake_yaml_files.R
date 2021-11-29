---
TAGS:  create_fake, yaml,test
---

# -----------------------------------------------------------
# file <- "inst/tinytest/test_FUNCTIONS_fake_yaml_files.R "
# PURPOSE:   create assorted FAKE files for testing.
#
    #
# -----------------------------------------------------------
#
{
library(tinytest)
library(ymlthis)
library(magrittr)
load_all()

## name and create temp dir
    the_dir  <- tempdir()
    the_dir
    stopifnot(dir.exists(the_dir))
    list.files(the_dir)
}





#### create_fake_yaml_object
{
#  GOAL:   create 4 use cases to test TAGS: ....
#  (1) all correct
#  (2) no yaml of any kind, no TAGS
#  (3) has yaml, no TAGS: line
#  (4) has yaml, has TAGS:  but no acutal tags (blank)
    #
## TODO:   this creates yml OBJECT; not a header, but can be used to create
### header.
create_fake_yaml_object  <- function(the_tags_line = NULL) {
     .yml  <- yml() %>% 
         yml_output(pdf_document(toc =  TRUE, toc_depth=4)) %>%
         yml_latex_opts(
                    fontfamily = "Fira Sans Thin",
                    fontsize = "11pt",
                    links_as_notes = TRUE) %>%  
         # adds suffix `:` to LHS
         yml_toplevel(TAGS = the_tags_line)
    return(.yml)
}


####  yml_object:   Create & Study
    h  <- create_fake_yaml_object(the_tags_line = "tag1,tag2, tag3")
    class(h)
    str(h)
    ls.str(h)

    if (F){
    ## bad: creates TAGS: ''
    create_fake_yaml_object(the_tags_line="")

    ## bad:  creates TAGS:  .na
    create_fake_yaml_object(the_tags_line=NA)

    ## next 3 are same;  no line `TAGS:`
    create_fake_yaml_object(the_tags_line= NULL)
    create_fake_yaml_object(the_tags_line=  )
    create_fake_yaml_object()
    }
}

#### create_fake_file(), using fake yml_object
{
    create_fake_file  <- function(the_yaml_object = NULL, the_file = NULL) {

    ymlthis::use_rmarkdown(.yml = the_yaml_object, 
                       path = paste0(the_dir,"/",the_file),
                       open_doc = F, # do not open file
                       quiet = T,
                       body="Main body of file.")

}


create_fake_file(the_yaml_object= h, the_file="first.Rmd")
create_fake_file(the_yaml_object= h, the_file="second.Rmd")

list.files(the_dir)

## To read:
    path = paste0(the_dir,"/",the_file = "first.Rmd")
    path = paste0(the_dir,"/",the_file = "second.Rmd")
    path

    readLines(path)

## STOP
}

##  Remove all fake files and fake directory.
{
## recursive = TRUE removes directories
    ## TODO:   compare:   on.exit(unlink(...))
    list.files(the_dir)
   ans  <- unlink(the_dir, recursive = TRUE)
   ans
    list.files(the_dir)
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




#### -----------------------------------------
##      LEGACY
#### -----------------------------------------
##
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
##
##  No longer need
if (FALSE){
## create_fake_dir (keep as `tmp`, but still check the_dir, first)
create_fake_dir  <- function(the_dir=the_dir){
    ## TODO, 1st remove old one, if exits
    ##
    is_empty_dir  <- FALSE 
    is_empty_dir  <- is.null(the_dir) || 
        identical(the_dir, "") ||
        identical(grepl("tmp", the_dir), F)

    if (is_empty_dir) stop("need the_dir")


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
}

####  LEGACY
###
{ ## as_yml:    Create yml of arbitrary content, either:
    as_yml(list("author:  jim", "topic:  TAGS"))
    as_yml(c("author:  jim", "topic:  TAGS"))
    
}
