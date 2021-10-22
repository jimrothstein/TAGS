---
#title: "`r knitr::current_input()`"
#date: "`r paste('last updated', 
#    format(lubridate::now(), ' %d %B %Y'))`"
output:   
  html_document:  
        code_folding: show
        toc: true 
        toc_depth: 4
        toc_float: true
        mathjax: default
  pdf_document:   
    latex_engine: xelatex  
    toc: true
    toc_depth:  4   
fontsize: 10pt   
geometry: margin=0.4in,top=0.25in   
TAGS:  
---

\small

```
- Use ticks:
- keep YAML, but remove title, date

!pandoc % -f markdown -V fontsize=10 -o ~/Downloads/print_and_delete/out.pdf

# file <- "tests/testthat/test_generate_TAGS_database.R"

## Definitions 
#  
# * `the_files` = named character vector of  files which match the_pattern.  
# * `the_dir` = string; source directory for files.
# *  the_pattern string; regex (PERL) pattern.
# * `the_yaml` = named list, one element for each file.  Content is character
# vector; one line for each line of yaml in the file.  If file has no yaml,
# character vector is TODO.
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

begin  <- Sys.time()

  { ## RETURN `the_files` 
      ## ENDS in either md, R, Rmd  (R or r) 
      ## Omit ^_ files
      the_pattern  <- '[.]([Rr]|md|[Rr]md)$'   # no spaces
      the_files  <- get_files(path = the_dir, pattern = the_pattern)
      the_files
  }

  
    ## RETURN `the_yaml` named list; each element represents one file.  If that
##    file has proper yaml and at least one line (TAGS:) there will be non-empty value in character vector.

    ## ymlthis:::
    the_function  <- function(x) {
        ymlthis:::read_rmd(paste0(the_dir,"/",x), output=c("frontmatter"))
    }
    
    
    x.1   <- lapply(the_files, the_function)
    x.1
    x.2  <- lapply(x.1, function(e) {
               if(class(e) == "yml_blank")
                   e[[1]] = c("yml_blank")
               else
                   e = e})

    
    # why need?
    x.3  <- unlist(x.2)
    str(x.3)
    


    ## strip off numbers of end of file names
    x.4  <- x.3
    x.4
    names(x.4)  <- sub("[0-9]+$", "", names(x.3))
    x.4


    dt.1  <- data.table(file = names(x.4), tags = x.4)
    dt.1 %>% head(n=30L)
    View(dt.1)

## KEEP rows with TAGS or yml_blank 
    {
    dt.1$tags
    dt.2  <- dt.1[grep(tags, pattern="^TAGS:|^yml_blank"),]
    dt.2 %>% head(n=20L)
    str(dt.2)

    dt.4  <- dt.2
}

## remove leading ^TAGS: (Explain need for `unlist`)
## dt.5 should be clean, but not normalized
{
    dt.5  <- dt.4[, .(file, tags = 
                      unlist(lapply(tags, function(e) sub(pattern="^TAGS:", replacement="", x=e))))]
    dt.5
    str(dt.5)

}
        end  <- Sys.time()
        print(end - begin)
}  ## END timed 

####  dt.5 is clean, but not normalized.
###   Summary:  if no YAML, file has "yml_blank"
###   IF TAGS:, but blank means  TAGS: line has no content.
###   IF YAML, but no TAGS: line:   think it was removed!
{  ## view dt <C-Q> to close
  View(dt.5)
}


## NORMALIZE:  RETURN DT
    {
    split_up  <- function(e) strsplit(e,",") 
    dt.6  <- dt.5[, .(tags = unlist(lapply(tags, split_up) )), by=file]
    }

## REMOVE White Space, return CLEAN `files` as DT 
{

        trim.lead  <- function(x) sub("^\\s+", "", x)
        trim.after  <- function(x) sub("\\s+$","",x)
        dt.7  <- dt.6[, .(file, tags = sapply(tags, trim.lead))] 
        str(dt.7)
        dt.7  %>% head(n=20L)
        files  <- dt.7
}

### FINALLY, return DT for `tags`, a lookup table  
{
        dt.8  <- dt.7[,.SD , .SDcols=c("tags")]
        setkey(dt.8, tags)
        key(dt.8)
        ## also check with tables()
        dt.8 %>% head(n=30L) 

        ##  apparently setkey does not remove NA
        tags  <- dt.8
        tags
        #### Capitals before small letters!
        #  tags[order(tags)]
        tags[, tags]  # as character vector
        tags %>% head(n=10L)
}


###  Now have 2 data.tables:   
    *   files has the data (file names and tags) and,
    *   tags is the look up table.

## SAVE and RETRIEVE( redo)
{
        file_name  <- paste0(c("FILES_", "TAGS_"), format(Sys.Date(), "%d%b%Y"))

        # For coding, R internals:
        # save/load save one or more objects into environment

        # For users:
        # saveRDS/readRDS save ONE object, possible retrieve in different name
        saveRDS(tags, file_name[2])
        saveRDS(files, file_name[1])

        # retrieve
        readRDS(file_name[1])
        readRDS(file_name[2])
}

###  Problem, want in order of tags, then file
{
    ##  file order, then tag
        files[order(tags, file)] %>% head(n=20L)

    ##  tags (caps first), then files
        files[,.SD, by = .(tags)][order(tags)]  %>%  head(n=30L)


        ## list by file names
        dt[!is.na(TAGS), sort(names)]

        # number of TAGS per file
        dt[!is.na(TAGS), .N,  by=names] []

        dt
        names(dt)
}

```

