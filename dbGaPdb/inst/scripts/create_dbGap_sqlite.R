# roll through the downloaded dbGap metadata from Downloading_dbGap_metadata.R
# and create 5 data frames for the 5 types of data
library(tidyverse)
library(RSQLite)

# this script downloads current dbgap metadata (will take HOURS)
source('./inst/scripts/Downloading_dbGaP_metadata.R')


dbgap_metadata_path <- './data/dbGaP_files_from_dbgapr'


# get file paths for metadata
dbgap_metadata_files <- list.files(path=dbgap_metadata_path,
                                   pattern = '.txt.gz',
                                   recursive = T,
                                   full.names = T )
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

# read in all data, then rbind rows together
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

dbGapDB_sql_file <- "./data/dbGaPdb.sqlite"
dbGapDB_con <- dbConnect(SQLite(), dbname=dbGapDB_sql_file)


# study_dataset_info
dbWriteTable(dbGapDB_con, "study_dataset_info", table1_data, row.names=TRUE, overwrite=TRUE,
             append=FALSE, field.types=NULL)
# study_id_variable_name
dbWriteTable(dbGapDB_con, "study_id_variable_name", table2_data, row.names=TRUE, overwrite=TRUE,
             append=FALSE, field.types=NULL)
# study_info
dbWriteTable(dbGapDB_con, "study_info", table3_data, row.names=TRUE, overwrite=TRUE,
             append=FALSE, field.types=NULL)
# study_variable_code_value
dbWriteTable(dbGapDB_con, "study_variable_code_value", table4_data, row.names=TRUE, overwrite=TRUE,
             append=FALSE, field.types=NULL)
# study_variable_info
dbWriteTable(dbGapDB_con, "study_variable_info", table5_data, row.names=TRUE, overwrite=TRUE,
             append=FALSE, field.types=NULL)

# compress
system('gzip ./data/dbGapdb.sqlite')

