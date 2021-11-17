# Wheat Germ MCS Protein Abundance Comparison Between Fractions

### Do First ###################################################################

# Set Working Directory
  setwd("/Users/simone/Documents/UT/marcotte/Wheat Germ")

# Load Data
  zerotoforty <- read.csv("2021_09_27_WG_0_40_Proteins.csv")
  fortytoseventy <- read.csv("2021_09_27_WG_40_70_Proteins.csv")

# Load Packages
  library(dplyr)
################################################################################

# Make vector containing all MSC protein Triticum Aestivum assension numbers
  MSC_proteins <- c("A0A3B6JG83","A0A3B6UB30","A0A3B6HWM1","A0A3B6QIY6","A0A3B6NVD8","A0A3B6PSV5","A0A3B6PST5","A0A3B6QIL7","A0A3B6QLZ3","A0A3B6IS75","A0A3B6JFS6","A0A3B6KRE7","A0A3B6LV87","A0A3B6NT35","A0A3B6NUU4","A0A3B6NSH2","A0A3B6MYA0","A0A3B6PLS2","A0A3B6NU06","A0A3B6QH08","A0A3B6QK64","A0A3B6NSW4","A0A3B6NT35","A0A3B6QK88","P30110","O04437","P30111","	Q9SP56","Q6U6G6","D8L9Q7","Q8LGN6","Q8LL15","A0A481S1J0","A0A481S1I8","A0A481S1N5","A0A3B6PPZ4","A0A3B6NUP9","A0A3B6PQN6","A0A3B6NVR1")

  # Adding tRNA ligase proteins exported from uniprot and removing repeats
    tRNA__ligase_proteins <- read.csv("tRNA_ligases_from_uniport.csv")
    MSC_proteins <- MSC_proteins %>% append(tRNA__ligase_proteins$Entry) %>% unique()

# Searching for MSC proteins in each fraction and compare abundances
    
  zero_forty_MSC_proteins <- zerotoforty[zerotoforty$Accession %in% MSC_proteins,] %>% subset(select = c("Accession","Description","Number.of.PSMs"))
  forty_seventy_MSC_proteins <- fortytoseventy[fortytoseventy$Accession %in% MSC_proteins,] %>% subset(select = c("Accession","Description","Number.of.PSMs"))


  

