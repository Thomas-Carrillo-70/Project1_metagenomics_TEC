#!/bin/sh

# This script will create a single merged fasta file for 1 sample that contains
# all evidence-level 4 spacer sequences with unique fasta headers
# This needs to be run 4 times, because we have 4 samples

sample_name="9"
data_loc="/home/carrilth/CRISPR_arrays/9_arrays"
num_fasta_splits=5

cd ${data_loc}

for x in $(seq 1 ${num_fasta_splits});
do
  echo "Running sample name ${sample_name} on fasta split ${x}..."
  # change directories into one of the fasta splits for the sample
  cd ${sample_name}_contigs.10k.part_00${x}.fa/
  # grab the name of the Result folder output from CRISPRCasFinder
  result_folder_name=$(ls -d Result*)
  # grab each line with high quality CRISPR spacers and then only grab the 1st column containing the IDs and save it
  grep "evidence-level=4" ${result_folder_name}/TSV/CRISPR-Cas_summary.tsv | cut -f1 > level4.IDs.txt
  # merge each GFF file from these high quality arrays
  for i in $(cat level4.IDs.txt);
  do
    cat ${result_folder_name}/GFF/${i}.gff >> level4.gff;
  done
  # grab only the spacer lines
  grep "CRISPRspacer" level4.gff > level4.spacersOnly.gff
  # make an intermediate files with only the IDs
  cut -f1 level4.spacersOnly.gff > tempID.txt
  # make an intermediate file with only the spacer sequences in the same order as the spacer name above
  # defines deliminators as "=" and ";" to extract sequence for each GFF with a spacer 
  cut -f9 level4.spacersOnly.gff | cut -f2 -d "=" | cut -f1 -d ";" > tempSeq.txt
  # merged them together through a horizontal merge
  paste tempID.txt tempSeq.txt > tempCombined.txt
  # covert to fasta and rename sequences to have unique header names
  ~/software/seqkit tab2fx tempCombined.txt | ~/software/seqkit rename -1 > ../level4.spacers.${x}.fna
  # clean up intermediate files
  rm level4.IDs.txt
  rm level4.gff
  rm level4.spacersOnly.gff
  rm tempID.txt
  rm tempCombined.txt
  # move back to the main level directory in prepartion for the next fasta split
  cd ../
done

# after all fasta parts are complete merge them into one sample fasta
cat level4.spacers.*.fna > ${sample_name}_level4.spacers.all.fna

# clean up intermediate files
rm level4.spacers.*.fna