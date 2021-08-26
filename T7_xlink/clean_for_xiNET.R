### Clean data for xiNET
### Simone Ritchey for Marcotte lab

# Load xlink data
  setwd("/Users/simone/Documents/UT/marcotte/T7_xlink")
  xlink <- read.csv("2021_08_17_T7_DSSO_Crosslinks.csv")
  
# Removing unwanted columns
  xlink <- xlink[,c(3,10,11,14,15)]
  
# Changing column names
  colnames(xlink) <- c("Score","Protein1","LinkPos1","Protein2","LinkPos2")
  
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
    
    fasta_name <- sub(description, "", fasta_file[description_lines])
      # Remove everything after " "
        xlink_name <- gsub("\\ .*","",fasta_name)
      # idk
        xlink_name <- gsub("\\P.*","",fasta_name)
    # Create data frame
    data.frame(fasta_name = fasta_name,
               xlink_name = xlink_name)
  }
  
# Making data frame from fasta file
  fasta <- seq_length_tbl("/Users/simone/Documents/UT/marcotte/T7_xlink/T7_phage_UP000000840_10760.fasta")
  
# Giving xlink data fasta names
  # I think mutate() contains() is key
  
  # Remove part after BPT7
  fasta$Description <- gsub("\\ .*","",fasta$Description)
  
  
  