#' dbGaP: https://github.com/jameslhao/dbgapr_dev
library('dbgapr')
c <- Commons()
prjConfig(c, prjDir="./data/dbGaP_files_from_dbgapr")
getPrjDir(c, showErr = TRUE)
ftpDownload(c, dataStudyOnly=F)

