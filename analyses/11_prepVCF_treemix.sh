#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=prepVCFTreemix
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=11_prepVCFforTreemix.out
#SBATCH --error=11_prepVCFforTreemix.err


# this script https://github.com/speciationgenomics/scripts/blob/master/vcf2treemix.sh will generate the .frq file needed for treemix.
# it requires a vcf file and a pop.clust file that contains three columns: samplename | samplename | group
# it will also check for other required files (.bed, .bim, .fam, .log, .nosex .map and .ped) and make if necessary
# these can cause issues, so many of these files have been created above

vcf2treemix.sh input.vcf.gz input.pop.clust
