#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p scavenger

cd /work/kmm105/spider_assembly/step5scripts

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

BAMs=/work/kmm105/spider_assembly/bams/*merged.bam
for BAM in $BAMs
do
        name="$(echo ${BAM} | grep -oP '.*(?=_merged.bam)' | awk -F'[/]' '{print $6}')"
        echo "working on $name"
        OUT1="$name"_sort.bam
        OUT2="$name"_dedup.bam
        MET="$name"_dedup_metrics.txt
        FILE="$name"_runStep5.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
        echo "#SBATCH --mem=15GB" >> $FILE
        echo "cd /work/kmm105/spider_assembly/bams" >> $FILE
        echo "gatk --java-options "-Xmx5G" SortSam \\" >> $FILE
        echo "INPUT=$BAM \\" >> $FILE
        echo "OUTPUT=$OUT1 \\" >> $FILE
        echo "SORT_ORDER=coordinate \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        echo "gatk --java-options "-Xmx10G" MarkDuplicates \\" >> $FILE
        echo "INPUT=$OUT1 \\" >> $FILE
        echo "OUTPUT=$OUT2 \\" >> $FILE
        echo "METRICS_FILE=$MET \\" >> $FILE
        echo "ASSUME_SORT_ORDER=coordinate CREATE_INDEX=true \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        sbatch $FILE
done

#mexican howler individuals have all run data in one input fastq so no merge step needed
while read name;
do
	BAM=/work/kmm105/spider_assembly/bams/"$name"_piped.bam
        echo "working on $name"
        OUT1="$name"_sort.bam
        OUT2="$name"_dedup.bam
        MET="$name"_dedup_metrics.txt
        FILE="$name"_runStep5.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
        echo "#SBATCH --mem=15GB" >> $FILE
        echo "cd /work/kmm105/spider_assembly/bams" >> $FILE
        echo "gatk --java-options "-Xmx5G" SortSam \\" >> $FILE
        echo "INPUT=$BAM \\" >> $FILE
        echo "OUTPUT=$OUT1 \\" >> $FILE
        echo "SORT_ORDER=coordinate \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        echo "gatk --java-options "-Xmx10G" MarkDuplicates \\" >> $FILE
        echo "INPUT=$OUT1 \\" >> $FILE
        echo "OUTPUT=$OUT2 \\" >> $FILE
        echo "METRICS_FILE=$MET \\" >> $FILE
        echo "ASSUME_SORT_ORDER=coordinate CREATE_INDEX=true \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        sbatch $FILE
done < /work/kmm105/spider_assembly/Alouatta_MX_list.txt
