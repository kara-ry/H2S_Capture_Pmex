#!/bin/bash

#SBATCH --partition=kamiak
#SBATCH --job-name=BWA
#SBATCH --time=480
#SBATCH --array=0-199

nameArray=(/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_bams/read.*.bam)
index=$SLURM_ARRAY_TASK_ID
filename=${nameArray[$index]}
theNumber=$(echo "$filename" | awk -F "." '{print $2}')

samtools sort $filename >/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_bamsort/read.${theNumber}.sort.bam


