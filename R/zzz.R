
#'  LEGACY (no longer used)
#'  @title remove_comma
#'  remove_commas
#'  @param s  is single character vector or string char[1], where s is of the
#   from "a,b,d..."  and commas are to be removed.
#'  @return  char vector of form:  c("a", "b", "c", "d"  
remove_comma  <- function(s = character()){
  # returns list
  strsplit(s, ',')[[1]]
}

#'    
#'  LEGACY (no longer used)
#'  @title remove_prefix
#'  remove_prefix
#'  @param s  is single character vector or string char[1], where s is of the
#'   from "X: a,b,d..."  and X:  (TAGS:) is to be removed.
#'  @return  char[1]  without X:
remove_prefix  <- function(s = character()){
  ans1  <- strsplit(s, ':\\s*')
  ans1[[1]][2]
}









#'  HELPER functions (non-exported)
#'  LEGACY (no longer used)
#' @title fetch yaml
#'  match top and bottom '---'
#' @details  grep returns int vector indices
#'  USAGE:   x  <-  c('---', 'a;lkdjf;asl ' , '999', 'af---', '---')
#'  match_dashes(x)
x  <-  c('---', 'a;lkdjf;asl ' , '999', 'af---', '---')
match_dashes = function(x) grep('^---\\s*$', x)


#' fetch_yaml
#'
#' @return everything between --- inclusive, char vector
fetch_yaml = function(x) {
  i = match_dashes(x)
  if (length(i) >= 2) x[(i[1]):(i[2])]
}
