#!/bin/sh

#Assemble the reads DE NOVO ASSEMBLY 

data_loc="/home/carrilth/step2_decontaminated_files"
out_loc="/home/carrilth/step4_assembiles"

mkdir ${out_loc}

cd ${data_loc}

for i in $(cat sampleList.txt); 
do 
  #Run MEGAHIT assembler
  echo "Running sample ${i}..."
  zcat ${data_loc}/${i}.dedupe_reads.1.fq.gz > read1.fastq
  zcat ${data_loc}/${i}.dedupe_reads.2.fq.gz > read2.fastq
  ~/software/MEGAHIT-1.2.9-Linux-x86_64-static/bin/megahit \
  -1 read1.fastq -2 read2.fastq \
  -o ${out_loc}/${i}_assemblies \
  -t 15 --presets meta-large
done

