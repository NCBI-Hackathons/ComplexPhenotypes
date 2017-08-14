# Pull sraDB info to get started on the dashboard 
library(SRAdb)
library(tidyverse)

print('Make sure you have >30GB of free drive space!')
if(!file.exists('~/SRAmetadb.sqlite')) sqlfile <<- getSRAdbFile(destdir='~/',destfile='SRAmetadb.sqlite.gz')
sqlfile = '~/SRAmetadb.sqlite'
sra_con <- dbConnect(SQLite(),sqlfile)

