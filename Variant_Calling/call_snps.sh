#!/bin/bash
#SBATCH --ntasks-per-node=2
#SBATCH --mail-user=anthony.p.brown@wsu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=kamiak
#SBATCH --job-name=capturesnps
#SBATCH --array=0-398:2

index=$SLURM_ARRAY_TASK_ID

finalID=$(grep -w ^$index /data/kelley/projects/pmex/capture/anthony_scripts/edited_readgroup_table.txt | awk 'BEGIN {FS="\t"}; {print $6}')

java -Xmx8g -jar /data/kelley/projects/programs/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-nct 2 \
-R /data/kelley/projects/pmex/capture/anthony_analysis/refGenome/MexicanaGenome.fna \
-I /data/kelley/projects/pmex/capture/anthony_analysis/fixed_read_groups/$finalID.rg.nodup.bam \
-ERC GVCF \
-o /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/$finalID.g.vcf
