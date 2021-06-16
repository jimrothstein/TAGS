library(rlang)

#'  @title file_error_not_found
#'  

#'  @export
conditionMessage.TAGS_error_not_found  <- function(c) {
  glue::glue(c, "'{path}' not found")
}


#' @throws "TAGS_error_not_found"
#' @export
stop_not_found  <- function(path){
  abort(
        msg= "you have trouble",
        # pattern pkg_error_error_type
        #.subclass = "TAGS_error_not_found",
        .subclass = "TAGS_error",
        path=path)
}


#stop_not_found(path = "zzz.zzzz")

rlang::last_error()
rlang::last_trace()


# try-catch
## define an error handler to return the custom error object 
custom_cnd <- tryCatch(error = function(cnd) cnd, 
                      stop_not_found(path= "zzz.zzz")
                      )
custom_cnd
str(custom_cnd)
custom_cnd$path
custom_cnd$msg
