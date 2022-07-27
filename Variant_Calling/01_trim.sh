#!/bin/bash

#SBATCH --partition=kamiak
#SBATCH --job-name=trimN
#SBATCH --time=240
#SBATCH --array=0-399:2

output=/data/kelley/projects/pmex/capture/nick_trim/

fastArray=(/data/kelley/projects/pmex/capture/reads/*.fastq.gz)

index=$SLURM_ARRAY_TASK_ID
read1=${fastArray[$index]}
read2=${fastArray[$(($index+1))]}

trim_galore -o ${output} --fastqc --stringency 5 --length 40 --paired $read1 $read2
