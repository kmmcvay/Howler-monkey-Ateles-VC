#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p scavenger

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

cd /work/kmm105/spider_assembly/step1scripts

R1S=/datacommons/goldberg/public_datasets/Howlers_science.abn7829/*_1.fastq.gz
for R1 in $R1S
do
        name="$(echo ${R1} | grep -oP '.*(?=_1.fastq.gz)'| awk -F'[/]' '{print $6}')"
        echo "working on $name"
        R2=/datacommons/goldberg/public_datasets/Howlers_science.abn7829/"$name"_2.fastq.gz
        FILE="$name"_runStep1.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem=3GB" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
	echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "cd /work/kmm105/spider_assembly/ubam" >> $FILE
        echo "gatk --java-options "-Xmx2g" FastqToSam \\" >> $FILE
        echo "F1=${R1} \\" >> $FILE
        echo "F2=${R2} \\" >> $FILE
        echo "O="${name}"_unaligned_read_pairs.bam \\" >> $FILE
        echo "RG=${name} \\" >> $FILE
        echo "SM=${name} \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        sbatch $FILE
done
