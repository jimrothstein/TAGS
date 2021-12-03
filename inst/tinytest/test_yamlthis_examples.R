---
TAGS:  create_fake, yaml,test
---

# -----------------------------------------------------------
#
    #
# -----------------------------------------------------------
#
{
library(tinytest)
library(ymlthis)
library(magrittr)
load_all()

## name and create temp dir
    the_dir  <- tempdir()
    the_dir
    stopifnot(dir.exists(the_dir))
    list.files(the_dir)
}


    ## works, but TWo yml() ???
    yml() %>% yml_toplevel(.yml = list(A="a")) %>% 
         yml_output(pdf_document(toc =  TRUE, toc_depth=4)) %>%
         yml_latex_opts(
                    fontfamily = "Fira Sans Thin",
                    fontsize = "11pt",
                    links_as_notes = TRUE) %>% 
         # adds suffix `:` to LHS
         ## useage:   yml_toplevel("TAGS:  hello")
         yml_toplevel(.yml = list(TAGS= "the_tags_line")) %>% yml()
.yml
is_yml(.yml)
# [1] TRUE

    {
        ## returns .yml object, and prints like yaml
    z  <- yml_toplevel(.yml= list(greet = "hi", leave="bye")) %>% yml()
    z
    is_yml(z)
}
