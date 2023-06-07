#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=6
#SBATCH --job-name=filter
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=03_filter_var_%j.out
#SBATCH --error=03_filter_var_%j.err

module load vcftools 
module load perl 

vcftools --gzvcf capture.var.vcf.gz \
--minQ 30 \
--maf 0.01 \
--recode \
--recode-INFO-all \
--stdout | bgzip -c > capture.var.Q30.maf01.vcf.gz

