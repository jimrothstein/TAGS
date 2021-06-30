#'  @title get_files
#'
#'  @description  Given a path and pattern, return char vector of file names.
#'  Ignores files that begin with '_'
#'  @param path  Directory to query. 
#'  @param pattern regex pattern to match files 
#'  @return list of full file name (with directory)
#'  @seealso
#'    *  [get_TAGS] 
#'  @export
   get_files  <- function (path = ".", pattern = NULL, recursive = FALSE) {
     files  <- list.files(path  =  path, pattern = pattern, recursive = recursive)
     # exclude files begin with _
     files  <- files[!grepl('^_', basename(files)) | 
                     !grepl('^_index[.]', basename(files)) ]
     files  <- paste0(path,"/", files)
   }
#'

#'  @title get_header
#'  @description   Wrapper for yaml_front_matter.  Removes "---"; returns list.
   #'  ie header$TAGS (if exists) and contents are char[1]
   #'
#'  @param files. char[] of file names.
#'  @return char[1] For ONE file, returns yaml header.
get_header <- function(files = NULL) {
    rmarkdown::yaml_front_matter(files)
}

#'  @title get_TAGS 
#'
#'  @description Given one yaml header (everything between `---` inclusive), return the line begins with `TAGS:`  Return NA if no line contains `TAGS:`.

#' @param   header For one file, header is named list. Each name entry represents
#' a single yaml line and its contents.  
#'
#' @return char[1] that is content of TAGS:
  get_TAGS   <- function(header) {
    
    header["TAGS"]

           }



