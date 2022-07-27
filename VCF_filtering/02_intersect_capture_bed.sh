#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=filter2
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=outerr/02_intersect_capture.out
#SBATCH --error=outerr/02_intersect_capture.err

module load samtools
mdoule load htslib
module load bcftools
module load bedtools

# Sort nuclear capture bed
bedtools sort -i /netapp/data/kelley/projects/pmex/capture/anthony_analysis/old/bedtools_scripts/nuclearCaptureRegions.bed > nuclearCaptureRegionsSorted.bed

# intersect with bed 
bedtools intersect -header -sorted -a capture.merged.geno.m90.biallelic.SNPs.vcf.gz -b nuclearCaptureRegionsSorted.bed > capture.bed.merged.geno.m90.biallelic.SNPs.vcf

# zip new bed 
bgzip -c capture.bed.merged.geno.m90.biallelic.SNPs.vcf > capture.bed.merged.geno.m90.biallelic.SNPs.vcf.gz

# index new bed 
tabix -p vcf capture.bed.merged.geno.m90.biallelic.SNPs.vcf.gz

# generate stats 
bcftools stats vcf_stats/capture.bed.merged.geno.m90.biallelic.SNPs.vcf.gz
