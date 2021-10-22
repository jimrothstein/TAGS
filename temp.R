# file <- "tests/testthat/test_generate_TAGS_database.R"

## Definitions 
#  
# * `the_files` = named character vector; files which match the_pattern.  
# * `the_dir` = string; source directory for files.
# *  the_pattern string regex (PERL) pattern.
# * `the_yaml` = named list, one element for each file.  Content is character vector; one line for each line of yaml in th e file.  If file has no yaml, character vector is TODO.
# * `TAGS` = named chr[],  each element has name = its file name; contents are NA if file has no yaml or 
#   chr[1] of contents of `TAGS:` line ( `tag1,tag2,tag3...` )
#


#  load_all()
{
  load_all()
  library(data.table)
}

# source directory
the_dir = "~/code/try_things_here/rmd"

## begin
{
begin  <- Sys.time()

  { ## RETURN `the_files` 

      ## ENDS in either md or markdown; preceded by one of .R .r .
      ## ? = 0,1
      rmd_pattern  <- '[.][Rr](md|markdown)$'
      md_pattern  <- '[.][Rr]?(md|markdown)$'
      the_pattern  <- md_pattern

      ## get files (omit files ^_),returns named char[]
      the_files  <- get_files(path = the_dir, pattern = the_pattern)

      head(the_files)
  }

{  ## RETURN `the_yaml` named list.

  #
    ## ymlthis:::
    the_function  <- function(x) {
        ymlthis:::read_rmd(paste0(the_dir,"/",x), output=c("frontmatter"))
    }
    the_yaml   <- lapply(the_files, the_function)
    the_yaml
}

  ## CLEAN UP 
{
        ## Keep only rows begin ^TAGS, returns
        ## list, 1 for each file, is either character(0) or string of tags
        l.1  <- lapply(the_yaml, function(e) grep(e, pattern="^TAGS:", value=TRUE))

        ## places NA, if empty
        clean_up1  <- function(e) ifelse(length(e) == 0, return(NA),return(e)) 
        l.2  <- lapply(l.1, clean_up1)


        ## remove leading "TAGS:"
        remove_TAGS  <- function(e) sub(pattern="^TAGS:", replacement="",
                                        x =e)
## TODO - replace with list  l.3
        dt.3  <- dt[, .(file, tags = lapply(tags, remove_TAGS))]
}

    ## create dt with 2 columns: 1 for each file, 1 for yaml_content as
    ###character vector 
{ 

    dt  <- data.table(file = names(l.2), tags = unlist(l.2))
    head(dt)

}

        end  <- Sys.time()
        print(end - begin)
}  ## END timed 

####  dt.3 is clean, but not normalized.
{  ## view dt <C-Q> to close
  View(dt.3)
}


## NORMALIZE:  RETURN DT
    {
    split_up  <- function(e) strsplit(e,",") 
    dt.4  <- dt.3[, .(tags = unlist(lapply(tags, split_up) )), by=file]
    }

## REMOVE White Space, return CLEAN `files` as DT 
{

        trim.lead  <- function(x) sub("^\\s+", "", x)
        trim.after  <- function(x) sub("\\s+$","",x)
        dt.5  <- dt.4[, .(file, tags = sapply(tags, trim.lead))] 
        dt.5  %>% head(n=20L)
        files  <- dt.5
}

### FINALLY, return `tags`, a lookup table  
{
        dt.6  <- dt.5[,.SD , .SDcols=c("tags")]
        setkey(dt.6, tags)
        key(dt.6)
        dt.7  <- na.omit(dt.6, col=c("tags"), invert=F)
        dt.7

        ##  apparently setkey does not remove NA
        tags  <- dt.7
        tags
        #### Capitals before small letters!
        #  tags[order(tags)]
        tags[, tags]  # as character vector
        tags %>% head(n=10L)
}


