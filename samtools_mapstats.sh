#!/bin/bash
#SBATCH --mem=1GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p goldberg,common-old

cd /work/kmm105/spider_assembly/statscripts

BAMs=/work/kmm105/spider_assembly/bams/*_dedupRG.bam
for BAM in $BAMs
do 
        name="$(echo ${BAM} | grep -oP '.*(?=_dedupRG.bam)' | awk -F'[/]' '{print $6}')"
	OUT1="$name".flagstat
	OUT2="$name".depth
	OUT3="$name".idxstats
        FILE="$name"_runstats.sh
        echo "#!/bin/bash" >> $FILE
        echo "#SBATCH --mem=6GB" >> $FILE
        echo "#SBATCH -p goldberg,common-old" >> $FILE
        echo "#SBATCH --mail-type=FAIL" >> $FILE
        echo "cd /work/kmm105/spider_assembly/stats" >> $FILE
        printf "%s\t%s\t" "$BAM" "$name"
	echo "/opt/apps/rhel8/samtools-1.11/bin/samtools flagstat ${BAM} > ${OUT1}" >> $FILE
        #the depth -a flag gives all positions, including those with depth=0
        echo "/opt/apps/rhel8/samtools-1.11/bin/samtools depth -a ${BAM} > ${OUT2}" >> $FILE
	echo "/opt/apps/rhel8/samtools-1.11/bin/samtools idxstats ${BAM} > ${OUT3}" >> $FILE
        sbatch $FILE
done
