# Run FARM

Navigate to my cloned gatk repo
`cd Documents/work/lawson_lab/gatk/`

Activate my environment (which has R in it, but nothing else)
`conda activate gatk`

## Run FARM on a vcf using the ref from bundle 37

```
./gatk FastaAlternateReferenceMaker \
        -O /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/data/generated/20190613-fastas/1457-1sttry.fa \
        -R /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.fasta.gz \
        -V /Users/drb/Documents/work/lawson_lab/data/nguyen_nc_2018/20190502_output/Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.gz/recalibrated_duplicates_marked_reordered_sorted_filtered_realigned_Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.fastq.gz.raw_variants.vcf 

```

-O = output
-R = reference
-V = vcf file

## output

Using GATK jar /Users/drb/Documents/work/lawson_lab/gatk/build/libs/gatk-package-4.1.2.0-25-gd0d4ca7-SNAPSHOT-local.jar
Running:
    java -Dsamjdk.use_async_io_read_samtools=false -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Dsamjdk.compression_level=2 -jar /Users/drb/Documents/work/lawson_lab/gatk/build/libs/gatk-package-4.1.2.0-25-gd0d4ca7-SNAPSHOT-local.jar FastaAlternateReferenceMaker -O /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/data/generated/20190613-fastas/1457-1sttry.fa -R /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.fasta.gz -V /Users/drb/Documents/work/lawson_lab/data/nguyen_nc_2018/20190502_output/Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.gz/recalibrated_duplicates_marked_reordered_sorted_filtered_realigned_Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.fastq.gz.raw_variants.vcf

15:12:28.055 INFO  NativeLibraryLoader - Loading libgkl_compression.dylib from jar:file:/Users/drb/Documents/work/lawson_lab/gatk/build/libs/gatk-package-4.1.2.0-25-gd0d4ca7-SNAPSHOT-local.jar!/com/intel/gkl/native/libgkl_compression.dylib
Jun 13, 2019 3:12:29 PM shaded.cloud_nio.com.google.auth.oauth2.ComputeEngineCredentials runningOnComputeEngine
INFO: Failed to detect whether we are running on Google Compute Engine.

A USER ERROR has occurred: Fasta index file 
file:///Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.fasta.gz.fai 
for reference 
file:///Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.fasta.gz does not exist. 

Please see http://gatkforums.broadinstitute.org/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference for help creating it.

## try ...

I added the .fasta.fai.gz file from the bundle (v37) to the same directory as the fasta.gz file 
- ^ this did not work

`mv human_g1k_v37.fasta.fai.gz human_g1k_v37.fasta.gz.fai` 
- new error

Fasta dict file file:///Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.dict 
for reference file:///Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.fasta.gz does not exist.

I added the human_g1k_v37.dict.gz file from the bundle (v37) to the same directory as the fasta.gz file

run again, same error as above
rename

`mv human_g1k_v37.dict.gz human_g1k_v37.gz.dict`

run again, same error as above, 
rename

`mv human_g1k_v37.gz.dict human_g1k_v37.dict`

