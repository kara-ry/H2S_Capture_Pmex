#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=filter-tar-ref
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=outerr/05_filter_tarref.out
#SBATCH --error=outerr/05_filter_tarref.err

module load bcftools 
module load samtools 
module load htslib
module load bedtools

## Target
# filter target using bedtools
bedtools intersect -header -a capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz -b target.bed > target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf

# bgzip target vcf
bgzip -c target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf > target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz

# index target vcf.gz
 tabix -p vcf target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz

# generate stats
bcftools stats target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz > vcf_stats/target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.stats

## Reference
# filter reference using bedtools
bedtools intersect -header -a capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz -b reference.bed > reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf

# bgzip reference vcf
bgzip -c reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf > reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz

# index reference vcf.gz
tabix -p vcf reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz

# generate stats
bcftools stats reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz > vcf_stats/reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.stats
