#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=generateclust
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=10_generateclust.out
#SBATCH --error=10_generateclust.err


module load bcftools
module load vcftools
module load stacks

# generate map file for capture dataset
bcftools view -H input.vcf.gz | cut -f 1 | uniq | awk '{print $0"\t"$0}' > input.map

# plink the capture dataset using the chrom map
vcftools --gzvcf input.vcf.gz --plink --chrom-map input.map --out output

# run stacks to generate
stacks/2.54 populations -V input.vcf.gz --treemix -O Treemix.capture/

#########
# Unsure if this needs to be run or if stacks will work on its own with old bim file - check before finalizing this
/data/kelley/projects/programs/plink2_64bit/plink2 --vcf input.vcf.gz --double-id --pca --make-bed --allow-extra-chr --out output
awk '{$1=0;print $0}' input.bim > output.bim.tmp
mv output.bim.tmp output.bim
