#!/bin/sh

# location of metagenomics data
data_loc="/home/carrilth/data/metagenomics/"
#location where I want the output files to save
out_loc="/home/carrilth/step1_trimmed_files"
#file with a bunch of adapter references
adapter_references="/home/carrilth/software/bbmap/resources/adapters.fa"

#recalls memory of the out_loc variable which means that this command is making a new directory named step1_trimmed_files
mkdir ${out_loc}

#take computer to the location of the data
cd ${data_loc}

#Start of four loop that runs line by line, from top of document to bottom of document (cat)
for i in $(cat sampleList.txt);
do
#run the bbduke software 
  echo "Running sample ${i}..."
  #open up software
  ~/software/bbmap/bbduk.sh \
  in=raw_files/${i}_R1.fastq.gz \
  in2=raw_files/${i}_R2.fastq.gz \
  ref=${adapter_references} \
  out1=${out_loc}/${i}.trim.1.fq \
  out2=${out_loc}/${i}.trim.2.fq \
  ktrim=lr k=20 mink=4 minlen=20 qtrim=f \
  ftl=20 ftr=140 threads=1 overwrite=true
done