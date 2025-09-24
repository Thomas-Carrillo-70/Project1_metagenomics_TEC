#!/bin/sh

#Take you to data file locations
data_loc="/home/carrilth/data/metagenomics/"
#save new file named step0_fastqc
out_loc="/home/carrilth/step0_fastqc"

#Makes a new directory, goes into memory (AKA defined variable above), and makes directory step0_fastqc
mkdir ${out_loc}

#take computer to where the data is 
cd ${data_loc}

#Start of for loop, and opens up sample list, is going to go through the list and assign each part of the list as i
for i in $(cat sampleList.txt); 
do 
  echo "Running sample ${i}..."
  #recalls fastqc script in the first part and runs it inide of raw_files directory with specific file that starts with variable and ends in variable_R1.fastq.gz
  ~/software/FastQC/fastqc --outdir ${out_loc} raw_files/${i}_R1.fastq.gz;
done

#this script is to perform fastqc (quality control) analysis on specific fastq.gz files 