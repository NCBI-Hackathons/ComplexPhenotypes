# roll through the downloaded dbGap metadata from Downloading_dbGap_metadata.R
# and create a sqlite database 
library(tidyverse)
library(RSQLite)
library(stringr)
library(data.table)
dbgap_metadata_path <- '~/git/ComplexPhenotypes/data/dbgapr_testdata/'

# get file paths for metadata
dbgap_metadata_files <- list.files(path=dbgap_metadata_path, 
                                   pattern = '.txt.gz', 
                                   recursive = T,
                                   full.names = T )

if(file.exists('./data/dbGapdb.sqlite')) {
  stop('dbGApdb sqlite file already exists!')
  } else {
  # new sqlite file name
  sqlite_file <- "./data/dbGapdb.sqlite"
  sqldb <- dbConnect(SQLite(), dbname=sqlite_file)
  }

# five tables
# 1. study_dataset_info
# 2. study_id_variable_name
# 3. study_info
# 4. study_variable_code_value
# 5. study_variable_info

table1_files <- dbgap_metadata_files[grepl('study_dataset_info', dbgap_metadata_files)]
table2_files <- dbgap_metadata_files[grepl('study_id_variable_name', dbgap_metadata_files)]
table3_files <- dbgap_metadata_files[grepl('study_info', dbgap_metadata_files)]
table4_files <- dbgap_metadata_files[grepl('study_variable_code_value', dbgap_metadata_files)]
table5_files <- dbgap_metadata_files[grepl('study_variable_info', dbgap_metadata_files)]

# read in all data
table1_info <- lapply(table1_files, read_tsv)
table1_data <- do.call("rbind", table1_info)
table2_info <- lapply(table2_files, read_tsv)
table2_data <- do.call("rbind", table2_info)
table3_info <- lapply(table3_files, read_tsv)
table3_data <- do.call("rbind", table3_info)
table4_info <- lapply(table4_files, read_tsv)
table4_data <- do.call("rbind", table4_info)
table5_info <- lapply(table5_files, read_tsv)
table5_data <- do.call("rbind", table5_info)

