#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=6
#SBATCH --job-name=filter
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=05_concat_%j.out
#SBATCH --error=05_concat_%j.err

module load bcftools 
module load htslib

bcftools concat \
--allow-overlaps \
capture.invar.vcf.gz capture.var.Q30.maf01.hwe.vcf.recode.vcf.gz \
-O z -o final_filtered.vcf.gz
