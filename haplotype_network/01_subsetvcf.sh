#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=2
#SBATCH --job-name=subset_pops_phasing
#SBATCH --time=00-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=subset_pops.out
#SBATCH --error=subset_pops.err

module load vcftools 

vcftools 

for FILE in ../../txt/*list.txt;
do
File_name=$(echo "$FILE" | awk -F "/" '{print $NF}')
pop=$(echo $File_name | awk -F "." '{print $1}')
vcftools --vcf ../target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf \
--keep $FILE --recode --recode-INFO-all --out iqtree/${pop}.target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf ;
done 
