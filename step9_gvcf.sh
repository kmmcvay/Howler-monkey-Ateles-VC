#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p goldberg,common

cd /work/kmm105/spider_assembly/step9scripts

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

while read list;
do
        chr="$(echo ${list} | grep -oP '.*(?=.list)' | awk -F'[/]' '{print $6}')"
	echo "working on $chr"
        FILE="$chr"_runStep9.sh
	echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem=18GB" >> $FILE
        echo "#SBATCH --mail-type=END" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "#SBATCH -p goldberg,common" >> $FILE
	echo "cd /work/kmm105/spider_assembly/vcfs" >> $FILE
	echo "gatk --java-options "-Xmx16g" GenotypeGVCFs \\" >> $FILE
        echo "-R /datacommons/goldberg/lab_datasets/howlers/spider_assembly/reference/GCA_023783555.1_ASM2378355v1_genomic.fna \\" >> $FILE
        echo "-V gendb:///work/kmm105/spider_assembly/genomicsDB/"$chr"_genomicsDB \\" >> $FILE
        echo "-O Alouatta_pilot_AteGeo_"$chr".vcf.gz \\" >> $FILE
	echo "-L $list \\" >> $FILE
	echo "--genomicsdb-shared-posixfs-optimizations \\" >> $FILE
        echo "--tmp-dir /work/kmm105/spider_assembly/genomicsDB/tmp" >> $FILE
	sbatch $FILE
done < /work/kmm105/spider_assembly/contig_setslist.txt
