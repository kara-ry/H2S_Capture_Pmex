#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=6
#SBATCH --job-name=filter
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=04_filter_var_%j.out
#SBATCH --error=04_filter_var_%j.err

module load perl 
module load vcftools 

perl filter_hwe_by_pop.pl \
-v capture.var.Q30.maf01.vcf \
-p samples.txt \
--out capture.var.Q30.maf01.hwe.vcf
