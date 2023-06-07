#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=6
#SBATCH --job-name=filter
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=07_depth_%j.out
#SBATCH --error=07_depth_%j.err

module load vcftools

vcftools --gzvcf ../../../../combined.vcf.gz --minDP 10 --recode --recode-INFO-all --out capture.mindp10
