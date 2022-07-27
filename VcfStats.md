This pipeline removes individuals with 50% missingness and then randomly samples ~10,000 snps

## load required modules 
```
module load vcftools 
module load bcftools 
module load vcflib
```
## Prep VCF
```
bcftools view -i 'F_MISSING<0.50' capture_dataset_snps.vcf.gz -Oz -o capture_dataset_snpsM50.vcf.gz

bcftools view -H capture_dataset_snpsM50.vcf.gz | wc -l

bcftools index capture_dataset_snpsM50.vcf.gz 

bcftools view capture_dataset_snpsM50.vcf.gz | vcfrandomsample -r 0.07754042 > capture_dataset_snps_M50_subset.vcf

bcftools view capture_dataset_snps_M50_subset.vcf -Oz -o capture_dataset_snps_M50_subset.vcf.gz

bcftools index capture_dataset_snps_M50_subset.vcf.gz

bcftools view -H capture_dataset_snps_M50_subset.vcf.gz | wc -l
```

## Calculate stats (modified from https://speciationgenomics.github.io/filtering_vcfs/) 

```
SUBSET_VCF=capture_dataset_snps_M50_subset.vcf.gz
OUT=capture_subset

vcftools --gzvcf $SUBSET_VCF --freq2 --out $OUT --max-alleles 2

vcftools --gzvcf $SUBSET_VCF --depth --out $OUT

vcftools --gzvcf $SUBSET_VCF --site-mean-depth --out $OUT

vcftools --gzvcf $SUBSET_VCF --site-quality --out $OUT

vcftools --gzvcf $SUBSET_VCF --missing-indv --out $OUT

vcftools --gzvcf $SUBSET_VCF --missing-site --out $OUT

vcftools --gzvcf $SUBSET_VCF --het --out $OUT
```

# Visualize using R
```
setwd("~/OneDrive - Washington State University (email.wsu.edu)/NSAdmixOut/capture_subset")
library(tidyverse)
```
## Variant based statistics

