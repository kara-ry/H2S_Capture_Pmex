#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=prep_admix
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=07_prep_admix.out
#SBATCH --error=07_prep_admix.err


# run plink2 to generate both pca file for filtered capture dataset
/data/kelley/projects/programs/plink2_64bit/plink2 --vcf input.vcf.gz --double-id \
--geno 0.1 --make-bed --allow-extra-chr --pca --out output

# generate correct bim file for admixture 
awk '{$1=0;print $0}' input.bim > input.bim.tmp
mv input.bim.tmp input.bim
