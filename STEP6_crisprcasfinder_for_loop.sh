#!/bin/sh

data_loc="/home/carrilth/Project1_metagenomics_TEC/Step5_conitig_clearnup_and_formatting/2_contigs.10kb.fa.split"

cd ${data_loc}

ls -1 2contigs.10kb.fa.split > ~/Project1_metagenomics_TEC/Step5_conitig_clearnup_and_formatting/2_contigs_splitfiles.txt

for i in $(cat split_files.txt); 
do 
  echo "Running sample ${i}..."
  mkdir ${i}
  cd ${i}
  perl ~/software/CRISPRCasFinder-release-4.2.21/CRISPRCasFinder.pl \
  -in ../${i} \
  -metagenome -log -so ~/software/CRISPRCasFinder-release-4.2.21/sel392v2.so \
  -levelMin3 &
  # "&" this sign allows for the loop to be ran in parrellel, it allows the loop to go through all the fasta files amongst the split files mentioned in STEP 5 and runs all the fasta files inside of the split directory at once this allows for parellelzation 
  # the loop is automated because it runs teh script through a file, but would not be parellel without the "&" sign 
done

# this script is running the 6 file fasta files inside of 2_contigs.10kb.fa.split at the same time for the CRISPRCasFinder script
wait
