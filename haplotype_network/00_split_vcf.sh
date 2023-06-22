#!/bin/bash
#SBATCH --partition=popgenom,kamiak
#SBATCH --cpus-per-task=2
#SBATCH --job-name=split
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu
#SBATCH --output=00_split_vcfs_out_%j.out
#SBATCH --error=00_split_vcfs_err_%j.err

module load bcftools
module load samtools
module load htslib

for file in pop_vcfs/ethe1*beagle.vcf.gz; do
tabix $file
for sample in `bcftools query -l $file`;
do
bcftools view -Oz -s $sample -o indv_vcfs/ethe1_${sample}_phased.vcf.gz $file
done
done
