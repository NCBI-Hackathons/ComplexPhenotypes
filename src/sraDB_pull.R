# Pull sraDB info to get started on the dashboard 
library(SRAdb)
library(tidyverse)

if(!file.exists('~/SRAmetadb.sqlite')) sqlfile <<- getSRAdbFile(destdir='~/',destfile='SRAmetadb.sqlite.gz')
sqlfile = '~/SRAmetadb.sqlite'
sra_con <- dbConnect(SQLite(),sqlfile)

