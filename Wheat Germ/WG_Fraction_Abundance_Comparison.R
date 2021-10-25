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

# Test to see if this is the function I want to use
  zerotoforty_test <- zerotoforty$Description %>% 
    select(contains(1))

# What are these things related to tRNA ligase

