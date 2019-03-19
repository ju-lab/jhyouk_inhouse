setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka")
pdf("181219_clonality.pdf")
a <- "B3-0_P19_4Gy-5"
var_dist<-read.table(paste(a,"/results/passed.somatic.snvs.vaf_annotated.vcf",sep = ''),header=T)
plot(density(var_dist$VaF),xlim=c(0,1),main = a);abline(v=0.5,col='red')
dev.off()

setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/04_strelka")

pdf("181219_clonality_nonclonal.pdf")
temp_name <- read.table("31_1_run_181219_prevpancreas.sh",header=F)
b<-temp_name$V3
for(a in b){
var_dist<-read.table(paste(a,"/results/",a,"_mother_read_removal.vcf",sep = ''),header=T)
plot(density(var_dist$VaF),xlim=c(0,1),main = a);abline(v=0.5,col='red')
}
dev.off()




hist(var_dist$VaF,breaks = 100,ylab = 'Number of SNPs',nclass = 1)

setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/")
s101<-read.table("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1.vcf",header=F)
head(s101)


setwd("/home/users/jhyouk/07_HBV/14_Strelka2/V0001-S1/results/variants/")
vaf<-read.table("somatic.snvs.vaf.vcf")
head(vaf)
plot(density(vaf$V12),xlim=c(0,1));abline(v=0.48,col='red')

setwd("/home/users/jhyouk/07_HBV/14_Strelka2/V0001-S4/results/variants/")
vaf2<-read.table("somatic.snvs.vaf.vcf")
head(vaf2)
plot(density(vaf2$V12),xlim=c(0,1));abline(v=0.50,col='red')
