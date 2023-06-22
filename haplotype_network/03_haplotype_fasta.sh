#!/bin/bash
#SBATCH --partition=popgenom,kamiak
#SBATCH --cpus-per-task=2
#SBATCH --job-name=consensus
#SBATCH --time=3-00:00:00    ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --mail-user=kara.ryan@wsu.edu
#SBATCH --output=consensus_edites_out_%j.out
#SBATCH --error=consensus_edited_err_%j.err

module load bcftools 
module load samtools
module load htslib

for file in indv_vcfs/*_phased.vcf.gz
do
indv=$(echo "$file" | awk -F "/" '{print $NF}')
header=$(echo $indv | awk -F "_" '{print $2}')
bcftools consensus -f tmp/ethe1_reverse.fasta -p ${header}_H1 -H 1 $file -o indv_vcfs/haplotype_fasta/${header}.H1.fasta
done

for file in indv_vcfs/haplotype_fasta/*
do
indv=$(echo "$file" | awk -F "/" '{print $NF}')
touch /weka/data/lab/kelley/projects/pmex/capture/kara_analysis/PmexCapture/Filter_VCF/VCFs/phase/indv_vcfs/haplotype_fasta/fixed_header/${indv}_edited.fasta
cat $file | sed -e 's/NW_[0-9].*/ /g' > indv_vcfs/haplotype_fasta/fixed_header/${indv}_edited.fasta
done
