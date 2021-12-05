##  tinytest::  helper functions for fake yml files
    
#'  @title create_fake_yaml_object
#'  @description   GOAL:   create 4 use cases to test TAGS: ....
#'	  (1) all correct
#'	  (2) no yaml of any kind, no TAGS
#'	  (3) has yaml, no TAGS: line
#'	  (4) has yaml, has TAGS:  but no acutal tags (blank)
## TODO:   this creates yml OBJECT; not a header, but can be used to create
### header.
#'  @examples
#'	    \dontrun{
#'	    h  <- create_fake_yml_object(the_tags_line = "tag1,tag2, tag3")
#'	    class(h)
#'	    str(h)
#'	    ls.str(h)
#'	    }
create_fake_yml_object  <- function(the_tags_line = NULL) {
     .yml  <- yml() %>% 
         yml_output(pdf_document(toc =  TRUE, toc_depth=4)) %>% yml_latex_opts( fontfamily = "Fira Sans Thin",
                    fontsize = "11pt",
                    links_as_notes = TRUE)

         if (length(the_tags_line) == 0) return(.yml)
         if (the_tags_line == "TAGS:") 
             return(.yml %>% yml_toplevel(as_yml("TAGS: \\s")))
#             return(.yml %>% yml_toplevel(as_yml("TAGS: how to put in blank characer? ")))
                                    
         .yml %>% 
             yml_toplevel(as_yml(paste0("TAGS:  ",  the_tags_line, "\n")))
}



#### 2 create_fake_file(), using fake yml_object
{
    create_fake_file  <- function(the_yaml_object = NULL, the_file = NULL) {

    ymlthis::use_rmarkdown(.yml = the_yaml_object, 
                       path = paste0(the_dir,"/",the_file),
                       open_doc = F, # do not open file
                       quiet = T,
                       body="Main body of file.")

}
}




#### 3 create_fake_file_custom (w/o ymlthis::)
{
create_fake_file_custom  <- function(text=NULL, the_dir = NULL, the_file = NULL) {
  writeLines(text = text, paste0(the_dir, "/", the_file ) )
}
}
create_fake_file_custom(c("line1", "line2"),the_dir="test_dir", the_file="fake1")
####  4 Remove all fake files and fake directory.
{
    clean_up  <- function(the_dir = NULL){
## recursive = TRUE removes directories
    ## TODO:   compare:   on.exit(unlink(...))
   ans  <- unlink(the_dir, recursive = TRUE)
   ans
}
}  

