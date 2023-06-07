#!/bin/bash
#SBATCH --partition=popgenom
#SBATCH --cpus-per-task=2
#SBATCH --job-name=treemixm0
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=outerr/12_Treemix_m0_bootstrap.out
#SBATCH --error=outerr/12_Treemix_m0_bootstrap.err

# this loop will run treemix with m=0 with 1000 bootstraps to determine best tree. Migration events will be plotted on this tree

for i in {1..1000}
do
    /data/kelley/projects/programs/treemix/bin/treemix \
    -m 0 -k 1000 -i input.frq.gz \
    -bootstrap -o bootstrap/BITE.boot.capture.out_treemix_bootrep_$i
done
