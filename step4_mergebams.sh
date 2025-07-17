#!/bin/bash
#SBATCH --mem-per-cpu=12GB -c 2
#SBATCH -p goldberg,common-old
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

cd /work/kmm105/spider_assembly/bams

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

while read sample;
do
	bamlist=$(for f in /work/kmm105/spider_assembly/bams/"$sample"*.bam; do echo -n "I=$f " ; done)
	gatk --java-options "-Xmx16G" MergeSamFiles $bamlist O="$sample"_merged.bam USE_THREADING=true
done < /work/kmm105/spider_assembly/Alouatta_SA_list.txt
