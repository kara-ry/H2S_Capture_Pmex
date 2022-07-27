#!/bin/bash

#SBATCH --partition=kamiak
#SBATCH --job-name=picard
#SBATCH --time=480
#SBATCH --array=0-199

nameArray=(/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_bamsort/read.*.sort.bam)
index=$SLURM_ARRAY_TASK_ID
filename=${nameArray[$index]}
theNumber=$(echo "$filename" | awk -F "." '{print $2}')

java -jar /data/kelley/projects/programs/picard-tools-1.141/picard.jar CollectAlignmentSummaryMetrics REFERENCE_SEQUENCE=/data/kelley/projects/pmex/capture/refGenome/MexicanaGenome.fna INPUT=/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_bamsort/read.${theNumber}.sort.bam OUTPUT=/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_picards/read.${theNumber}.txt