A USER ERROR has occurred: 
Couldn't read file file:///Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.fasta.gz. 
Error was: Found invalid line in index file(�Rhuman_g1k_v37.fasta.fai]VK��6
                                              [k3����$�,��_$ewE�t��`	Aʼ�Z�Bx����K�P�[S��Y�>k���ZN����֘�$c%m�S>k����?�C���Y���x�"vw֟�ț�"p�`s.5{k������ �N�G�

I think I need to unzip all of them!

use gunzip to unzip the files and use -k to keep the zipped file

e.g.
`gunzip -k human_g1k_v37.fasta.gz`

## Run FARM again without .gz after reference file

```
./gatk FastaAlternateReferenceMaker \
        -O /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/data/generated/20190613-fastas/1457-1sttry.fa \
        -R /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/human_g1k_v37.fasta \
        -V /Users/drb/Documents/work/lawson_lab/data/nguyen_nc_2018/20190502_output/Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.gz/recalibrated_duplicates_marked_reordered_sorted_filtered_realigned_Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.fastq.gz.raw_variants.vcf 

```


A USER ERROR has occurred: Input files reference and features have incompatible contigs: No overlapping contigs found.

This is because I'm using the reference from the bundle, but the reference that I used to generate the vcf was a different one

## can I download the ref, dict & fai that was used to make the vcf? 

1. Which reference did I use? 
    - /pub/kerrigab/hg19/hg19_ref.fasta
    - is there a dict & fai file in the same directory?
    - use FTP
    - hum.. there is no dict
    - maybe the ref that I need is: /pub/kerrigab/hg19/ucsc.hg19.fasta
    - there is a dict for this one
    - transfer it to my ref directory (it took about 30 minutes to transfer the unzipped fasta, which was 3 GB)
      - to copy the unzipped file from one place on hpc to another only took ~2 minutes
    - I should have made compressed files using `gzip FILENAME.EXT`


## Run FARM again with ucsc.hg19.fasta

```
./gatk FastaAlternateReferenceMaker \
        -O /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/data/generated/20190613-fastas/1457-1sttry.fa \
        -R /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/downloads/ref/ucsc.hg19.fasta \
        -V /Users/drb/Documents/work/lawson_lab/data/nguyen_nc_2018/20190502_output/Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.gz/recalibrated_duplicates_marked_reordered_sorted_filtered_realigned_Basal-1-2016-A10_CGAGGCTG-GCGTAAGA_L008_R1_001.fastq.gz.raw_variants.vcf 

```

It's working!!! =)

Note it took about 14 minutes for one vcf file to be turned into a fasta.

## look at the output

`cd /Users/drb/Documents/work/lawson_lab/deepcelllineage/mitolin/data/generated/20190613-fastas`

`ls -l`

output
```
-rw-r--r--  1 drb  staff        5247 Jun 13 17:03 1457-1sttry.dict
-rw-r--r--  1 drb  staff  3189452975 Jun 13 17:03 1457-1sttry.fa
-rw-r--r--  1 drb  staff        2522 Jun 13 17:03 1457-1sttry.fa.fai
```

Note that the .fa (aka the fasta file) is 3 GBs! So I don't want to open it!!

Let's look at it

First, how many lines does it have?
`wc -l 1457-1sttry.fa`
- 52,286,210 
- just 52 million!!!

What do the first 10 lines look like?
`head 1457-1sttry.fa`

```
>1 chrM:1-16571
GATCACAGGTCTATCACCCTATTAACCACTCACGGGAGCTCTCCATGCATTTGGTATTTT
CGTCTGGGGGGTGTGCACGCGATAGCATTGCGAGACGCTGGAGCCGGAGCACCCTATGTC
GCAGTATCTGTCTTTGATTCCTGCCTCATCCTATTATTTATCGCACCTACGTTCAATATT
ACAGGCGAACATACTTACTAAAGTGTGTTAATTAATTAATGCTTGTAGGACATAATAATA
ACAATTGAATGTCTGCACAGCCGCTTTCCACACAGACATCATAACAAAAAATTTCCACCA
AACCCCCCCCCCCCCCCCCCTGGCCACAGCACTTAAACACATCTCTGCCAAACCCCAAAA
ACAAAGAACCCTAACACCAGCCTAACCAGACCCATGTACTCTTTCAAATTTTATCTTTAG
GCGGTATGCACTTTTAACAGTCACCCCCCAACTAACACATTATTTTCCCCTCCCACTCCC
ATACTACTAATCTCATCAATACAACCCCACCCATCCTACCCAGCACACACACACCGCTGC
```


## To Do Next

1. Reduce output file size: 
   - reduce file length by removing all characters after chrM
     - chrM is 16571 nts long
     - use find to show the line before and after `>`
     - `>2 chr1:...`
     - cut before `>2`
2. Reduct input file sizes & thus processing time
   - delete everything after chrM in the vcf file and the reference: fa, fai, and dict files



