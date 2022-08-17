##Script to remove extra support values from an unrooted tree 

##Create a new variable that reads unrooted tree 
pamltree=read.tree("insert_path_to_treefile") 

##Removes support values 
pamltree$node.label=NULL 

##Creates new tree with removed support values 
write.tree(pamltree)
