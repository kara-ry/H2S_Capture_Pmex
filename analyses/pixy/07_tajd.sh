#!/bin/bash
#SBATCH --partition=popgenom,cahnrs,cas,kamiak
#SBATCH --cpus-per-task=4
#SBATCH --job-name=filter
#SBATCH --time=03-10:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu         ### email address
#SBATCH --mail-type=END,FAIL   ### email on all things
#SBATCH --output=07_TajD_%j.out
#SBATCH --error=07_TajD_%j.err

module load vcftools
module load htslib
module load bcftools

for set in sulfide nuox broughton nuclearref
do 
	for pop in BAN BON ESP GLO IXT LUV PSO ROS VG VS
	do 
		vcftools --gzvcf "${set}"_nVS44_bialleleSNPs.recode.vcf.gz \
		--keep "${pop}".txt \
		--TajimaD 10000 \
		--out "${set}_${pop}_10kbTajD"
	done
done

