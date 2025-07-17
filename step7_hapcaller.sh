#!/bin/bash
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p goldberg,common-old

cd /work/kmm105/spider_assembly/step7scripts

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

while read ID;
do
        BAM=/datacommons/goldberg/lab_datasets/howlers/spider_assembly/bams/"$ID"_dedupRG.bam
        echo "calling variants for $ID"
	while read list;
	do
		contig="$(echo ${list} | grep -oP '.*(?=.list)' | awk -F'[/]' '{print $6}')"
		FILE="$ID"_"$contig"_runStep7.sh
        	OUT="$ID"_"$contig"-g.vcf.gz
        	echo "working on $OUT"
        	echo "#!/bin/bash" >> $FILE
        	echo "#SBATCH -c 4" >> $FILE
        	echo "#SBATCH --mem=10GB" >> $FILE
        	echo "#SBATCH --mail-type=FAIL" >> $FILE
        	echo "#SBATCH -p goldberg,common-old" >> $FILE
        	echo "cd /work/kmm105/spider_assembly/contig_vcfs" >> $FILE
        	echo "gatk --java-options "-Xmx8G" HaplotypeCaller \\" >> $FILE
        	echo "-R /datacommons/goldberg/lab_datasets/howlers/spider_assembly/reference/GCA_023783555.1_ASM2378355v1_genomic.fna -I $BAM -L $list -O $OUT -ERC GVCF" >> $FILE
		sbatch $FILE
	done < /work/kmm105/spider_assembly/contig_setslist.txt
done < /work/kmm105/spider_assembly/Alouatta_passdepth_list.txt

