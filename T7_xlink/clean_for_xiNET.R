# Clean data for xiNET
# Simone Ritchey for Marcotte lab

## Do First ####################################################################

# Load libraries
  library(seqinr)
  library(dplyr)

# Set working directory
  setwd("/Users/simone/Documents/UT/marcotte/T7_xlink")

# Load data
  xlink <- read.csv("2021_08_17_T7_DSSO_Crosslinks.csv")
  fasta <- read.fasta("T7_phage_UP000000840_10760.fasta") %>% unlist()
    # Making fasta data frame
      fasta_dataframe <- data.frame(matrix(fasta, nrow = length(fasta), byrow = TRUE))
      
################################################################################

# Removing unwanted columns
  xlink <- xlink[,c(3,10,11,14,15)]

# Changing column names
  colnames(xlink) <- c("Score","Protein1","LinkPos1","Protein2","LinkPos2")

# Giving xlink fasta names
  xlink$Name <- sub("_","",watershed$SHORT_NAME)
  watershed2012 <- select(watershed, -contains("2011"))
    # I think using the contains is the key
  
  
  