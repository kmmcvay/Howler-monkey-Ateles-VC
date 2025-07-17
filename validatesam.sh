#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p goldberg,common-old
#SBATCH --mem=20GB

cd /work/kmm105/spider_assembly

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

BAMS=/datacommons/goldberg/lab_datasets/howlers/spider_assembly/bams/*dedupRG.bam
for BAM in $BAMS
do 
	gatk ValidateSamFile I=$BAM MODE=SUMMARY
done
