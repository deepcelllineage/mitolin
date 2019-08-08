#!/bin/bash
#$ -N fastq2abam
#$ -ckpt restart
#$ -q som,pub64,free64,asom
#$ -pe make 64
#$ -t 1-10

## load modules
module load java/1.8.0.111      # language of gatk & picard-tools
module load gatk/4.1.2.0        # includes picard tools
module load bwa/0.7.8           # aligner

## path 