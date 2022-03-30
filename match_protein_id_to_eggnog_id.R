# Matching protein

# Load elute file
library(readr)
setwd("/Volumes/Marcotte/project/Simone/wheat_germ/run_msblender/results/40_70_group_files")
elute_file <- read.delim("wheat_Germ_0_40_.prot_count_mFDRpsm001.group.unique.elut", sep="\t", header=T)

# Load mapping file and remove 
setwd("//Volumes/Marcotte/project/Simone/wheat_germ/eggNOG")
mapping_file <- read.delim("triticum_aestivum_35493.plantNOG.diamond.mapping", sep="\t", header=T)

# Make dictionary with Eggnog and protein ids
library(dplyr)
dictionary <- matrix(ncol=2)
colnames(dictionary) <- c("ProteinID","ID")
for (i in (1:length(mapping_file$ID))) {
  if (mapping_file$ID[i] %in% dictionary[,2]) {next}
  dictionary <- rbind(dictionary,mapping_file[i,])
}
dictionary <- dictionary[-1,]

# Add protein IDs to new elute file
proteinID <- rep(NA,length(elute_file[,1]))
new_elute_file <- cbind(proteinID, elute_file)
for (i in (1:length(dictionary$ProteinID))) {
  new_elute_file[dictionary$ID[i] == new_elute_file$X.ProtID,1] <- dictionary$ProteinID[i]
}

# Export new elute file
setwd("/Volumes/Marcotte/project/Simone/wheat_germ/run_msblender/results/40_70_group_files")
write.table(new_elute_file,"wheat_Germ_40_70_w_protein_ids.prot_count_mFDRpsm001.group.unique.elut", sep="\t")

# Edit format of protein ids to only have accession number
setwd("/Volumes/Marcotte/project/Simone/wheat_germ/run_msblender/results/0_40_group_files")
elute_file <- read.delim("wheat_Germ_0_40_w_protein_ids.prot_count_mFDRpsm001.group.unique.elut", sep="\t", header=T)
elute_file$X.ProtID <- gsub("tr\\|","",elute_file$X.ProtID)
elute_file$X.ProtID <- gsub("sp\\|","",elute_file$X.ProtID)
elute_file$X.ProtID <- gsub("\\|.*","",elute_file$X.ProtID)
elute_file <- elute_file[,-2]
names(elute_file)[names(elute_file) == "X.ProtID"] <- "#ProtID"
View(elute_file)

# Export to new elute file
setwd("/Volumes/Marcotte/project/Simone/wheat_germ/run_msblender/results/0_40_group_files")
write.table(elute_file,"wheat_Germ_0_40_w_protein_ids_fixed_wo_eggnog_ID_and_sp.prot_count_mFDRpsm001.group.unique.elut", sep="\t")

