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
}
}{
## name and create temp dir
    the_dir  <- tempdir()
    the_dir
    stopifnot(dir.exists(the_dir))
    list.files(the_dir)
}



#--------------
#  BEGIN HERE 
#--------------
#
####  yml_object:   Create & Study
###
{
##  full yml
##
    h  <- create_fake_yaml_object(the_tags_line = "tag1,tag2, tag3")
    class(h)
    str(h)
    ls.str(h)

tinytest::expect_true(is_yml(create_fake_yaml_object("Tag1")))
tinytest::expect_true(is_yml(h))

## full yml MINUS any TAGS: line
    create_fake_yaml_object()



## ALSO works
.yml = yml(as_yml(c("---\nTAGS:  fakeTag, fakeTag2\n---\n")))
.yml

## But none of this
# C-stack error
    if (F){
    .yml = yml(as_yml(c("---\n---\n")))

    .yml
    .yml = yml(as_yml("---"))
    }

}


#### fake files:   Create & Study
{

create_fake_file(the_yaml_object= h, the_file="first.Rmd")
create_fake_file(the_yaml_object= h, the_file="second.Rmd")
create_fake_file(the_yaml_object= .yml, the_file="third.Rmd")
list.files(the_dir)
the_dir

## To read file:
    path = paste0(the_dir,"/",the_file = "first.Rmd")
    path = paste0(the_dir,"/",the_file = "second.Rmd")
    path

    readLines(path)
}

{
#### custom fake files:  Create & Study
create_fake_rmd_custom(text =  
   c("---","TAGS:  fakeTag, fakeTag2","---"),
   the_file = "third.Rmd")

create_fake_rmd_custom(text=c("---", "---", "main body"), 
                       the_file = "two_lines_only")

create_fake_rmd_custom(text=c("", "", "main body"), 
                       the_file = "NO_yml")
the_dir
}

{
  ## NOTES:  work
     as_yml("tag1: hi\ntag2: bye") 
     as_yml("tag1: hi\ntag2: bye") %>% yml()
     yml(as_yml("tag1: hi\ntag2: bye\nTAGS:  NULL\n"))
     yml(as_yml("tag1: hi\ntag2: bye\nTAGS:  \n"))
###
 ## as_yml:    Create yml of arbitrary content, either:
    as_yml(list("author:  jim", "topic:  TAGS"))
    as_yml(c("author:  jim", "topic:  TAGS"))
    as_yml()  #error
    as_yml(x=NULL) # error
}


{
     ## FAIL
     if (F) {
     yml(as_yml(list("author: jim", "TAGS: tag1,tag2")))
     yml(as_yml(c("author: jim", "TAGS: tag1,tag2")))
     yml_toplevel(c("author: jim", "TAGS: tag1,tag2")) %>% yml()
    }
}

{ ## remove all the temp files and dir
    clean_up(the_dir)
}
#------------------ T E S T I N G 

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



##  Test get_files
{
      the_dir  <- here("tests","testthat","tmp")
      the_pattern  <- '[.]([Rr]|md|[Rr]md)$'   # no spaces
      the_files  <- get_files(path = the_dir, pattern = the_pattern)
      the_files
}












