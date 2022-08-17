##Load the library picante needed to unroot the tree
library(picante)

## Read in tree file
tr <- read.tree("SpeciesTree_rooted.txt")

# Unroot the tree and save as a new variable
unrooted_tr <- unroot(tr)

## Write new unrooted tree file
write.tree(unrooted_tr, "SpeciesTree_unrooted.tree")
