#playing with dbGaP metadata to see what's there
#once you already downloaded a test data set of the dbGaP data
#there are five types of data files associated with each dbGaP study
#Load paths to these five files
Main_path <- "/Users/michellemiron/Desktop/oldhackathon/Hackathon/dbGaPR/metadata/"
path_file1 <- paste(Main_path,"/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_dataset_info.txt.gz", sep="")
path_file2 <- paste(Main_path,"/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_info.txt.gz", sep="")
path_file3 <- paste(Main_path,"/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_variable_code_value.txt.gz", sep="")
path_file4 <- paste(Main_path,"/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_variable_info.txt.gz", sep="")
path_file5 <- paste(Main_path,"/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_id_variable_name.txt.gz", sep="")

#create tables of files to view in R
  #File type 1: Variable_name
dataset_info <- read.table(path_file1, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
  #File type 2 : dataset_info
info <- read.table(path_file2, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
  #File type 3 :
variable_code <- read.table(path_file3, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
  #File type 4
variable_info <- read.table(path_file4, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
  #File type 5
id_variable_name <- read.table(path_file5, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
