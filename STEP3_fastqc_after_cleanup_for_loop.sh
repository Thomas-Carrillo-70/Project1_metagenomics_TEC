#!/bin/sh

#repeat of step 0 to quality control final cleaned files

#datalocation 
data_loc="/home/brunettt/carrilth/metagenomics"
#where I want output 
out_loc="/home/carrilth/step3_fastqc_after_cleanup"

#make directory for output location 
mkdir ${out_loc}

#take me to data location, me being the computer 
cd ${data_loc}

#run loop to recall files that start with a certain number present on each line of sampleList.txt
for i in $(cat sampleList.txt); 
do 
  echo "Running sample ${i}..."
  #recalls fastqc script in the first part and runs it inide of raw_files directory with specific file that starts with variable and ends in variable_R1.fastq.gz
  ~/software/FastQC/fastqc --outdir ${out_loc} /home/carrilth/step2_decontaminated_files/${i}.dedupe_reads.1.fq.gz
done



