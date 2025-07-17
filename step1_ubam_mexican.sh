#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p scavenger

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

cd /work/kmm105/spider_assembly/step1scripts

R1S=/datacommons/goldberg/lab_datasets/howlers/raw-short-read-Mexican-howler-data/A_palliata/mueller/Sample_*/*_L008_R1_001.fastq.gz
for R1 in $R1S
do
        name="$(echo ${R1} | grep -oP '.*(?=_L008_R1_001.fastq.gz)'| awk -F'[/]' '{print $10}')"
	directory="$(echo ${R1} | awk -F'[/]' '{print $9}' | awk -F'[_]' '{print $2}')"
        echo "working on $directory"
        R2=/datacommons/goldberg/lab_datasets/howlers/raw-short-read-Mexican-howler-data/A_palliata/mueller/Sample_"$directory"/"$name"_L008_R2_001.fastq.gz
        FILE="$directory"_runStep1.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem=3GB" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
	echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "cd /work/kmm105/spider_assembly/ubam" >> $FILE
        echo "gatk --java-options "-Xmx2g" FastqToSam \\" >> $FILE
        echo "F1=${R1} \\" >> $FILE
        echo "F2=${R2} \\" >> $FILE
        echo "O="${directory}"_unaligned_read_pairs.bam \\" >> $FILE
        echo "RG=${directory} \\" >> $FILE
        echo "SM=${directory} \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        sbatch $FILE
done

R1S=/datacommons/goldberg/lab_datasets/howlers/raw-short-read-Mexican-howler-data/A_pigra/fastqs_5090-MH/Sample_*/*_R1_001.fastq.gz
for R1 in $R1S
do
  	name="$(echo ${R1} | grep -oP '.*(?=_R1_001.fastq.gz)'| awk -F'[/]' '{print $10}')"
	directory="$(echo ${R1} | awk -F'[/]' '{print $9}' | awk -F'[_]' '{print $2}')"
        echo "working on $directory"
        R2=/datacommons/goldberg/lab_datasets/howlers/raw-short-read-Mexican-howler-data/A_pigra/fastqs_5090-MH/Sample_"$directory"/"$name"_R2_001.fastq.gz
        FILE="$directory"_runStep1.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem=3GB" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "cd /work/kmm105/spider_assembly/ubam" >> $FILE
        echo "gatk --java-options "-Xmx2g" FastqToSam \\" >> $FILE
        echo "F1=${R1} \\" >> $FILE
        echo "F2=${R2} \\" >> $FILE
        echo "O="${directory}"_unaligned_read_pairs.bam \\" >> $FILE
        echo "RG=${directory} \\" >> $FILE
        echo "SM=${directory} \\" >> $FILE
        echo "TMP_DIR=`pwd`/tmp" >> $FILE
        sbatch $FILE
done
