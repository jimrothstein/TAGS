---
title:  "0399A_yaml_utils.R"
date:   "`r format(Sys.Date(), '%d_%b_%Y)`" 
TAGS:  yaml,tags,lapply examples,utils,
---


#'  NOTATION:   Following Hadley (purrr:::) refer to `list` as list and refer
  #'  to `atomic vectors` as character vectors, numeric vectors etc ....
  #'  FOR BREVITY:    chr[] refers to character vector,  chr[n] refers to
  #'  character vector where length of each element is n.
  #'
  #'
'#  PURPOSE:   From all *.R, *.RMD files in a folder, extract `TAGS:`, a yaml
  ###  header and put into database

' ### REF
' # from bookdown::   file=utils.R



#'  @title get_RMD_files
#'
#'  @description  Given a path and pattern, return char vector of file names.
#'  Ignores files that begin with '_'
#'  @param path  Directory to query. 
#'  @param pattern regex pattern to match files 
#'  @return 
#'  @export
   get_RMD_files  <- function (path = ".", pattern = NULL, recursive = FALSE) {
     files  <- list.files(path  =  path, pattern = pattern, recursive = recursive)
     # exclude files begin with _
     files  <- files[!grepl('^_', basename(files)) | 
                     !grepl('^_index[.]', basename(files)) ]
   }

rmd_pattern  <- '[.][Rr](md|markdown)$'
md_pattern  <- '[.][Rr]?(md|markdown)$'

#'  @title fetch_yaml_header
#'  @description  This function does most of actual work:  Given a file name,
#'  return yaml header as character vector, one element per line.
#'  @param f name of file
#'  @return character vector, one entry for each yaml line, `---` inclusive.
#'  @export
  fetch_yaml_header  <- function(f) {
      yaml  <-   bookdown:::fetch_yaml(read_utf8(f))

}

#'  @title get_tags_line
#'  @description Given a yaml header (everything between `---` inclusive),
#'  return the line begins with `TAGS:`  Return NA if no line contains
  #'  `TAGS:`
#'  @param yaml char vector with each element one line of yaml header
#'  @keywords yaml
#'  @export
 get_TAGS_line  <- function (header = null) {
   yaml  <- header
   if (length(yaml) == 0 ) return(NA)

  # drop the elements with `---`
  yaml = yaml[-c(1, length(yaml))]

  # if nothing left, returns a NA
  if (length(yaml) == 0) return(NA)

  line  <- grep("^TAGS:", yaml)

  # no TAGS line
  if (length(line) == 0) return(NA)

  TAGS = yaml[line]
 }



#'  @title remove_null
#`  Given a list, return list (subset) without null entries
#  fals for lapply, why?
# remove_null  <- function (l = NULL) {
#   l[!sapply(l, is.null)]
# }

# =============================
s  <- "TAGS:   a,b,tag3,tag4"
# =============================


#'  remove_prefix
#'  @param s  is single character vector or string char[1], where s is of the
#   from "X: a,b,d..."  and X:  (TAGS:) is to be removed.
#'  @return  char[1]  without X:
remove_prefix  <- function(s = character()){
  ans1  <- strsplit(s, ':\\s*')
  ans1[[1]][2]
}




#'  remove_commas
#'  @param s  is single character vector or string char[1], where s is of the
#   from "a,b,d..."  and commas are to be removed.
#'  @return  char vector of form:  c("a", "b", "c", "d"  
remove_comma  <- function(s = character()){
  # returns list
  strsplit(s, ',')[[1]]
}





#'  HELPER functions (non-exported)
#'
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
