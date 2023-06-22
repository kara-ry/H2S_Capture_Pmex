#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=2
#SBATCH --job-name=phasing
#SBATCH --time=00-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=phase_pops.out
#SBATCH --error=phase_pops.err

conda activate py-popgen
module load bcftools 
module load java/1.8.0

for FILE in pop_vcfs/ethe1*txt.recode.vcf.gz ;
do 
python  /home/kara.ryan/anaconda3/envs/py-popgen/bin/vcf_phase.py --vcf $FILE --phase-algorithm beagle --out-prefix $FILE.beagle ;
done
