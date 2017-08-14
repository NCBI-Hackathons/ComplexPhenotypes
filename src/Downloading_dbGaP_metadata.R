#Hackathon
#dbGaP tools, Lunning made this: https://github.com/jameslhao/dbgapr_dev
library('dbgapr')
c <- Commons()
prjConfig(c, prjDir="~/dbGaPR")
getPrjDir(c, showErr = TRUE)
ftpDownload(c, dataStudyOnly=F)

