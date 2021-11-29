#   file <- "TAGS/inst/tinytest/test.R"
#
# ===================================
#   USE TINYTEST::  (practice file)
# ===================================
#
library(tinytest)

## help
?print.tinytest
?tinytest


## test function
f  <- function() 1

expect_equal(f(), 1)



## expect_true
{
    expect_true(2== 2, info="message to tester.")
    expect_true(2== 3, info="message to tester.")
}

## print, short or long
{
    print(expect_true(2== 2), type="short") 
    print(expect_true(2== 2), type="long") 
}

## test this file from cmdline.
if (F) {
    run_test_file("test.R", verbose=0)
}


## Compare actual and expected length of a vector or list.
## How it works:   tinytest constructor runs as 2nd function in stack;
## sys.parent(1) refers to calling function (expect_length) and sys.call retuns
## name.   Examine tinytest object ... debug(sys.call) is not so easy.
{
    # returns tinytest object, either T/F + attributes
    expect_length  <- function(x, n){
        #debug(sys.call) = too messy.
        tinytest::tinytest(
            result = length(x) == n,   # T/F
            call = sys.call(sys.parent(1)),
            diff = paste("length = ", length(x), " expected = ", n)
            )
    }

  x  <-  1:3
  n  <- 3
  res  <- expect_length(x, n)
  attributes(res)  # examine tinytest to see call, diff

  
  n  <- 2
  expect_length(x, n)
}


