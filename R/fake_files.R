
#-----------
# FUNCTIONS
#-----------
    
#### 1 create_fake_yaml_object
{
#  GOAL:   create 4 use cases to test TAGS: ....
#  (1) all correct
#  (2) no yaml of any kind, no TAGS
#  (3) has yaml, no TAGS: line
#  (4) has yaml, has TAGS:  but no acutal tags (blank)
   #
## TODO:   this creates yml OBJECT; not a header, but can be used to create
### header.
create_fake_yaml_object  <- function(the_tags_line = NULL) {
     .yml  <- yml() %>% 
         yml_output(pdf_document(toc =  TRUE, toc_depth=4)) %>%
         yml_latex_opts(
                    fontfamily = "Fira Sans Thin",
                    fontsize = "11pt",
                    links_as_notes = TRUE) %>% 
         yml_toplevel(as_yml(paste0("TAGS:  ",  the_tags_line, "\n")
                                    ))
     
    return(.yml)
}
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




#### 3 create_fake_rmd_custom (w/o ymlthis::)
{
create_fake_rmd_custom  <- function(text=NULL, the_file = NULL) {
  writeLines(text = text, paste0(the_dir, the_file ) )
}
}

####  4 Remove all fake files and fake directory.
{
    clean_up  <- function(the_dir = NULL){
## recursive = TRUE removes directories
    ## TODO:   compare:   on.exit(unlink(...))
   ans  <- unlink(the_dir, recursive = TRUE)
   ans
}
}  

