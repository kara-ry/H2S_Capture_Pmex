#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=LDprune
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=outerr/06_LD_prune08.out
#SBATCH --error=outerr/06_LD_prune08.err

module load bcftools
module load vcftools
module load htslib

# prune target r2^0.8 ( window 1000 snps) 
bcftools +prune -l 0.8 -w 1000 target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz -Oz -o target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz

# index new vcf
tabix -p vcf target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz

# gather stats
 bcftools stats target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz > vcf_stats/target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.stats
 
# prune reference r2^0.8 ( window 1000 snps) 
bcftools +prune -l 0.8 -w 1000 reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz -Oz -o reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz

# index new vcf
tabix -p vcf reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz

# gather stats
 bcftools stats reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz > vcf_stats/reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.stats
 
# concat dataset 
bcftools concat -a target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz -Oz -o capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz

tabix -p vcf capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz 

bcftools stats capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz > vcf_stats/capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.stats

