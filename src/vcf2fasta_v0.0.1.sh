#!/bin/bash
#$ -N 20190530_1005_gatk4_preprocess
#$ -ckpt restart
#$ -qsom,pub64,free64,asom
#$ -pe make 64
#$ -t 1

## load modules
module load gatk 

####################
## create variables
####################

## create path2raw_data variable

## create a list of file names
