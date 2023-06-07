#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=preptarref
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=08_prep_admix_tarref.out
#SBATCH --error=08_prep_admix_tarref.err


# run plink2 to generate both pca file for filtered target dataset 
/data/kelley/projects/programs/plink2_64bit/plink2 --vcf target.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz --double-id --geno 0.1 --make-bed --allow-extra-chr --pca --out target.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44

# generate correct bim file for target admixture 
awk '{$1=0;print $0}' target.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim > target.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim.tmp
mv target.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim.tmp target.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim

# run plink2 to generate both pca file for filtered reference dataset 
/data/kelley/projects/programs/plink2_64bit/plink2 --vcf reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz --double-id --geno 0.1 --make-bed --allow-extra-chr --pca --out reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44

# generate correct bim file for reference admixture 
awk '{$1=0;print $0}' reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim > reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim.tmp
mv reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim.tmp reference.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.bim
