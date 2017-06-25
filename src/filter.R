library(data.table); library(dplyr)
blood_raw <- fread("~/Downloads/7columns_G91716_anno.csv")
tumor_raw <- fread("~/Downloads/GSN79Tumor_normal_myanno.hg19_multianno.csv")

regFac <- read.table("~/Downloads/regfac.txt")
gSchwarnoma <-  read.table("~/Downloads/schwannoma_1732genes.txt")
blood_raw.fltr <- blood_raw %>% filter(Gene.refGene %in% gSchwarnoma$V1)
blood_raw.fltr <- blood_raw.fltr %>% filter(Func.refGene %in% regFac$V1)
tumor_raw.fltr <- tumor_raw %>% filter(Gene.refGene %in% gSchwarnoma$V1)
tumor_raw.fltr <- tumor_raw.fltr %>% filter(Func.refGene %in% regFac$V1)

tumor_raw.fltr <- tumor_raw.fltr %>% filter(!is.na(as.numeric(SIFT_score)))

tumor_raw.fltr <- tumor_raw.fltr%>% filter(SIFT_score < 0.05)
tumor_raw.fltr <- tumor_raw.fltr %>% filter(avsnp147 == ".")

dim(tumor_raw.fltr)
dim(blood_raw.fltr)
head(blood_raw.fltr)

write.csv(tumor_raw.fltr, "~/Downloads/tumor_expr.csv")
