#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=6
#SBATCH --job-name=filter
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=02_var_%j.out
#SBATCH --error=02_var_%j.err

module load vcftools
module load htslib
module load bcftools

# create variant file
vcftools --gzvcf filtered_vcf.gz \
--mac 1 \
--recode \
--recode-INFO-all \
--stdout | bgzip -c > capture.var.vcf.gz

# index
tabix capture.var.vcf.gz

# get stats
bcftools stats capture.var.vcf.gz > capture.var.stats
