---
TAGS:  create_fake, yaml,tinytest, helper
---

# -----------------------------------------------------------
# file <- "inst/tinytest/test_FUNCTIONS_fake_yml_files.R "
#
# PURPOSE:   create assorted FAKE files for testthat: testing.
#
# -----------------------------------------------------------
#
{
library(tinytest)
library(ymlthis)
library(magrittr)
load_all()
}

## name and create temp dir
{
    ## the_dir  <- tempdir()
    ##  but prefer more control:
    the_dir  <- "./test_dir"

## default remove OLD
    if (dir.exists(the_dir)) unlink(the_dir, recursive=T) 
    dir.exists(the_dir)

    dir.create(the_dir)

    stopifnot(dir.exists(the_dir))
    list.files(the_dir)
}


##  tinytest:   create_fake_yml_object()



## full yml header
tinytest::expect_true(is_yml(create_fake_yml_object("Tag1")))

## 
## full yml header, but tagsline:   TAGS: null 

## default, basic yml, but no TAGS: line
    {
    x  <- ymlthis::yml()

    tinytest::expect_true(is_yml(x))
    }

## works
create_fake_yml_object(the_tags_line = "tag1,tag2, tag3")

    {  ## all create `null`
    create_fake_yml_object(the_tags_line = "")
    create_fake_yml_object(the_tags_line = " ")
    create_fake_yml_object(the_tags_line = NULL)
        create_fake_yml_object()
        }
## create fake files
##  yml:  dot lines only
{

the_file  <- "dotted_lines_only.Rmd"
the_path  <- paste0(the_dir, "/", the_file) 
the_path
the_text= c("---", "---", "Only dotted lines here")
       
create_fake_file_custom(text=the_text, the_dir = the_dir, the_file= the_file)


}
{ ## no yml, no yml header at all
the_file  <- "no_yml_file.Rmd"
the_path  <- paste0(the_dir, "/", the_file) 

create_fake_file_custom(text="fake_file", the_dir = the_dir, the_file= the_file)

list.files(the_dir)

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












