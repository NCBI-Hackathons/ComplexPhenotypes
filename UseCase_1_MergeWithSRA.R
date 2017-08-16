#Use Case Number 1: Cross reference this GaP database with SRA
      #Find what GaP studies exist in terms of their data types categorized in SRA

#Make a graph like this, this one has fake data:
test <-dat <- read.table(text = "A   B   C   D   E   F    G
 1 480 780 431 295 670 360  190
 2 720 350 377 255 340 615  345
 3 460 480 179 560  60 735 1260
 4 220 240 876 789 820 100   75", header = TRUE)
barplot(as.matrix(test), main="Car Distribution",horiz=TRUE,
           names.arg=c("3 Gears", "4 Gears", "5 Gears", "r","r","r","dew"))
