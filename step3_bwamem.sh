#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p scavenger

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

cd /work/kmm105/spider_assembly/step3scripts

BAMs=/work/kmm105/spider_assembly/ubam/*_markadapters.bam
for BAM in $BAMs
do
        name="$(echo ${BAM} | grep -oP '.*(?=_markadapters.bam)' | awk -F'[/]' '{print $6}')"
        echo "working on $name"
        FILE="$name"_runStep3.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem-per-cpu=6GB -c 4" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
	echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "cd /work/kmm105/spider_assembly/bams" >> $FILE
        echo "gatk --java-options "-Xmx8G" SamToFastq \\" >> $FILE
        echo "I=$BAM \\" >> $FILE
        echo "FASTQ=/dev/stdout \\" >> $FILE
        echo "CLIPPING_ATTRIBUTE=XT CLIPPING_ACTION=2 INTERLEAVE=true NON_PF=true \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp | \\" >> $FILE
        echo "/opt/apps/rhel7/bwa-0.7.17/bwa mem -M -t 4 -p /work/kmm105/spider_assembly/reference/GCA_023783555.1_ASM2378355v1_genomic.fna /dev/stdin | \\" >> $FILE
        echo "gatk --java-options "-Xmx16G" MergeBamAlignment \\" >> $FILE
        echo "ALIGNED_BAM=/dev/stdin \\" >> $FILE
        echo "UNMAPPED_BAM=/work/kmm105/spider_assembly/ubam/"$name"_unaligned_read_pairs.bam \\" >> $FILE
        echo "OUTPUT="$name"_piped.bam \\" >> $FILE
        echo "R=/work/kmm105/spider_assembly/reference/GCA_023783555.1_ASM2378355v1_genomic.fna CREATE_INDEX=true ADD_MATE_CIGAR=true \\" >> $FILE
        echo "CLIP_ADAPTERS=false CLIP_OVERLAPPING_READS=true \\" >> $FILE
        echo "INCLUDE_SECONDARY_ALIGNMENTS=true MAX_INSERTIONS_OR_DELETIONS=-1 \\" >> $FILE
        echo "PRIMARY_ALIGNMENT_STRATEGY=MostDistant ATTRIBUTES_TO_RETAIN=XS \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        sbatch $FILE
done
