# Howler-monkey-Ateles-VC
Mapping and variant calling of howler monkey WGS to Ateles geoffroyi reference genome

## Mapping
### Step 1: UBAM
Create unaligned bam from forward and reverse reads for each lane per individual

Function: gatk FastqToSam

### Step 2: Mark Adapters
Mark Illumina adapters from ubam file

Function: gatk MarkIlluminaAdapters

### Step 3: Map
Multiple step script - convert back to FASTQ with adapters clipped, map to reference with BWA-mem, merge mapped bam and ubam to preserve metadata

Functions: gatk SamToFastq, BWA mem, gatk MergeBamAlignment

### Step 4: Merge
Merge across lanes for each individual

Function: gatk MergeSamFiles

### Step 5: Sort and Mark Duplicates
Multiple step script - coordinate sort bam and mark duplicates

Functions: gatk SortSam, gatk MarkDuplicates

### Step 6: Rename read groups
Rename read groups to show single individual label - required for HaplotypeCaller

Function: gatk AddOrReplaceReadGroups

### End of Mapping - save/archive bams and index files at this stage, run additional statistics (average depth, percent mapping, file validation)
Scripts: samtools_mapstats.sh (samtools flagstat and depth), samtools_collectstats.sh, validatesam.sh (gatk ValidateSamFile)

## Variant Calling
### Step 7: Single individual per contig VC
Call SNPs and indels per individual per contig set

Function: gatk HaplotypeCaller

### Step 8: Per contig genomic database
Create GenomicDB per contig set including all individuals

Function: gatk GenomicsDBImport

### Step 9: Joint genotyping
Run joint genotyping from database per contig set

Function: gatk GenotypeGVCFs

### Step 10: Hard filtering
Apply hard filtering thresholds to each contig set VCF (SNPs only, QD < 2.0 || FS > 60.0 || SOR > 3.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0)

Functions: gatk SelectVariants, gatk VariantFiltration

### Step 11: Concatenating VCFs
Vertically merge contig set VCFs into single, hard filtered, all contigs and all individuals final VCF and index

Function: bcftools concat, tabix

### Package Versions:
gatk 4.4.0.0

java 17.0.7

bwa 0.7.17

samtools 1.11

bcftools 1.14

tabix 1.14
