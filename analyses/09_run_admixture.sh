#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=runadmix
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=09_runAdmix.out
#SBATCH --error=09_runAdmix.err

# Admixture will be run or each possible K (1-10) and CV values will be collected to determine best K
for K in 1 2 3 4 5 6 7 8 9 10;
do
       # /data/kelley/projects/programs/admixture_linux-1.3.0/admixture target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.bed $K --cv | tee tarlog${K}.out
       # /data/kelley/projects/programs/admixture_linux-1.3.0/admixture reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.bed $K --cv | tee referencelog${K}.out
       /data/kelley/projects/programs/admixture_linux-1.3.0/admixture input.bed $K --cv | tee output.log${K}.out
done
