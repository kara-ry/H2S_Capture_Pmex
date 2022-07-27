#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=filter1
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=outerr/01_filter90missing_snps.out
#SBATCH --error=outerr/01_filter90missing_snps.err


module load vcftools 
module load bcftools
module load htslib
module load samtools 

# index vcf
tabix -p vcf /netapp/data/kelley/projects/pmex/capture/combined.vcf.gz

# Filter for 90% missingness and retain biallelic snps only
vcftools --gzvcf /netapp/data/kelley/projects/pmex/capture/combined.vcf.gz --max-missing 0.9 --min-alleles 2 --max-alleles 2 --remove-indels --recode --recode-INFO-all --out capture.merged.geno.m90.biallelic.SNPs

# bgzip
bgzip -c capture.merged.geno.m90.biallelic.SNPs.recode.vcf > capture.merged.geno.m90.biallelic.SNPs.vcf.gz

# Index the new vcf.gz
tabix -p vcf capture.merged.geno.m90.biallelic.SNPs.vcf.gz

# Gather stats about new vcf and confirm proper filtering
bcftools stats capture.merged.geno.m90.biallelic.SNPs.vcf.gz > vcf_stats/capture.merged.geno.m90.biallelic.SNPs.stats
