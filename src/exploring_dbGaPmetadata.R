#playing with dbGaP metadata to see what's there
#once you already downloaded a test data set of the dbGaP data
#there are five types of data files associated with each dbGaP study
#Load paths to these five files 
path_file1 <- "Desktop/Hackathon_NCBI2017/dbGaPR/metadata/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_id_variable_name.txt.gz"
path_file2 <- "Desktop/Hackathon_NCBI2017/dbGaPR/metadata/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_dataset_info.txt.gz"
path_file3 <- "Desktop/Hackathon_NCBI2017/dbGaPR/metadata/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_info.txt.gz"
path_file4 <- "Desktop/Hackathon_NCBI2017/dbGaPR/metadata/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_variable_code_value.txt.gz"
path_file5 <- "Desktop/Hackathon_NCBI2017/dbGaPR/metadata/phs000007/phs000007.v1/supplemental_data/phs000007.v1_study_variable_info.txt.gz"

#create tables of files to view in R 
  #File type 1: Variable_name
    Variable_name <- read.table(path_file1,header =T)
  #File type 2 : dataset_info
    Dataset <- read.table(path_file2, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
  #File type 3 :
    Studyinfo <- read.table(path_file3, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
  #File type 4
    VariableCodeValue <- read.table(path_file4, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")
  #File type 5
    VariableInfo <- read.table(path_file5, header = T, fill = TRUE, quote = "", sep ='\t', stringsAsFactors = FALSE, encoding="UTF-8")