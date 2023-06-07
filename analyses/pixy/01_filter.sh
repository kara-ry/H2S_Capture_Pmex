#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=6
#SBATCH --job-name=filter
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=01_invar_%j.out
#SBATCH --error=01_invar_%j.err

module load vcftools
module load htslib
module load bcftools

vcftools --gzvcf ../../../../combined.vcf.gz \
--remove-indels \
--max-missing 0.9 \
--min-meanDP 20 \
--recode \
--recode-INFO-all \
--stdout | gzip -c > filtered_vcf.gz

# index 
tabix filtered_vcf.gz

# get stats 
bcftools stats filtered_vcf.gz > filtered_vcf.stats

# create invariant file
vcftools --gzvcf filtered_vcf.gz \
--max-maf 0 \
--recode \
--recode-INFO-all \
--stdout | bgzip -c > capture.invar.vcf.gz

# index 
tabix capture.invar.vcf.gz

# get stats 
bcftools stats capture.invar.vcf.gz > capture.invar.stats
