library(testthat)


## Named list; ie header after converted to named list
## minus the "---" at top/botom and minus TAGS: or line:
##
create_fake_named_list  <- function() {
  # header should be of form:
  # f1 .... char[1], name of file, this is one and one element
  # A...C, TAGS .... each is name of yaml line and contents do not have A:,
                      # only content
  header = list(f1 = list (A= "",
                           B= "",
                           C= "",
                           TAGS="tag1, tag2, tag3")
  )
  headers  <- append(header, list(f2 = list (x = "",
                                             y = "",
                                             z = "",
                                             w = "",
                                             TAGS = "tagX, tagY"
                                             )))

}


testthat::test_that("process fake named_list", {
  }
)







