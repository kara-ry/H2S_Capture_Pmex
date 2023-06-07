#!/bin/bash

#SBATCH --partition=kamiak
#SBATCH --job-name=sambam
#SBATCH --time=480
#SBATCH --array=0-199

nameArray=(/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_sams/read.*.sam)
index=$SLURM_ARRAY_TASK_ID
filename=${nameArray[$index]}
theNumber=$(echo "$filename" | awk -F "." '{print $2}')

samtools faidx MexicanaGenome.fna
samtools view -b $filename >/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_bams/read.${theNumber}.bam
