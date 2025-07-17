#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p goldberg,common-old

cd /work/kmm105/spider_assembly/step8scripts

export PATH="/hpc/group/goldberg/kmm105/utils/gatk-4.4.0.0/:$PATH"
export JAVA_HOME=/hpc/group/goldberg/kmm105/utils/jdk-17.0.7
export PATH=$JAVA_HOME/bin:$PATH

while read list;
do
        chr="$(echo ${list} | grep -oP '.*(?=.list)' | awk -F'[/]' '{print $6}')"
        echo "working on $chr"
        FILE="$chr"_runStep8.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem=24GB" >> $FILE
        echo "#SBATCH --mail-type=END" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
        echo "cd /work/kmm105/spider_assembly/genomicsDB" >> $FILE
        echo "gatk --java-options \"-Xmx20g -Xms20g\" GenomicsDBImport \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/61_S48_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/63_S49_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/64_S50_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/65_S51_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/66_S52_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/67_S53_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/68_S54_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/69_S55_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/70_S56_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/71_S57_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/72_S58_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/73_S59_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/74_S60_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/75_S61_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/60_S47_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/112_S87_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/113_S88_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/57_S44_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/58_S45_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/59_S46_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/78_S62_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/84_S63_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/85_S64_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/86_S65_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/87_S66_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/88_S67_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/89_S68_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/1_S1_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/2_S2_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/3_S3_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/4_S4_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/5_S5_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/6_S6_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/7_S7_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/8_S8_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/9_S9_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/10_S10_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/11_S11_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/12_S12_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/13_S13_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/15_S14_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/16_S15_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/17_S16_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/18_S17_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/19_S18_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/20_S19_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/21_S20_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/22_S21_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/23_S22_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/24_S23_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/36_S24_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/37_S25_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/38_S26_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/39_S27_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/40_S28_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/41_S29_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/42_S30_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/43_S31_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/44_S32_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/45_S33_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/46_S34_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/47_S35_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/48_S36_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/49_S37_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/50_S38_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/51_S39_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/52_S40_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/53_S41_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/54_S42_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/55_S43_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/90_S69_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/91_S70_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/92_S71_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/93_S72_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/94_S73_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/96_S74_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/97_S75_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/101_S76_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/102_S77_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/103_S78_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/104_S79_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/105_S80_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/106_S81_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/107_S82_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/108_S83_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/109_S84_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/110_S85_"$chr"-g.vcf.gz \\" >> $FILE
       	echo "-V /work/kmm105/spider_assembly/contig_vcfs/111_S86_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091841_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091855_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091849_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091837_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091856_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091835_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091842_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091857_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091843_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091858_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091850_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091834_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091838_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091846_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091859_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091860_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091836_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091861_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091862_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091863_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091847_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091844_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091845_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091864_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091851_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091839_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091840_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091865_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091866_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091867_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091868_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091852_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091869_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091853_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/ERS12091854_"$chr"-g.vcf.gz \\" >> $FILE
	echo "-V /work/kmm105/spider_assembly/contig_vcfs/5090-MH-1_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/5090-MH-2_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/5090-MH-3_"$chr"-g.vcf.gz \\" >> $FILE
        echo "-V /work/kmm105/spider_assembly/contig_vcfs/5090-MH-4_"$chr"-g.vcf.gz \\" >> $FILE
        echo "--genomicsdb-workspace-path "$chr"_genomicsDB \\" >> $FILE
        echo "-L $list \\" >> $FILE
        echo "--genomicsdb-shared-posixfs-optimizations \\" >> $FILE
        echo "--tmp-dir /work/kmm105/spider_assembly/genomicsDB/tmp" >> $FILE
        sbatch $FILE
done < /work/kmm105/spider_assembly/contig_setslist.txt

