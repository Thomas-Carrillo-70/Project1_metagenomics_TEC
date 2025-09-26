#!/bin/sh

#scan for genommes that would be present if there was contamincation in sample 

#location of data
data_loc="/home/carrilth/data/metagenomics/"
#location of trimmed reads performed in Step 1 script 
trim_read_loc="/home/carrilth/step1_trimmed_files"
#refers to adapter reference files to identify known adpater sequences
adapter_references="/home/carrilth/software/bbmap/resources/adapters.fa"
#output file for decontaminated files 
out_loc="/home/brunettt/step2_decontaminated_files"
#genomes of interest that might be present if there is contamination 
genome_1="/home/carrilth/data/reference_fasta_files_and_gtf_files/enterobacteria_phage_phiX174_GCF_000819615.1_genomic.fna" #phiX fasta
genome_2="/home/carrilth/data/reference_fasta_files_and_gtf_files/mm10.fa" #mouse fasta
genome_3="/home/carrilth/data/reference_fasta_files_and_gtf_files/GCF_000001405.39_GRCh38.p13_genomic_renamed.fa" #human fasta

#make directory for output file 
mkdir ${out_loc}

#take computer to data location 
cd ${data_loc}

#referes to sample list to pull up data specific file that need to be trimmed that have a specific number
for i in $(cat sampleList.txt);
do
  echo "Running sample ${i}..."
  #open up software for getting rid of contamination bbsplit, specific reads move through the code below and it trys to find reads that match with the contamination reference genomes
  ~/software/bbmap/bbsplit.sh in1=${trim_read_loc}/${i}.trim.1.fq \
  in2=${trim_read_loc}/${i}.trim.2.fq \
  ref=${genome_1},${genome_2},${genome_3} \
  outu1=${out_loc}/${i}.dedupe_reads.1.fq.gz \
  outu2=${out_loc}/${i}.dedupe_reads.2.fq.gz \
  threads=1 \
  -Xmx50g
done
