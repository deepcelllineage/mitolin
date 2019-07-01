#!/bin/bash
#$ -N gatk4c1_nguyen_nc_2018
#$ -ckpt restart
#$ -q som,pub64,free64,asom
#$ -pe make 2
#$ -t 1-10

## the final number, above, was set to process 10 samples (cells)

## load modules
# module load fastqc              # run qc separately to see if I need to trim
module load trimmomatic         # trim seqs
module load samtools            # fastq2sam
module load bwa                 # aligner
module load java/1.8            # allows picard-tools & gatk to work
module load picard-tools/1.96   # file rearrangement
module load gatk/4.0.0.0        # variant calling

## path to fastq files r1 & r2
## this is an absolute path on UCI's hpc
path1='/dfs3/som/dalawson/drb/data/nguyen_nc_2018_3/Ind2/kessenbrocklab_2/'

## assign lists of .fastq files
file1=${path1}r1_list_head.txt
file2=${path1}r2_list_head.txt

## use hpc sungrid-engine (SGE) task ID to create folder & file name variables 
name1=`head -n $SGE_TASK_ID $file1 | tail -n 1 | cut -f1`
name2=`head -n $SGE_TASK_ID $file2 | tail -n 1 | cut -f1`

## file extensions
read1='.r1.fastq'
read2='.r2.fastq'
samext='.sam'
bamext='.bam'
textext='.txt'
statext='.mh.chr_stat.txt'
astatext='.mh.all_stat.txt'
hstatext='.h.chr_stat.txt'
hastatext='.h.all_stat.txt'
table='.table'
ptable='.post.table'
vcfext='.raw_variants.vcf'

## file prefixes
reord='reordered_'
sort='sorted_'
real='realigned_'
mouse='mouse_removed_'
dup='duplicates_marked_'
filter='filtered_'
recal='recalibrated_'
proper='proper_'
unpair='unpaired_'

## bwa uses RGinfo to label things as normal or tumor
readgroupinfo='@RG\tID:EGA\tSM:'${name1}'\tPL:Illumina'


#########################################
## make subdirectory
## reassign path for subsequent commands
#########################################

## dirname = filename - .fastq subscript 
dir=${name1//.fastq/}

## make directory for each set of files
mkdir $path1$dir

## set path for file deposition
fwd='/'
path=$path1$dir$fwd

## copy each file into new folder
cp $path1$name1 $path$name1
cp $path1$name2 $path$name2


######################
## gatk best practice
######################

## align reads to hg19
bwa mem -M -t 32 -R $readgroupinfo \
    '/pub/kerrigab/hg19/hg19_ref.fasta' \
    $path$name1 $path$name2 \
    > $path$real$name1$samext

## filter out poor (<20) quality reads
samtools view -b -q 20 $path$real$name1$samext \
    > $path$filter$real$name1$samext

## create bam (from sam)
## -bS: ignore sequence quality lines in the header
samtools view -bS $path$filter$real$name1$samext \
    > $path$filter$real$name1$bamext

## sort bam file by coordinates
java -Xmx2g -jar /data/apps/picard-tools/1.96/SortSam.jar \
    I=$path$filter$real$name1$bamext \
    O=$path$sort$filter$real$name1$bamext \
    SORT_ORDER=coordinate

## reorder bam to match hg19                                                                                                                             
java -Xmx2g -jar /data/apps/picard-tools/1.96/ReorderSam.jar \
    I=$path$sort$filter$real$name1$bamext \
    O=$path$reord$sort$filter$real$name1$bamext \
    R=/pub/kerrigab/hg19/ucsc.hg19.fasta \
    CREATE_INDEX=TRUE

## annotate duplicates
java -Xmx2g -jar /data/apps/picard-tools/1.96/MarkDuplicates.jar \
    INPUT=$path$reord$sort$filter$real$name1$bamext \
    OUTPUT=$path$dup$reord$sort$filter$real$name1$bamext \
    METRICS_FILE=$path$dup$reord$sort$filter$real$name1$textext \
    REMOVE_DUPLICATES=FALSE \
    CREATE_INDEX=TRUE

## print all statistics in .txt
samtools stats $path$dup$reord$sort$filter$real$name1$bamext \
    > $path$dup$reord$sort$filter$real$name1$hastatext

## recalibrate base quality scores (BQS)
gatk BaseRecalibrator -R /pub/kerrigab/hg19/ucsc.hg19.fasta \
    --input $path$dup$reord$sort$filter$real$name1$bamext \
    --known-sites /pub/kerrigab/hg19/dbsnp_138.hg19.vcf \
    --known-sites /pub/kerrigab/hg19/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf \
    --output $path$dup$reord$sort$filter$real$name1$bamext$table

## apply recalibrated BQS
gatk ApplyBQSR -R /pub/kerrigab/hg19/ucsc.hg19.fasta \
    --input $path$dup$reord$sort$filter$real$name1$bamext \
    --bqsr-recal-file $path$dup$reord$sort$filter$real$name1$bamext$table \
    --output $path$recal$dup$reord$sort$filter$real$name1$bamext

## index bam file
samtools index $path$recal$dup$reord$sort$filter$real$name1$bamext

## call variants with MuTect2
## note: we need to make an appropriate panel of normals (pon)
## and add `--panel-of-normals /path/to/pon.vcf`
gatk Mutect2 -R /pub/kerrigab/hg19/ucsc.hg19.fasta \
    --dbsnp /pub/kerrigab/hg19/dbsnp_138.hg19.vcf \
    --input $path$recal$dup$reord$sort$filter$real$name1$bamext \
    --tumor-sample $name1 \
    --output $path$recal$dup$reord$sort$filter$real$name1$vcfext

## move copy of error file into file directory
dote='.e'
dot='.'
cp $JOB_NAME$dote$JOB_ID$dot$SGE_TASK_ID $path


