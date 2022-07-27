#!/bin/bash

#SBATCH --partition=kamiak
#SBATCH	--nodes=1
#SBATCH --job-name=fastqcnick
#SBATCH --time=120
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=6
#SBATCH --ntasks-per-node=6

output=/data/kelley/projects/pmex/capture/nick_quality/
for file in /data/kelley/projects/pmex/capture/*.fastq.gz
do
fastqc -t 6  -o ${output}  ${file}
done
