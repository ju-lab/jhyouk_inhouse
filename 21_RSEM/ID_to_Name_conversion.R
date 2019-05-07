library('tidyverse')
getwd()
setwd('/home/users/jhyouk/06_mm10_SNUH_radiation/21_RSEM')

input_file <- read.table("CJ_rsem.genes.results",header=T)
input_file <- read.table("M3P4_breast_bul_rsem.genes.results",header=T)
input_file <- read.table("S1_0h-1_rsem.genes.results",header=T)

mouse_file<- read.table("mart_export_mouse.txt",header=T,sep='\t')
info_file <- read.table("mart_export_190328.txt",header=T,sep='\t')

colnames(input_file)[1]<-'mouse_id'
colnames(info_file) <- c('mouse_id','mouse_gene','human_id','human_gene')
info_file <- info_file[,c(1,4)]
colnames(mouse_file) <- c('mouse_id','mouse_gene')
input_cj <- left_join(input_file,mouse_file)
input_cj <- left_join(input_cj,info_file)
write.table(input_cj,"pancreas_TPM.txt",quote=F,sep='\t',row.names = F)
head(t)

t <- read.table("placenta_TPM.txt",header=T,sep='\t')
b <- read.table("breast_TPM.txt",header=T,sep='\t')
p <- read.table("pancreas_TPM.txt",header=T,sep='\t')

temp <- select(t,mouse_gene,human_gene,TPM)
colnames(temp)[3] <- "placenta_TPM"
temp <- cbind(temp,b$TPM)
colnames(temp)[4] <- "breast_TPM"
temp <- cbind(temp,p$TPM)
colnames(temp)[5] <- "pancreas_TPM"

write.table(temp,"all_TPM.txt",quote=F,sep='\t',row.names = F)
