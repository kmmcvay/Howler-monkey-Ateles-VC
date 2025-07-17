#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p scavenger

cd /work/kmm105/spider_assembly/step10scripts

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

VCFs=/work/kmm105/spider_assembly/vcfs/*.vcf.gz
for VCF in $VCFs
do
        name="$(echo ${VCF} | grep -oP '.*(?=.vcf.gz)' | awk -F'[/]' '{print $6}')"
        echo "working on $name"
        FILE="$name"_runStep10.sh
	echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
	echo "#SBATCH --mail-type=END" >> $FILE
        echo "#SBATCH -p goldberg,common" >> $FILE
        echo "#SBATCH --mem=8GB" >> $FILE
        echo "cd /work/kmm105/spider_assembly/vcfs" >> $FILE
	echo "gatk --java-options "-Xmx4g" SelectVariants \\" >> $FILE
        echo "-R /datacommons/goldberg/lab_datasets/howlers/spider_assembly/reference/GCA_023783555.1_ASM2378355v1_genomic.fna \\" >> $FILE
	echo "-V $VCF \\" >> $FILE
	echo "--select-type-to-include SNP \\" >> $FILE
	echo "-O "$name"_snps.vcf.gz" >> $FILE
	echo "gatk --java-options "-Xmx4g" VariantFiltration \\" >> $FILE
        echo "-R /datacommons/goldberg/lab_datasets/howlers/spider_assembly/reference/GCA_023783555.1_ASM2378355v1_genomic.fna \\" >> $FILE
	echo "-V "$name"_snps.vcf.gz \\" >> $FILE
	echo "-O "$name"_filteredSNPS.vcf.gz \\" >> $FILE
	echo "--filter-expression \"QD < 2.0 || FS > 60.0 || SOR > 3.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0\" \\" >> $FILE
	echo "--filter-name \"hardfilter\"" >> $FILE
	echo "gatk --java-options "-Xmx4g" SelectVariants \\" >> $FILE
        echo "-V "$name"_filteredSNPS.vcf.gz \\" >> $FILE
        echo "--exclude-filtered \\" >> $FILE
        echo "-O "$name"_hardfiltered.vcf.gz" >> $FILE
	sbatch $FILE
done
