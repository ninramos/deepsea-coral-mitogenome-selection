# Depth-adapted gene discovery of deep-sea corals

This repository contains supporting data and workflow for assessing positive selection in deep- and shallow- water species of corals. 
The data and workflow provided within this repository are consistent with research project: 

Ramos, N. I., DeLeo, D. M., McFadden, C. S. Quattrini, A. M. (2021). *Depth-adapted gene discovery in deep-sea corals.* [[Poster presentation]](https://naturalhistory.si.edu/sites/default/files/media/file/nramosnhreposterfinaluploadblocked.pdf). NMNH NHRE Research Symposium. 


---
## You will need the following programs downloaded to complete this analysis 

- [Iqtree](http://www.iqtree.org) to create Maximum-likelihood tree
- [Mitos2](http://mitos2.bioinf.uni-leipzig.de/index.py) to annotate sequences
- [MAFFT](https://mafft.cbrc.jp/alignment/software/) to align sequences
- [codeml](http://abacus.gene.ucl.ac.uk/software/paml.html) for positive selection analysis 


--- 
## 1. Data Collection and Preparation

**Download coral mitogenome data from GenBank** 
> List of accession IDs used in this study can be found in Supplementary Info Table S1. 

**Annotate mitogenomes to identify protein-coding genes** 

> Mitogenomes annotated using [Mitos2](http://mitos2.bioinf.uni-leipzig.de/index.py) to identify protein coding genes, tRNAs, and rRNAs
> - reference NCBI RefSeq 89 Metazoa 
> - genetic code 5 (invertebrate)

**Align protein-coding genes separately with MAFFT**

> - L-INS-I method 

**Phylogenetic Trees**

- Create a species tree for all of the sequences in alignment using IQtree

	`iqtree2 -s filename.phy -m GTR+G -bb 1000` 
	> to run with the GTR+G model 
	`iqtree2 -s filename.phy -m 

- can add `rcluster10` for relaxed clustering to speed up computation (means only top 10% partitiion schemes are considered to save computations) 
- `-bb 1000` to specify number of bootstrap replicates

IQtree will produce three outfiles: 

- **filename.phy.treefile** is the maximum-likelihood tree in NEWICK format which can be visualized by Figtree, and what you will need to run codeml

4.2 Unroot tree

- **Script_to_unroot_tree.R**

4.3 Remove extra support values from unrooted tree if needed (R) 

- **Script_clean_unrooted_tree.R**

**Labeling unrooted species tree** 

- Some models for codeml require specied branches on the species tree to be labeled for analysis. This allows separate ω's to be generated through different parameters of interest being assigned among the branches. 
- For this project, both *Branch models* and *Branch-site models* required the species tree to be labeled. We defined the foreground branch as deep-water species and background branch as shallow-water species. 
- To label unrooted species tree in newick format: 
	- label foreground branches with a `#1` inserted after the name/ID but before the semicolon and support value 
	- example: `Camptaug#1:0.077304,Ausvul#1:0.071029`

For more information on how to run IQtree: [Begginer's tuturial](http://www.iqtree.org/doc/Tutorial#choosing-the-right-substitution-model)

---
## Running codeml 

[PAML Manual](http://abacus.gene.ucl.ac.uk/software/pamlDOC.pdf)

**Files needed to run Codeml** 

- Control File 
- Unrooted species tree in newick format
- Sequence file in PHYLIP format

**To create control file using scripts** 

1. 	Download perl scripts from "Create Control Files" 


2. 	Create a list of the alignment files that you wish to run for these models. 

	- if all of the files end in the same extentions `ls *.phy > phylist.txt 
	- make sure that the names/ids in file match the names on the tree 

3. 	Create a list of the corresponding species tree file name 


	- this list will repeat the treefile name as many times as there are alignments that are going to be tested
	- (i.e.) if you have 15 alignments to run and create control files for, list the species tree filename 15 times 
	- `seq 15 | awk '{print "SpeciesTree_Unrooted.tree"}' > treelist.txt`

4. 	Run perl scripts below to create the control files for each model 


	- **CODEML_TREE_ALN_ALT.pl**:creates control file for alternative model (Model A) 

	- **CODEML_TREE_ALN_NULL.pl**:creates control file for null model 
	
	- **Note:** These perl scripts specify for the invertebrate genetic code `icode = 4` 
	
	
5.	Edit scripts to create control files for other models by modifying the line in CODEML_TREE_ALN_ALT.pl that you are changing the paramenter for. 

	**"one-ratio" (M0)** 
	
	- model = 0; modify the line `system("echo model = 2 >> $a_files[$i].ctl");` to `system("echo model = 0 >> $a_files[$i].ctl");`
	- NSsites = 0; modify the line `system("echo NSsites = 2 >> $a_files[$i].ctl");` to `system("echo NSsites = 0 >> $a_files[$i].ctl");`
	
	**"two-ratios" (M2)** 
	
	- model = 2; keep line the same 
	- NSsites = 0; modify the line `system("echo NSsites = 2 >> $a_files[$i].ctl");` to `system("echo NSsites = 0 >> $a_files[$i].ctl");`


**Run CODEML using perl script**

1. Download perl script  **CODEML_CTL_RUN.pl** 

2. Change the line, `system("/YOUR_PATH/codeml/paml4.9d/bin/codeml /YOUR_PATH/MCL_CTL_Files/$ctl_files[$i]\n");` to include the path to Codeml on your computer.

3. Make sure species tree is labeled and names/IDs match with those in the phylip files

4. Make a list of the control files that you are planning to run `cat *.ctl > MCL_ALT_list.ctl cat *.ctl > MCL_NULL_list.ctl` 

5. Run as `perl CODEML_CTL_RUN.pl MCL_ALT_list.ctl` 
