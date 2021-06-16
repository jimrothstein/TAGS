
#'  @title get_files
#'
#'  @description  Given a path and pattern, return char vector of file names.
#'  Ignores files that begin with '_'
#'  @param path  Directory to query. 
#'  @param pattern regex pattern to match files 
#'  @return full file name (with directory)
#'  @export
   get_files  <- function (path = ".", pattern = NULL, recursive = FALSE) {
     files  <- list.files(path  =  path, pattern = pattern, recursive = recursive)
     # exclude files begin with _
     files  <- files[!grepl('^_', basename(files)) | 
                     !grepl('^_index[.]', basename(files)) ]
     files  <- paste0(path,"/", files)
   }


#'  @title get_file_header
   #'
#'  @description  wrapper.
   #'
#'
   #'  chr[1].
   #'  file name
   #'  Contents of TAGS: line, if not empty
   #'
get_file_headers <- function(files = NULL) {

# each file, grab yaml header, return list called headers
# each element of headers (or `header`) is also list
# each header has element for each line of yaml as char[]
  #
  lapply(files, rmarkdown::yaml_front_matter)
}


# be sure each header knows its file name!
names(headers)  <- files 
}

get_TAGS  <- function(headers = NULL) headers$TAGS
