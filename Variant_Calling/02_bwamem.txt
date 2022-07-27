#!/bin/bash

#SBATCH --partition=kamiak
#SBATCH --job-name=BWA
#SBATCH --time=480
#SBATCH --array=0-400:2

fastArray=(/data/kelley/projects/pmex/capture/nick_trim/*.fq.gz)

index=$SLURM_ARRAY_TASK_ID
read1=${fastArray[$index]}
read2=${fastArray[$(($index+1))]}

bwa index -a bwtsw /data/kelley/projects/pmex/capture/refGenome/MexicanaGenome.fna
bwa mem /data/kelley/projects/pmex/capture/refGenome/MexicanaGenome.fna $read1 $read2 >/data/kelley/projects/pmex/capture/nick_alignmentTwo/read.${index}.sam
