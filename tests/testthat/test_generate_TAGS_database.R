# file <- "tests/testthat/test_generate_TAGS_database.R"

## Definitions 
  
  * `the_dir` TAGS db will come from the_files in this directory.
  * `the_files` = char[] of all files to be process for TAGS
  * `headers` = named list of yaml, one element for each file in files. Content
    includes all yaml specifications, include  if exits.
  * `TAGS` = named list, each element has name = its file name; contents are
    chr[1] of contents of `TAGS:`  ( `tag1,tag2,tag3...` )
  *  `the_yaml` =  


#  load_all()
#   Be sure in vim and R in same wd
#    USE   ,rd  setwd("~/code/publish_project/rmd/")
{
  load_all()
  library(data.table)
  library(purrr)
}

# FOR testing ##########
the_dir = "~/code/try_things_here/rmd"



{ ## begin

begin  <- Sys.time()

  { ## get_files

      # ENDS in either md or markdown; preceded by one of .R .r .
      # ? = 0,1
      rmd_pattern  <- '[.][Rr](md|markdown)$'
      md_pattern  <- '[.][Rr]?(md|markdown)$'
      the_pattern  <- md_pattern
      # get files (omit files ^_)
      # named char[]
      the_files  <- get_files(path = the_dir, pattern = the_pattern)

      # TODO nicely format
      head(the_files)
  }

{  ## extract yaml for each file

  # TODO - lost the files with no YAML.
  #
    # For each file, extract yaml contents.   into named list:
  # lapply preserves names, if exist.  
  # the_files is named char[] and so the_yaml is named list
  #
    # each element of the_yaml holds a char[], yaml lines of each file.
  # # the_files is named char[]
    the_yaml  <- lapply(the_files, get_yaml, dir=the_dir )

    # check
    names(the_yaml)
    length(the_yaml)
    # Example
    the_yaml[[2]]  # contents
    names(the_yaml[2]) # name of elment 2
}




{ ## extract TAGS content

    ## the_yaml is named list.  Contents of each element is char[] of lines of
      ## YAML.  If a file had no YAML, then it is not here.
      ##
    # in base:   return named char[], with NA if file has no TAGS line
    # default: unlist removes names 
    TAGS <- unlist(lapply(the_yaml, get_t), use.names =T)
    TAGS[1:20]
    length(TAGS)
    is.character(TAGS)
}

### START

{ ## setup in dt
  dt  <- data.table(x = TAGS, names=names(TAGS))
 str( dt)
 length(dt)

 dt[1:3,]
}

end  <- Sys.time()
print(end - begin)
}




#### STOP

# Step 1, remove NULL
f  <- function(e) ifelse(is.null(e), return(NA), return(e))
dt  <- dt[,.(files, TAGS = lapply(TAGS, f)) ]
dt

# Step 2, NA_character_
# Step 2  use NA_character_ version of NA
#base::strsplit() works with NA_character_, but not NA
f  <- function(e) ifelse(is.character(e),return(e), return(c(NA_character_)))
dt  <- dt[, .(files, TAGS = lapply(TAGS, f)) ]
dt

# Step 3, split and normalize
split_up  <- function(e) base::strsplit(e, split="[,]")
dt  <- dt[, .(TAGS = unlist(lapply(TAGS, split_up) )) , by=files]
head(dt, n=100L)
dt[, .N]



file_name  <- paste0("TAGS_", format(Sys.Date(), "%d%b%Y"))
file_name

# For coding, R internals:
# save/load save one or more objects into environment

# For users:
# saveRDS/readRDS save ONE object, possible retrieve in different name
saveRDS(dt, file_name)

# retrieve
lines  <- readRDS(file_name)
lines

example(data.table)
dt[!is.na(TAGS), sort(TAGS)]
dt[!is.na(TAGS), sort(files)]

# TAGS per file
dt[!is.na(TAGS), .N,  by=files] []

names(dt)







