#!/bin/bash
#SBATCH --mem-per-cpu=3GB -c 10
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p goldberg,common

cd /work/kmm105/spider_assembly/vcfs

bcftools concat Alouatta_*_hardfiltered.vcf.gz --threads 10 -Oz -o Alouatta_pilot_AteGeo_hardfiltered.vcf.gz
tabix Alouatta_pilot_AteGeo_hardfiltered.vcf.gz
