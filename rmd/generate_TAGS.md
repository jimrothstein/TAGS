## Definitions

-   `files` = char\[\] of all files to be process for TAGS
-   `headers` = named list of yaml, one element for each file in files.
    Content includes all yaml specifications, include if exits.
-   `TAGS` = named list, each element has name = its file name; contents
    are chr\[1\] of contents of `TAGS:` ( `tag1,tag2,tag3...` )

# ==========

# load\_all()

# Be sure in vim and R in same wd

# USE ,rd setwd(“~/code/publish\_project/rmd/”)

    load_all()

    ## ℹ Loading TAGS

    library(data.table)
    library(rmarkdown)


    # relative to project root, 
    here()

    ## [1] "/home/jim/code/TAGS"

    dir  <- here("rmd")
    dir

    ## [1] "/home/jim/code/TAGS/rmd"

    # testing ##########
    dir = "~/code/try_things_here/rmd"
    # testing ##########

    {
    begin  <- Sys.time()
    rmd_pattern  <- '[.][Rr](md|markdown)$'
    md_pattern  <- '[.][Rr]?(md|markdown)$'

    files  <- get_RMD_files(path = dir, pattern = rmd_pattern)
    head(files)


    # each file, grab yaml header, return list called headers
    # each element of headers (or `header`) is also list
    # each header has element for each line of yaml as char[]
    headers  <- lapply(files, rmarkdown::yaml_front_matter)
    head(headers)

    # be sure each header knows its file name!
    names(headers)  <- files 
    head(headers)


    # Given header, return element with name TAGS
    get_TAGS  <- function(h = NULL) h$TAGS


    # TAGS is a named list, each element has
    # ... name, chr[1], file_name
    # ... value,chr[1], contents of tags "tag1, tag2, ..."
    TAGS  <- lapply(headers, get_TAGS)

    end  <- Sys.time()
    print(end - begin)
    }

    ## Time difference of 0.0791 secs

    TAGS

    ## $`~/code/try_things_here/rmd/00001_lintr.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00002_glue.Rmd`
    ## [1] "glue"
    ## 
    ## $`~/code/try_things_here/rmd/00002_list_of_functions.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00007_Hadley_dplyr_vignette_2_semantics.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00010_dplyr_misc_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/000100_create_epub.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/000100_matrix_.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00011_factor_forcats_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00016_forcats_r4ds_ch15.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00032_regex_stringr_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00032B_regex_grepl_ryan_tutor.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00032C_kable_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00038_bindata_FAKE_data.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0004_math_equations_adding_dependenicies.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/000400_match_call_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00051_jennybc_what_they_forgot_test_that.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00053_md_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00054_md_with_bash.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00055_md_sample_letter.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00056_httr_vignette.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00057_httr_demo_google.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00063_grolemund_list_columns.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00064_knitr_chunk_practice.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00065_knitr_pkg_functions.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00065B_knitr_pkg_functions.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00065B_pandoc_commands.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00066_fs_stringr_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00066C_fs_print_directory.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00067_tribble_tibble.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00068_usethis_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00069_pak_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00070_dplyr_simple_summary_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00073_dplyr_vignette_window.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00075_anova_m_clark.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00077_studioapi_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00078_anova_simple_split_example.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00079_jennybc_purrr_tutuorial_gh_users.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00080_jennybc_repurrrsive_got_chars.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00082_election.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00085_system_tools.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00085B_R_ENV_variables.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00094_study_examples_data_table.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00095_vignette_keys.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00095A_vignette_sd.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00097_base_dput_structure.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00097_basic_trace_debug.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00098_hannay_categorical.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00099_hannay_chapter_09_sampling.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00099_hannay_clustering.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00100_base_rank.Rmd`
    ## [1] "reprex,rank"
    ## 
    ## $`~/code/try_things_here/rmd/00120_NULL_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0013_R6_intro.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00130_dput_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00140_purrr_dplyr_basic_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00150_invisible_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00160_base_list.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00200_S3_vctrs.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0028_simple_boxplot.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00290_DT_vignette_intro.rmd`
    ## [1] "data.table,vignette,flights14,dplyr,magrittr,purrr"
    ## 
    ## $`~/code/try_things_here/rmd/00291_DT_STUDY_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00292_DT_rbindlist.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00293_DT_misc.Rmd`
    ## [1] "data.table,purrr,structure,dput,normalize,starwars"
    ## 
    ## $`~/code/try_things_here/rmd/00293_DT_practice_examples.Rmd`
    ## [1] "data.table,lapply"
    ## 
    ## $`~/code/try_things_here/rmd/00294_DT_vignette_sd.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00295_DT_Lahman_vignette.Rmd`
    ## [1] "data.table,Lahman,"
    ## 
    ## $`~/code/try_things_here/rmd/00295_DT_utils.Rmd`
    ## [1] "yaml,tags,lapply examples,utils,vignette"
    ## 
    ## $`~/code/try_things_here/rmd/00296_base_R_misc.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00296_DT_vignette_keys.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00297_DT_vignette_ref_semantics.Rmd`
    ## [1] "data.table,flights14"
    ## 
    ## $`~/code/try_things_here/rmd/00298_DT_normalize.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00299_DT_reshape.Rmd`
    ## [1] "data.table,Lahman,"
    ## 
    ## $`~/code/try_things_here/rmd/00299B_DT_advanced.Rmd`
    ## [1] "data.table,NSE,quote,substitution,eval"
    ## 
    ## $`~/code/try_things_here/rmd/00301_nested_chunks_literate_programming.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00302_child.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00302_knitr_modify_label_in_template.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00310_github_gh_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00320_jsonlite_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00400_quasiquotation.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00410_defusing_rlang.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00500_c_functions.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00620_fs_print_directory.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00630_collect_knitr_chunks_regex.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0086_base_file_commands.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0088_base_package_commands.Rmd`
    ## [1] "packageDescription(),dependencies,remove.packages(),old.packages()"
    ## 
    ## $`~/code/try_things_here/rmd/0088C_base_probe_one_package.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0089_lapply_sapply.Rmd`
    ## [1] "lapply,sapply,named,unamed,simplification"
    ## 
    ## $`~/code/try_things_here/rmd/00900_html_notebook.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00991_random.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/00999_covid_plots.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01010_basic_distributions.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01020_binomial_distribution.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01030_poisson_distribution.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01050_sampling_basic.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01060_sampling_BINOM.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01062_sampling_chi_squared.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01063_chi_squared_simulation.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01070_sampling_advanced_hannay_Ch8.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01074_anova_simple_example.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01075_anova_basics_mtcars.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/01300_r_language_server.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0200_math_latex.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0200_rprojroot_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0220_tiny_tex.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0230_embed_latex.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0300_recursion.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/080_run_zsh_cmds_inside_rmd.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/0800_simple_regression_rafael.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/1030_basic_t_test.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/1040_base_plot_examples.Rmd`
    ## NULL
    ## 
    ## $`~/code/try_things_here/rmd/11050_base_vectors.Rmd`
    ## NULL

    dt  <- data.table(files = basename(files),
                      TAGS = TAGS)

    dt

    ##                                            files TAGS
    ##   1:                             00001_lintr.Rmd     
    ##   2:                              00002_glue.Rmd glue
    ##   3:                 00002_list_of_functions.Rmd     
    ##   4: 00007_Hadley_dplyr_vignette_2_semantics.Rmd     
    ##   5:               00010_dplyr_misc_examples.Rmd     
    ##  ---                                                 
    ## 106:             080_run_zsh_cmds_inside_rmd.Rmd     
    ## 107:           0800_simple_regression_rafael.Rmd     
    ## 108:                       1030_basic_t_test.Rmd     
    ## 109:                 1040_base_plot_examples.Rmd     
    ## 110:                      11050_base_vectors.Rmd

    head(dt, n=10L)

    ##                                           files TAGS
    ##  1:                             00001_lintr.Rmd     
    ##  2:                              00002_glue.Rmd glue
    ##  3:                 00002_list_of_functions.Rmd     
    ##  4: 00007_Hadley_dplyr_vignette_2_semantics.Rmd     
    ##  5:               00010_dplyr_misc_examples.Rmd     
    ##  6:                      000100_create_epub.Rmd     
    ##  7:                          000100_matrix_.Rmd     
    ##  8:           00011_factor_forcats_examples.Rmd     
    ##  9:                 00016_forcats_r4ds_ch15.Rmd     
    ## 10:            00032_regex_stringr_examples.Rmd

    # 

    # Step 1, remove NULL
    f  <- function(e) ifelse(is.null(e), return(NA), return(e))
    dt  <- dt[,.(files, TAGS = lapply(TAGS, f)) ]
    dt

    ##                                            files TAGS
    ##   1:                             00001_lintr.Rmd   NA
    ##   2:                              00002_glue.Rmd glue
    ##   3:                 00002_list_of_functions.Rmd   NA
    ##   4: 00007_Hadley_dplyr_vignette_2_semantics.Rmd   NA
    ##   5:               00010_dplyr_misc_examples.Rmd   NA
    ##  ---                                                 
    ## 106:             080_run_zsh_cmds_inside_rmd.Rmd   NA
    ## 107:           0800_simple_regression_rafael.Rmd   NA
    ## 108:                       1030_basic_t_test.Rmd   NA
    ## 109:                 1040_base_plot_examples.Rmd   NA
    ## 110:                      11050_base_vectors.Rmd   NA

    # Step 2, NA_character_
    # Step 2  use NA_character_ version of NA
    #base::strsplit() works with NA_character_, but not NA
    f  <- function(e) ifelse(is.character(e),return(e), return(c(NA_character_)))
    dt  <- dt[, .(files, TAGS = lapply(TAGS, f)) ]
    dt

    ##                                            files TAGS
    ##   1:                             00001_lintr.Rmd   NA
    ##   2:                              00002_glue.Rmd glue
    ##   3:                 00002_list_of_functions.Rmd   NA
    ##   4: 00007_Hadley_dplyr_vignette_2_semantics.Rmd   NA
    ##   5:               00010_dplyr_misc_examples.Rmd   NA
    ##  ---                                                 
    ## 106:             080_run_zsh_cmds_inside_rmd.Rmd   NA
    ## 107:           0800_simple_regression_rafael.Rmd   NA
    ## 108:                       1030_basic_t_test.Rmd   NA
    ## 109:                 1040_base_plot_examples.Rmd   NA
    ## 110:                      11050_base_vectors.Rmd   NA

    # Step 3, split and normalize
    split_up  <- function(e) base::strsplit(e, split="[,]")
    dt  <- dt[, .(TAGS = unlist(lapply(TAGS, split_up) )) , by=files]
    head(dt, n=100L)

    ##                                             files            TAGS
    ##   1:                              00001_lintr.Rmd            <NA>
    ##   2:                               00002_glue.Rmd            glue
    ##   3:                  00002_list_of_functions.Rmd            <NA>
    ##   4:  00007_Hadley_dplyr_vignette_2_semantics.Rmd            <NA>
    ##   5:                00010_dplyr_misc_examples.Rmd            <NA>
    ##   6:                       000100_create_epub.Rmd            <NA>
    ##   7:                           000100_matrix_.Rmd            <NA>
    ##   8:            00011_factor_forcats_examples.Rmd            <NA>
    ##   9:                  00016_forcats_r4ds_ch15.Rmd            <NA>
    ##  10:             00032_regex_stringr_examples.Rmd            <NA>
    ##  11:            00032B_regex_grepl_ryan_tutor.Rmd            <NA>
    ##  12:                    00032C_kable_examples.Rmd            <NA>
    ##  13:                  00038_bindata_FAKE_data.Rmd            <NA>
    ##  14: 0004_math_equations_adding_dependenicies.Rmd            <NA>
    ##  15:               000400_match_call_examples.Rmd            <NA>
    ##  16: 00051_jennybc_what_they_forgot_test_that.Rmd            <NA>
    ##  17:                        00053_md_examples.Rmd            <NA>
    ##  18:                       00054_md_with_bash.Rmd            <NA>
    ##  19:                   00055_md_sample_letter.Rmd            <NA>
    ##  20:                      00056_httr_vignette.Rmd            <NA>
    ##  21:                   00057_httr_demo_google.Rmd            <NA>
    ##  22:             00063_grolemund_list_columns.Rmd            <NA>
    ##  23:               00064_knitr_chunk_practice.Rmd            <NA>
    ##  24:                00065_knitr_pkg_functions.Rmd            <NA>
    ##  25:               00065B_knitr_pkg_functions.Rmd            <NA>
    ##  26:                   00065B_pandoc_commands.Rmd            <NA>
    ##  27:                00066_fs_stringr_examples.Rmd            <NA>
    ##  28:                00066C_fs_print_directory.Rmd            <NA>
    ##  29:                     00067_tribble_tibble.Rmd            <NA>
    ##  30:                   00068_usethis_examples.Rmd            <NA>
    ##  31:                       00069_pak_examples.Rmd            <NA>
    ##  32:      00070_dplyr_simple_summary_examples.Rmd            <NA>
    ##  33:              00073_dplyr_vignette_window.Rmd            <NA>
    ##  34:                      00075_anova_m_clark.Rmd            <NA>
    ##  35:                 00077_studioapi_examples.Rmd            <NA>
    ##  36:         00078_anova_simple_split_example.Rmd            <NA>
    ##  37:   00079_jennybc_purrr_tutuorial_gh_users.Rmd            <NA>
    ##  38:      00080_jennybc_repurrrsive_got_chars.Rmd            <NA>
    ##  39:                           00082_election.Rmd            <NA>
    ##  40:                       00085_system_tools.Rmd            <NA>
    ##  41:                   00085B_R_ENV_variables.Rmd            <NA>
    ##  42:          00094_study_examples_data_table.Rmd            <NA>
    ##  43:                      00095_vignette_keys.Rmd            <NA>
    ##  44:                       00095A_vignette_sd.Rmd            <NA>
    ##  45:                00097_base_dput_structure.Rmd            <NA>
    ##  46:                  00097_basic_trace_debug.Rmd            <NA>
    ##  47:                 00098_hannay_categorical.Rmd            <NA>
    ##  48:         00099_hannay_chapter_09_sampling.Rmd            <NA>
    ##  49:                  00099_hannay_clustering.Rmd            <NA>
    ##  50:                          00100_base_rank.Rmd          reprex
    ##  51:                          00100_base_rank.Rmd            rank
    ##  52:                      00120_NULL_examples.Rmd            <NA>
    ##  53:                            0013_R6_intro.Rmd            <NA>
    ##  54:                      00130_dput_examples.Rmd            <NA>
    ##  55:         00140_purrr_dplyr_basic_examples.Rmd            <NA>
    ##  56:                 00150_invisible_examples.Rmd            <NA>
    ##  57:                          00160_base_list.Rmd            <NA>
    ##  58:                           00200_S3_vctrs.Rmd            <NA>
    ##  59:                      0028_simple_boxplot.Rmd            <NA>
    ##  60:                  00290_DT_vignette_intro.rmd      data.table
    ##  61:                  00290_DT_vignette_intro.rmd        vignette
    ##  62:                  00290_DT_vignette_intro.rmd       flights14
    ##  63:                  00290_DT_vignette_intro.rmd           dplyr
    ##  64:                  00290_DT_vignette_intro.rmd        magrittr
    ##  65:                  00290_DT_vignette_intro.rmd           purrr
    ##  66:                  00291_DT_STUDY_examples.Rmd            <NA>
    ##  67:                       00292_DT_rbindlist.Rmd            <NA>
    ##  68:                            00293_DT_misc.Rmd      data.table
    ##  69:                            00293_DT_misc.Rmd           purrr
    ##  70:                            00293_DT_misc.Rmd       structure
    ##  71:                            00293_DT_misc.Rmd            dput
    ##  72:                            00293_DT_misc.Rmd       normalize
    ##  73:                            00293_DT_misc.Rmd        starwars
    ##  74:               00293_DT_practice_examples.Rmd      data.table
    ##  75:               00293_DT_practice_examples.Rmd          lapply
    ##  76:                     00294_DT_vignette_sd.Rmd            <NA>
    ##  77:                 00295_DT_Lahman_vignette.Rmd      data.table
    ##  78:                 00295_DT_Lahman_vignette.Rmd          Lahman
    ##  79:                           00295_DT_utils.Rmd            yaml
    ##  80:                           00295_DT_utils.Rmd            tags
    ##  81:                           00295_DT_utils.Rmd lapply examples
    ##  82:                           00295_DT_utils.Rmd           utils
    ##  83:                           00295_DT_utils.Rmd        vignette
    ##  84:                        00296_base_R_misc.Rmd            <NA>
    ##  85:                   00296_DT_vignette_keys.Rmd            <NA>
    ##  86:          00297_DT_vignette_ref_semantics.Rmd      data.table
    ##  87:          00297_DT_vignette_ref_semantics.Rmd       flights14
    ##  88:                       00298_DT_normalize.Rmd            <NA>
    ##  89:                         00299_DT_reshape.Rmd      data.table
    ##  90:                         00299_DT_reshape.Rmd          Lahman
    ##  91:                       00299B_DT_advanced.Rmd      data.table
    ##  92:                       00299B_DT_advanced.Rmd             NSE
    ##  93:                       00299B_DT_advanced.Rmd           quote
    ##  94:                       00299B_DT_advanced.Rmd    substitution
    ##  95:                       00299B_DT_advanced.Rmd            eval
    ##  96: 00301_nested_chunks_literate_programming.Rmd            <NA>
    ##  97:                              00302_child.Rmd            <NA>
    ##  98:     00302_knitr_modify_label_in_template.Rmd            <NA>
    ##  99:                 00310_github_gh_examples.Rmd            <NA>
    ## 100:                  00320_jsonlite_examples.Rmd            <NA>
    ##                                             files            TAGS

    dt[, .N]

    ## [1] 140

    file_name  <- paste0("TAGS_", format(Sys.Date(), "%d%b%Y"))
    file_name

    ## [1] "TAGS_29May2021"

    saveRDS(dt, file_name)

    # retrieve
    lines  <- readRDS(file_name)
    lines

    ##                                            files TAGS
    ##   1:                             00001_lintr.Rmd <NA>
    ##   2:                              00002_glue.Rmd glue
    ##   3:                 00002_list_of_functions.Rmd <NA>
    ##   4: 00007_Hadley_dplyr_vignette_2_semantics.Rmd <NA>
    ##   5:               00010_dplyr_misc_examples.Rmd <NA>
    ##  ---                                                 
    ## 136:             080_run_zsh_cmds_inside_rmd.Rmd <NA>
    ## 137:           0800_simple_regression_rafael.Rmd <NA>
    ## 138:                       1030_basic_t_test.Rmd <NA>
    ## 139:                 1040_base_plot_examples.Rmd <NA>
    ## 140:                      11050_base_vectors.Rmd <NA>
