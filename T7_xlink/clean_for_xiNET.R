# Clean data for xiNET
# Simone Ritchey for Marcotte lab

## Do First ####################################################################

# Load Libraries
  library(reticulate)

# Set working directory
  setwd("/Users/simone/Documents/UT/marcotte/T7_xlink")

# Load data
  xlink <- read.csv("2021_08_17_T7_DSSO_Crosslinks.csv")

################################################################################

# Removing unwanted columns
  xlink <- xlink[,c(3,10,11,14,15)]

# Changing column names
  colnames(xlink) <- c("Score","Protein1","LinkPos1","Protein2","LinkPos2")

# Giving xlink fasta names
  
  
  