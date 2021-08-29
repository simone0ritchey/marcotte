### Clean data for xiNET
### Simone Ritchey for Marcotte lab

# Load packages
  library(stringr)

# Load xlink data
  setwd("/Users/simone/Documents/UT/marcotte/T7_xlink")
  xlink <- read.csv("2021_08_17_T7_DSSO_Crosslinks.csv")
  
# Removing unwanted columns
  xlink <- xlink[,c(3,10,11,14,15)]
  
# Changing column names
  colnames(xlink) <- c("Score","Protein1","LinkPos1","Protein2","LinkPos2")
  
# Making seq_length_tbl function modified from https://rdrr.io/github/seankross/warppipe/src/R/seq_length_tbl.R
  seq_length_tbl_mod <- function(path, description = "^>", comment = "^;"){
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
    fasta_name <- gsub(" .*","",fasta_name)
    
    xlink_name <- gsub("sp\\|","",fasta_name)
    xlink_name <- gsub("\\|.*","",xlink_name)
      
    # delete everything after bracket
    
    # Create data frame
    data.frame(fasta_name = fasta_name,
               xlink_name = xlink_name)
  }
  
# Making data frame from fasta file containing fasta name and xlink name
  name_bridge <- seq_length_tbl_mod("/Users/simone/Documents/UT/marcotte/T7_xlink/T7_phage_UP000000840_10760.fasta")
  
# Giving xlink data frame fasta names
  # It says there are no matches between Protein1 and fasta_name
  xlink$Protein1 <- name_bridge$fasta_name[match(xlink$Protein1, name_bridge$xlink_name)]
  xlink$Protein2 <- name_bridge$fasta_name[match(xlink$Protein2, name_bridge$xlink_name)]
  
# Looking for where I fudged up w/ the modification
  
  seq_length_tbl_mod <- function(path, description = "^>", comment = "^;"){
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
    
  # Putting this back because I deleted it when I modified the function, maybe it is important
    len <- lapply(sections, 
                  function(x, file = fasta_file){
                    sum(str_length(file[x]))
                  })
    len <- unlist(len)
    
  # Remove "^>" from fasta name  
    fasta_name <- sub(description, "", fasta_file[description_lines])
  # Remove everything after the space in the fasta name
    fasta_name <- gsub(" .*","",fasta_name)
    
    xlink_name <- gsub("sp\\|","",fasta_name)
    xlink_name <- gsub("\\|.*","",xlink_name)
    
    # delete everything after bracket
    
    # Create data frame
    data.frame(fasta_name = fasta_name,
               xlink_name = xlink_name)
  }
  
  solution_check <- seq_length_tbl_mod("/Users/simone/Documents/UT/marcotte/T7_xlink/T7_phage_UP000000840_10760.fasta")  
  