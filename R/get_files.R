#' @title get_files
#' @description  Given a path and pattern, return named char[] vector of file names.  Ignores files that begin with '_'
#' @param path  char[1] Directory to query. 
#' @param pattern char[1] Regex pattern to match files 
#' @param recursive Logical Default is F.
#' @return named char[] of file names. 
#' @seealso
#'    *  [get_TAGS] 
#' @export  
#'
   get_files  <- function (path = ".", pattern = NULL, recursive = FALSE) {
     # returns base names
     files  <- list.files(path  =  path, pattern = pattern, recursive = recursive)
     # exclude files begin with _
     files  <- files[!grepl('^_', basename(files)) | 
                     !grepl('^_index[.]', basename(files)) ]
     names(files)  <- files
     return(files)
   }

#' @title get_yaml
#' @description   Wrapper for yaml_front_matter.  Given a file containing yaml,
   #' removes "---"; returns named list with one element.  The list contains
   #' character[] corresponding to ONE line yaml.  If file contains no yaml, it
   #' is skipped.
   #'
#' @param file  char[1] of file name.
#' @param dir character[1] full path (without filename)
#' @return unnamed list.  List contents char[] of length equal to lines of
   #' YAML.
#' @export
get_yaml <- function(file = NULL, dir = NULL) {
    ## TODO error checks
    file  <- paste0(dir, "/", file)  
    rmarkdown::yaml_front_matter(file) 
}


#' @title get_t
#' @description returns TAGS
#' ## the_yaml is named list.  Contents of each element is list of length n,
#'   ## correspondng to number of lines of YAML. Content of this element is chr()
#'   ## YAML.  If a file had no YAML, then it is not here.
#'   ## In this function, return the TAGS or NA. 
#'   ##
#' @export 
get_t  <- function(e) {
  if (!is.null(e$TAGS)) { return(e$TAGS)
  } else {
    return(NA)
  }}

  

  


