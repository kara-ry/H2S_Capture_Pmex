#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=filterQDPMAF
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=outerr/03_filterQ_dp_maf.out
#SBATCH --error=outerr/03_filterQ_dp_maf.err

module load vcftools
module load samtools
mdoule load htslib
module load bcftools

# filter for quality, minimum depth and minor allele frequency (see SNP EDA for more information for these chosen values)
vcftools --gzvcf capture.bed.merged.geno.m90.biallelic.SNPs.vcf.gz --minQ 30 --minDP 10 --maf 0.01 --recode --recode-INFO-all --out capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01

# bgzip
bgzip -c capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.recode.vcf > capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.vcf.gz

# index new vcf
tabix -p vcf capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.vcf.gz

# gather stats about filtered vcf
bcftools stats capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.vcf.gz > vcf_stats/capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.stats
