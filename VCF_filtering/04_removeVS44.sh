#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=remove_hybrid
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=outerr/04_removeVS44.out
#SBATCH --error=outerr/04_removeVS44.err

module load bcftools
module load htslib

# remove hybrid individual using
bcftools view -s ^VS44 capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.vcf.gz -Oz -o capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz

# index new vcf
tabix -p vcf capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz

# gather stats to confirm individual was removed
bcftools stats capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz > vcf_stats/capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.stats
