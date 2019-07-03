#!/bin/bash
#$ -N DB20190703_1200_gatk4_createseqdict
#$ -ckpt restart
#$ -q som,pub64,free64,asom
#$ -pe make 64
#$ -t 1-10

## load modules
module load gatk 

####################
## create variables
####################

## create path2fasta data variable
path2fasta='/dfs3/som/dalawson/drb/deepcelllineage/mitolin/data/gen/nguyen_nc_2018/20190702-fastas-on-hpc/1739/20lines/'

## create variable for list of fasta filenames
filenamelist=${path2fasta}fasta_list.txt

## create a name with fasta extension variable
namewfastaext=`head -n $SGE_TASK_ID $filenamelist | tail -n 1 | cut -f1`

## remove the fastaext from name
name=${namewfastaext%.fasta}

## create output path
path2output=$path2fasta

## create filename extension variable(s)
dictext='.dict'

## create path to reference fasta
path2ref='/dfs3/som/dalawson/drb/deepcelllineage/mitolin/data/ref/ucsc/bundles/hg19/'

## assign reference fasta filename to a variable
ref='ucsc.hg19.fasta'

####################################
## Run CreateSequenceDictionary
####################################

## run CreateSequenceDictionary
java -jar picard.jar CreateSequenceDictionary \   
    -R=$path2ref$ref \     
    -O=${path2output}${name}.dict

## be sure to run the file from a directory called `erroroutput/
## so e & o files get deposited in an ignored folder

## hpc job instructions
# to run this script: `qsub filename.sh`
# to check on the script's status: `qstat -u dalawson`
# to stop a submitted project by job-ID number: `qdel job-ID-number`
