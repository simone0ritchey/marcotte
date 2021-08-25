# Clean data for xiNET
# Simone Ritchey for Marcotte lab

## Do First ####################################################################

# Load libraries
  library(seqinr)
  library(dplyr)
  library(stringr)

# Set working directory
  setwd("/Users/simone/Documents/UT/marcotte/T7_xlink")

# Load data
  xlink <- read.csv("2021_08_17_T7_DSSO_Crosslinks.csv")
  fasta <- read.fasta("T7_phage_UP000000840_10760.fasta") %>% unlist()
  
# Making seq_length_tbl function from https://rdrr.io/github/seankross/warppipe/src/R/seq_length_tbl.R
  seq_length_tbl <- function(path, description = "^>", comment = "^;"){
        # Read fasta file
        fasta_file <- readLines(path)
        
        # Trim whitespace
        fasta_file <- str_trim(fasta_file)
        
        # Remove comment lines
        if(any(grepl(comment, fasta_file))){
          fasta_file <- fasta_file[-grep(comment, fasta_file)]
        }
        
        # Find lines with descriptions
        description_lines <- grep(description, fasta_file)
        
        sections <- list()
        
        # Set last description "fencepost" as the last line plus 1
        fencepost_lines <- c(description_lines, length(fasta_file) + 1)
        
        for(i in 1:(length(fencepost_lines) - 1)){
          sections[[i]] <- seq(fencepost_lines[i] + 1, fencepost_lines[i + 1] - 1)
        }
        
        len <- lapply(sections, 
                      function(x, file = fasta_file){
                        sum(str_length(file[x]))
                      })
        len <- unlist(len)
        
        # Create data frame
        data.frame(Description = sub(description, "", fasta_file[description_lines]),
                   sequence_length = len)
      }
      
      
################################################################################

# Removing unwanted columns
  xlink <- xlink[,c(3,10,11,14,15)]

# Changing column names
  colnames(xlink) <- c("Score","Protein1","LinkPos1","Protein2","LinkPos2")

# Giving xlink fasta names
  xlink$Name <- sub("_","",watershed$SHORT_NAME)
  watershed2012 <- select(watershed, -contains("2011"))
    # I think using the contains is the key
  fasta_dataframe <- seq_length_tbl("/Users/simone/Documents/UT/marcotte/T7_xlink/T7_phage_UP000000840_10760.fasta")
  
  