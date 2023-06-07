#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=6
#SBATCH --job-name=pixy
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=06_pixy_%j.out
#SBATCH --error=06_pixy_%j.err

pixy --stats pi fst dxy \
--vcf final_filtered.vcf.gz \
--populations samples.txt \
--bed_file sulfide_pixy.bed \
--output_prefix sulfide_pixy

