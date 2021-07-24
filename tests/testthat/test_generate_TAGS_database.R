# file <- "tests/testthat/test_generate_TAGS_database.R"

## Definitions 
#  
# * `the_files` = named char[] of all files in the_dir which match the_pattern.  
# * `the_dir` TAGS db will come from the_files in this directory.
# *  the_pattern  chr[1] regex pattern.
# * `the_yaml` = named list of yaml, one element for each file in the_files.  Content is char[], one line for each line of yaml.
# * `TAGS` = named chr[],  each element has name = its file name; contents are NA if file has no yaml or 
#   chr[1] of contents of `TAGS:` line ( `tag1,tag2,tag3...` )



#  load_all()
#   Be sure in vim and R in same wd
#    USE   ,rd  setwd("~/code/publish_project/rmd/")
{
  load_all()
  library(data.table)
  library(purrr)
  library(kableExtra)
  options(datatable.prettyprint.char=60L)
}

# FOR testing ##########
the_dir = "~/code/try_things_here/rmd"

{ ## begin

begin  <- Sys.time()

  { ## get_files

      ## ENDS in either md or markdown; preceded by one of .R .r .
      ## ? = 0,1
      rmd_pattern  <- '[.][Rr](md|markdown)$'
      md_pattern  <- '[.][Rr]?(md|markdown)$'
      the_pattern  <- md_pattern

      ## get files (omit files ^_),returns named char[]
      the_files  <- get_files(path = the_dir, pattern = the_pattern)

      ## TODO nicely format
      head(the_files)
  }

{  ## extract yaml for each file

  #
  # For each file, extract yaml contents.   into named list:
  # lapply preserves names, if exist.  
  # the_files is named char[] and so the_yaml is named list
  #
  # each element of \code{}the_yaml} holds a char[], yaml lines of each file.
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

    ## the_yaml is named list, one per file.  Contents of each element is char[],  one for each line of
      ## YAML.  
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
  dt  <- data.table(TAGS = TAGS, names=names(TAGS))
 str( dt)
 length(dt)

 dt[1:3,]
}

end  <- Sys.time()
print(end - begin)
dt[!is.na(TAGS),]
dt
}

{  ## experiments with kable
  # output html
  kable(dt)
  kable(dt,format="pipe", align = "l", caption = "TAGs and files")  %>% head(n=100L)



if (F) {
# Step 1, remove NULL
f  <- function(e) ifelse(is.null(e), return(NA), return(e))
dt  <- dt[,.(files, TAGS = lapply(TAGS, f)) ]
dt
View(dt)
}

## resume
{
# Step 2, NA_character_
# Step 2  use NA_character_ version of NA
#base::strsplit() works with NA_character_, but not NA
f  <- function(e) ifelse(is.character(e),return(e), return(c(NA_character_)))
dt  <- dt[, .(names, TAGS = lapply(TAGS, f)) ]
dt

# Step 3, split and normalize
split_up  <- function(e) base::strsplit(e, split="[,]")
dt  <- dt[, .(TAGS = unlist(lapply(TAGS, split_up) )) , by=names]
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

## for each TAG, list the files
  ## list by TAGS - something wRONG - 
  dt[!is.na(TAGS), ][order(TAGS),.(TAGS, names) ]

## list by file names
  dt[!is.na(TAGS), sort(names)]

# number of TAGS per file
  dt[!is.na(TAGS), .N,  by=names] []

dt
names(dt)


}
