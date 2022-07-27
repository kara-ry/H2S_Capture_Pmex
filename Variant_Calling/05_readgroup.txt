#!/bin/bash
#SBATCH --partition=kamiak
#SBATCH --job-name=readgroup
#SBATCH --time=480
#SBATCH --array=0-199

nameArray=(/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_bamsort/read.*.sort.bam)
index=$SLURM_ARRAY_TASK_ID
indexnext=$((SLURM_ARRAY_TASK_ID+1))
filename=${nameArray[$index]}
theNumber=$(echo "$filename" | awk -F "." '{print $2}')

sampleArray=(/data/kelley/projects/pmex/capture/reads/*.fastq.gz)
sampleName=${sampleArray[$theNumber]}
readID=$(echo "$sampleName" | awk -F "-" '{print $2}')

readnumber=$(grep -n "$readID" /data/kelley/projects/pmex/capture/WSU_125601_SampleSheet.csv | awk -F "," '{print $2}')
finalID=$(grep -w "$readnumber" /data/kelley/projects/pmex/capture/sampleIDtoSite.txt | awk 'BEGIN {FS="\t"}; {print $2}')

finalSite=$(grep -w "$readnumber" /data/kelley/projects/pmex/capture/sampleIDtoSite.txt | awk 'BEGIN {FS="\t"}; {print $3}')
finalWell=$(grep -w "$readnumber" /data/kelley/projects/pmex/capture/sampleIDtoSite.txt | awk 'BEGIN {FS="\t"}; {print $4}')

java -jar /data/kelley/projects/programs/picard-tools-1.141/picard.jar AddOrReplaceReadGroups \
I=${filename} \
O=/data/kelley/projects/pmex/capture/nick_alignmentTwo/nick_readbam/read.${theNumber}.grouped.bam \
RGID=${finalID} \
RGLB=align2 \
RGPL=ILLUMINA \
RGPU=${finalWell} \
RGSM=${readnumber}

