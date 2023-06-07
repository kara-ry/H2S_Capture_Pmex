# H<sub>2</sub>S Capture *P. mexicana*
This repository is for a manuscripit title "Selection on standing genetic variation mediates convergent evolution in extremophile fish."

## Raw data 
Summarized fastqc report can be found in [this multiqc report](https://github.com/kara-ry/H2S_Capture_Pmex/blob/main/multiqc_report.html) \
Raw data can be found on NCBI at BioProject PRJNA647126

## Variant Call files
All VCFs used for analyses found [here](https://github.com/kara-ry/H2S_Capture_Pmex/tree/main/VCFs)
This includes:
- [the raw VCF]()
- filtered VCF of:
  - [Sulfide](https://github.com/kara-ry/H2S_Capture_Pmex/blob/main/VCFs/sulfide.target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz)
  - [OxPhos](https://github.com/kara-ry/H2S_Capture_Pmex/blob/main/VCFs/oxphos.target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz)
  - [Reference](https://github.com/kara-ry/H2S_Capture_Pmex/blob/main/VCFs/reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.vcf.gz)
- LD-pruned VCF of:
  - [Sulfide](https://github.com/kara-ry/H2S_Capture_Pmex/blob/main/VCFs/sulfide.target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz)
  - [OxPhos](https://github.com/kara-ry/H2S_Capture_Pmex/blob/main/VCFs/oxphos.target.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz)
  - [Reference](https://github.com/kara-ry/H2S_Capture_Pmex/blob/main/VCFs/reference.capture.bed.merged.geno.m90.biallelic.SNPs.Q30.DP10.maf01.nVS44.LD08.vcf.gz)

## Scripts
The scripts used to run these analyses can be found:
- [Preprocessing, Mapping and Variant Calling](https://github.com/kara-ry/H2S_Capture_Pmex/tree/main/Variant_Calling)
- [VCF filtering Scripts]()
- [PCA, Admixture, Treemix, IqTree]()
- [Population Genetics Statistics]()
- [Haplotype Network]()









