# Wheat Germ MSC Identification

### Do First ###################################################################
# Set Working Directory
setwd("/Users/simone/Documents/UT/marcotte/Wheat Germ")

# Load Data
zerotoforty <- read.csv("WG_SEC_0_40.prot_count_mFDRpsm001 copy.csv")
fortytoseventy <- read.csv("WG_SEC_40_70.prot_count_mFDRpsm001 copy.csv")
histone_df <- read.csv("Wheat_Reviewed_Histones.csv")
tRNA_ligase_proteins <- read.csv("tRNA_ligases_from_uniport.csv")

# Load Packages
library(stringr)

################################################################################

# Search for MSC proteins in each fraction

  # Make vector containing all MSC protein Triticum Aestivum assension numbers
    MSC_proteins <- c("A0A3B6JG83","A0A3B6UB30","A0A3B6HWM1","A0A3B6QIY6","A0A3B6NVD8","A0A3B6PSV5","A0A3B6PST5","A0A3B6QIL7","A0A3B6QLZ3","A0A3B6IS75","A0A3B6JFS6","A0A3B6KRE7","A0A3B6LV87","A0A3B6NT35","A0A3B6NUU4","A0A3B6NSH2","A0A3B6MYA0","A0A3B6PLS2","A0A3B6NU06","A0A3B6QH08","A0A3B6QK64","A0A3B6NSW4","A0A3B6NT35","A0A3B6QK88","P30110","O04437","P30111","	Q9SP56","Q6U6G6","D8L9Q7","Q8LGN6","Q8LL15","A0A481S1J0","A0A481S1I8","A0A481S1N5","A0A3B6PPZ4","A0A3B6NUP9","A0A3B6PQN6","A0A3B6NVR1")

# Searching for MSC proteins in each sample and make dataset containing list

  # Zero to Forty
    zero_forty_MSC_proteins <- vector()
    for (i in (1:length(MSC_proteins))) {
      if (TRUE %in% str_detect(zerotoforty$X, MSC_proteins[i])) {
        zero_forty_MSC_proteins <- append(zero_forty_MSC_proteins, MSC_proteins[i])
      }
    }

  # Forty to Seventy
    forty_seventy_MSC_proteins <- vector()
    for (i in (1:length(MSC_proteins))) {
      if (TRUE %in% str_detect(fortytoseventy$X, MSC_proteins[i])) {
        forty_seventy_MSC_proteins <- append(forty_seventy_MSC_proteins, MSC_proteins[i])
      }
    }
    
# Looking for histones in each sample
    
    # Make vector of histone assesion numbers
    histones <- histone_df$Entry.name
  
    # Zero to Forty
    zero_forty_histone_proteins <- vector()
    for (i in (1:length(histones))) {
      if (TRUE %in% str_detect(zerotoforty$X, histones[i])) {
        zero_forty_histone_proteins <- append(zero_forty_histone_proteins, histones[i])
      }
    }
    
    # Forty to Seventy
    forty_seventy_histone_proteins <- vector()
    for (i in (1:length(histones))) {
      if (TRUE %in% str_detect(fortytoseventy$X, histones[i])) {
        forty_seventy_histone_proteins <- append(forty_seventy_histone_proteins, histones[i])
      }
    }  

# Looking for other tRNA ligases in each sample
    
    # Make vector of tRNA ligase assession numbers
    tRNA_ligases <- tRNA_ligase_proteins$Entry.name
 
    # Zero to Forty
    zero_forty_ligase_proteins <- vector()
    for (i in (1:length(tRNA_ligases))) {
      if (TRUE %in% str_detect(zerotoforty$X, tRNA_ligases[i])) {
        zero_forty_ligase_proteins <- append(zero_forty_ligase_proteins, tRNA_ligases[i])
      }
    }
    
    # Forty to Seventy
    forty_seventy_ligase_proteins <- vector()
    for (i in (1:length(tRNA_ligases))) {
      if (TRUE %in% str_detect(fortytoseventy$X, tRNA_ligases[i])) {
        forty_seventy_ligase_proteins <- append(forty_seventy_ligase_proteins, tRNA_ligases[i])
      }
    }  

# Identifying tRNA ligases in each sample 
    
    # Zero to Forty
    zero_forty_ligase_proteins_with_names <- tRNA_ligase_proteins[tRNA_ligase_proteins$Entry.name %in% zero_forty_ligase_proteins,] %>% subset(select = c("Entry.name","Protein.names"))
    
    # Forty to Seventy
    forty_seventy_ligase_proteins_with_names <- tRNA_ligase_proteins[tRNA_ligase_proteins$Entry.name %in% forty_seventy_ligase_proteins,] %>% subset(select = c("Entry.name","Protein.names"))
    