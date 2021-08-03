
---
title: "`r knitr::current_input()`"
date: "`r paste('last updated', 
    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 4
        toc_float: true
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  4   
fontsize: 11pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  
---
~/code/MASTER_INDEX.md
file="/home/jim/.config/nvim/templates/skeleton.R"

library(tinytest)
# R
#

#
# Simple constructor:

## f is object representing a file and its type (.R, .lua etc)
new_f  <- function(file_name = NULL){

  ## TODO:  more checks:  file exists?   
  # stop if any expr is not TRUE 
  #stopifnot(is.null(file_name), "Please provide valid file name")
  .Data  <- readLines(file_name)

  # for now, assume class == ext
  ext  <-  file_ext(file_name)
  f  <- structure(.Data = .Data,
                  file_name=file_name,
                  class=ext)
}

f  <- new_f("pull_off.R")
f

is.object(f)


## generic functions
   get_TAGS_line  <- function(f) {
     cat("processing ...\n")
     UseMethod("get_TAGS_line")

   }

## methods for generic function
## TODO each must return char[1], TAGS:  based on file class
   get_TAGS_line.default  <- function(f){
     cat("Using default because could not find matching method \n")
   }
   get_TAGS_line.lua  <- function(f) {
     cat("generic method:  lua \n")
   }

   get_TAGS_line.vim  <- function(f) {
     cat("generic method:  vim \n")
   }


## create and test a few instances
    f  <- new_f("pull_off.R")

    f  <- new_f("~/code/lua_project/0001_first_example.lua")

    f  <- new_f("~/code/nvim_project/012_functions_examples.vim")

##  Is right method dispatched?
    get_TAGS_line(f)


##  Begin working on many files at once.   Represent each as S3 object.
##  TODO:  work with list?   use DT table to hold S3 objects?
    ##
    {
    the_objects  <- lapply(dir("."),new_f) 

    }



#
    dput(the_objects)
    str(the_objects)
    head(the_objects)

## playing
{
  x  <- the_objects[[1]]
  x

  # returns list
  attributes(x)
  attributes(x)$file_name
  attributes(x)$class
}

## from S3 objects, return char[] of attributes 
    file_name  <- vapply(the_objects, function(x) attributes(x)$file_name, FUN.VALUE=character(length=1)) 
    S3_class  <- vapply(the_objects, function(x) attributes(x)$class, FUN.VALUE=character(length=1)) 

## convert to dt
{
    library(data.table)
    dt  <- data.table(file_name = file_name,
                      S3_class = S3_class)
    dt
}