### Variant quality
```
var_qual <- read_delim("./capture_subset.lqual", delim = "\t",
           col_names = c("chr", "pos", "qual"), skip = 1)
a <- ggplot(var_qual, aes(qual)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
a + theme_light() + xlim(0, 500)

print(a)
a2 <- a + xlim(0, 100)
print(a2)
```
![image](https://user-images.githubusercontent.com/71788965/120722907-7ce4dc80-c485-11eb-840c-6b9380d9534e.png)
![image](https://user-images.githubusercontent.com/71788965/120722917-81a99080-c485-11eb-865e-fabe300730e3.png)



### Variant mean depth
```
var_depth <- read_delim("./capture_subset.ldepth.mean", delim = "\t",
           col_names = c("chr", "pos", "mean_depth", "var_depth"), skip = 1)
b <- ggplot(var_depth, aes(mean_depth)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
b + theme_light()
summary(var_depth$mean_depth)
```
```
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.715   2.492   7.357  22.070  32.410 336.325 
```

```
b + theme_light() + xlim(0, 100)
print(b)
```
![image](https://user-images.githubusercontent.com/71788965/120722945-91c17000-c485-11eb-906d-3e562e488dce.png)
![image](https://user-images.githubusercontent.com/71788965/120722953-9423ca00-c485-11eb-8da2-9778354d772d.png)


### Variant missingness
```
var_miss <- read_delim("./capture_subset.lmiss", delim = "\t",
                       col_names = c("chr", "pos", "nchr", "nfiltered", "nmiss", "fmiss"), skip = 1)
c <- ggplot(var_miss, aes(fmiss)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
summary(var_miss$fmiss)
```
```
Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0350  0.1296  0.2500  0.4950
```
```
print(c)
c2 <- c+ theme_light() + xlim(0,1)
print(c2)

```
![image](https://user-images.githubusercontent.com/71788965/120723051-cd5c3a00-c485-11eb-9578-f8d691c9e3e9.png)
![image](https://user-images.githubusercontent.com/71788965/120723055-d0572a80-c485-11eb-9ed3-69a4aa6cf9af.png)



### Minor allele frequency
```
var_freq <- read_delim("./capture_subset.frq", delim = "\t",
                       col_names = c("chr", "pos", "nalleles", "nchr", "a1", "a2"), skip = 1)

# find minor allele frequency
var_freq$maf <- var_freq %>% select(a1, a2) %>% apply(1, function(z) min(z))


d <- ggplot(var_freq, aes(maf)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
d + theme_light()
summary(var_freq$maf)
```

Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.00000 0.00500 0.01343 0.07214 0.08499 0.50000 


![image](https://user-images.githubusercontent.com/71788965/120723095-e8c74500-c485-11eb-85fa-e9a08bb0f0a2.png)


## Individual based statistics

### Mean depth per individual
``` 
ind_depth <- read_delim("./capture_subset.idepth", delim = "\t",
                        col_names = c("ind", "nsites", "depth"), skip = 1)

e <- ggplot(ind_depth, aes(depth)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
e + theme_light()
```
![image](https://user-images.githubusercontent.com/71788965/120723114-f250ad00-c485-11eb-89e9-a935cb01ab1e.png)


### Mean depth per individual by population
```{r}
head(ind_depth)
species <- rep(NA, length(ind_depth$ind))
print(species)

head(ind_depth)
sp <- c("Banos", "Bonita", "Esperanza", "Gloria", "Ixta", "Lluvia", "PSO", "Rosita", "VG", "VS")


for (i in sp) {
  species[grep(i, ind_depth$ind)] <- i
}

i

# remake data frame
ind_depth <- as_tibble(data.frame(ind_depth, species))
head(ind_depth)
ind_depth$species <- as.factor(ind_depth$species)

head(ind_depth)
e2 <- ind_depth %>%
  ggplot(aes(x = depth, color = species, fill = species)) +
  geom_histogram(alpha=0.6) +
  xlim(0,20) +
  scale_fill_viridis(discrete=TRUE) +
  scale_color_viridis(discrete=TRUE) +
  facet_wrap(~species)

e2
```
![image](https://user-images.githubusercontent.com/71788965/120725187-41004600-c48a-11eb-9d52-f607caa0c2fc.png)



### Proportion of missing data per individual
```{r}
ind_miss  <- read_delim("./capture_subset.imiss", delim = "\t",
                        col_names = c("ind", "ndata", "nfiltered", "nmiss", "fmiss"), skip = 1)

f <- ggplot(ind_miss, aes(fmiss)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
f + theme_light() + xlim(0,1)

f2 <- f + theme_light() + xlim(0,0.2)
print(f2)

```
![image](https://user-images.githubusercontent.com/71788965/120726331-b240f880-c48c-11eb-96a2-e44c98e18750.png)
![image](https://user-images.githubusercontent.com/71788965/120726472-fdf3a200-c48c-11eb-8fc4-4ce4c22643b7.png)


### Proportion of missing data per individual by population

```
head(ind_miss)
species <- rep(NA, length(ind_miss$ind))
print(species)

head(ind_miss)
sp <- c("Banos", "Bonita", "Esperanza", "Gloria", "Ixta", "Lluvia", "PSO", "Rosita", "VG", "VS")


for (i in sp) {
  species[grep(i, ind_miss$ind)] <- i
}

i

# remake data frame
ind_miss <- as_tibble(data.frame(ind_miss, species))
head(ind_miss)
ind_miss$species <- as.factor(ind_miss$species)

head(ind_miss)
f3 <- ind_miss %>%
  ggplot(aes(x = fmiss, color = species, fill = species)) +
  geom_histogram(alpha=0.6) +
  scale_fill_viridis(discrete=TRUE) +
  scale_color_viridis(discrete=TRUE) +
  facet_wrap(~species)

f3
```

![image](https://user-images.githubusercontent.com/71788965/120726311-a2291900-c48c-11eb-88d9-015aae261f2b.png)
![image](https://user-images.githubusercontent.com/71788965/120726304-99384780-c48c-11eb-8e00-503e051dbaf0.png)



