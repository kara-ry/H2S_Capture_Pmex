#!/bin/bash
#SBATCH --ntasks-per-node=5
#SBATCH --mail-user=anthony.p.brown@wsu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --partition=cas
#SBATCH --job-name=rositasnps

java -Xmx8g -jar /data/kelley/projects/programs/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-nt 5 \
-R /data/kelley/projects/pmex/capture/anthony_analysis/refGenome/MexicanaGenome.fna \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita1.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita10r.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita11.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita12.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita13.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita14r.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita18.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita2.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita21.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita22.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita23r.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita24.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita26.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita27r.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita28.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita29.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita3.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita4.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita6.g.vcf \
-V /data/kelley/projects/pmex/capture/anthony_analysis/vcf_files/Rosita8.g.vcf \
-allSites \
-o /data/kelley/projects/pmex/capture/anthony_analysis/population_vcf_files/rosita_combined.vcf.gz