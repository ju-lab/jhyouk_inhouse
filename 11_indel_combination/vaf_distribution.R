#setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/")
#s11<-read.table("S1-8Gy-1.strelka_varscan_union_indel_vaf_distribution.vcf")
#plot(density(s11$V1))

s01_indel <- read.table("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s02_indel <- read.table("S1-0Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s11_indel <- read.table("S1-1Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s12_indel <- read.table("S1-1Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s21_indel <- read.table("S1-2Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s22_indel <- read.table("S1-2Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s41_indel <- read.table("S1-4Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s42_indel <- read.table("S1-4Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
s81_indel <- read.table("S1-8Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_2-bpdeletion_signature.vcf",header=T,sep='\t',row.names = 1)
norm_indel <- cbind(s01_indel,s02_indel$number)
rad_indel <- cbind(s21_indel,s22_indel$number,s41_indel$number,s42_indel$number,s81_indel$number)
par(mfrow=c(1,2))
barplot(rowSums(rad_indel)/sum(rowSums(rad_indel)),ylim=c(0.0,1.0))
barplot(rowSums(norm_indel)/sum(rowSums(norm_indel)),ylim=c(0.0,1.0))

sum(rowSums(rad_indel))
sum(rowSums(norm_indel))

#nonrepetitive indel pattern
s01_rindel <- read.table("S1-0Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s02_rindel <- read.table("S1-0Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s11_rindel <- read.table("S1-1Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s12_rindel <- read.table("S1-1Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s21_rindel <- read.table("S1-2Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s22_rindel <- read.table("S1-2Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s41_rindel <- read.table("S1-4Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s42_rindel <- read.table("S1-4Gy-2.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
s81_rindel <- read.table("S1-8Gy-1.strelka_varscan_union_indel_clonal_removeN1S1_nonrepeat_pattern.vcf",header=F,sep='\t')
norm_rindel <- rbind(s01_rindel,s02_rindel)
rad_rindel <- rbind(s21_rindel,s22_rindel,s41_rindel,s42_rindel,s81_rindel)
library(ggplot2)
ggplot(s01_rindel,aes(x=V1))
head(norm_rindel)

hist(s01_rindel$V1,xlim=c(-10,10),freq = F,breaks=50)
hist(s02_rindel$V1,xlim=c(-10,10),freq=F,breaks=50)

hist(s21_rindel$V1,xlim=c(-10,10),freq=F,breaks=50)
hist(s22_rindel$V1,xlim=c(-10,10),freq=F,breaks=50)
hist(s41_rindel$V1,xlim=c(-10,10),freq=F,breaks=50)
hist(s42_rindel$V1,xlim=c(-10,10),freq=F,breaks=50)

hist(norm_rindel$V1,xlim=c(-10,10),freq=F,breaks=50)
hist(rad_rindel$V1,xlim=c(-10,10),freq=F,breaks=50)

# all indel number vs. radiation dose
all_indel <- matrix(c(0,1359,1,1340,2,1172,2,1614,4,1424,8,1255),ncol=2,byrow=1) # both insertions and deletions
all_indel
png(filename = "/home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/all_indel1.png",width=600,height = 600)
plot(all_indel,ylim=c(0,2000),xlab="Radiation dose(Gy)",ylab="The number of indels",pch=18,main="All indels",cex=2)
dev.off()


# non-repetitive indel number vs. radiation dose
#deletion <- matrix(c(0,34,0,37,1,27,1,28,2,48,2,43,4,52,4,47,8,49),ncol=2,byrow=1)
deletion <- matrix(c(0,49,1,35,2,59,2,58,4,70,8,62),ncol=2,byrow=1) # both insertions and deletions
deletion
png(filename = "/home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/nonrepetitive_indel1.png",width=600,height = 600)
plot(deletion,ylim=c(0,80),xlab="Radiation dose(Gy)",ylab="The number of indels",pch=18,main="Nonrepetitive indels",cex=2)
dev.off()

# genome wide deletions/insertions ratio in non-repetitive regions
delins_ratio <- matrix(c(0,36/4,0,44/5,1,31/4,1,29/5,2,57/2,2,53/5,4,62/8,4,55/4,8,59/3)),ncol=2,byrow=1)
head(delins_ratio)
png(filename = "/home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/nonrepetitive_ratio_indel.png",width=600,height = 600)
plot(delins_ratio,ylim=c(0,30),xlab="Radiation dose(Gy)",ylab="The ratio",pch=18,main="Ratio of small deletions/insertions",cex=2)
dev.off()

# genome wide deletions/insertions ratio in non-repetitive regions
indelsnp_ratio <- matrix(c(0,40/251,0,49/938,1,35/744,1,34/452,2,59/912,2,58/1069,4,70/868,4,59/849,8,62/633),ncol=2,byrow=1)
head(indelsnp_ratio)
png(filename = "/home/users/jhyouk/06_mm10_SNUH_radiation/11_indel_combination/nonrepetitive_ratio_indelsnp.png",width=600,height = 600)
plot(indelsnp_ratio,ylim=c(0,0.2),xlab="Radiation dose(Gy)",ylab="The ratio",pch=18,main="Ratio of indels/SNPs",cex=2)
dev.off()

