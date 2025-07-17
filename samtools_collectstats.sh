#!/bin/bash
#SBATCH --mem=3GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p goldberg,common-old

cd /work/kmm105/spider_assembly/stats

OUT2=Summarize_percentmapping_spiderassembly.txt
while read ID;
do
        STAT=/work/kmm105/spider_assembly/stats/"$ID".flagstat
        printf "%s\t%s\t" "$STAT" "$ID"
        echo -n $ID >> $OUT2
        awk -F "[(|%]" 'NR == 5 {print ",",$2}' $STAT >> $OUT2
done < /work/kmm105/spider_assembly/Alouatta_fullpilot_list.txt

OUT=Summarize_avgdepths_spiderassembly.txt
while read ID;
do
        FILE=/work/kmm105/spider_assembly/stats/"$ID".depth
        printf "%s\t%s\t" "$FILE" "$ID"
        echo -n $ID >> $OUT
        #the depth -a flag gives all positions, including those with depth=0
        cat $FILE | awk '{sum+=$3} END { print ",",sum/NR}' >> $OUT
done < /work/kmm105/spider_assembly/Alouatta_fullpilot_list.txt
