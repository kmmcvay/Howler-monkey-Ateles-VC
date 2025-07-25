#!/bin/bash
#SBATCH --mem=1GB
#SBATCH -p scavenger

cd /work/kmm105/spider_assembly/step6scripts

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

BAMs=/work/kmm105/spider_assembly/bams/*dedup.bam
for BAM in $BAMs
do
        name="$(echo ${BAM} | grep -oP '.*(?=_dedup.bam)' | awk -F'[/]' '{print $6}')"
        echo "working on $name"
        OUT="$name"_dedupRG.bam
        FILE="$name"_runStep6.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem=5GB" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "cd /work/kmm105/spider_assembly/bams" >> $FILE
        echo "gatk --java-options "-Xmx5G" AddOrReplaceReadGroups I=$BAM O=$OUT RGID=$name RGSM=$name RGLB=lib1 RGPL=illumina RGPU=unit1 CREATE_INDEX=true" >> $FILE
        sbatch $FILE
done
