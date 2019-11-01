setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination")
DBS1 <- read.table("S1-radiation.DBS.reformat.vcf",header=T,sep='\t',row.names = 1)
DBS0 <- read.table("S1-0Gy-2.DBS.reformat.vcf",header=T,sep='\t',row.names = 1)
head(DBS1)
head(DBS0)
rowSums(DBS1)
DBS_sum<-rowSums(DBS1)/sum(rowSums(DBS1))
barplot(DBS_sum,las=2,ylim=c(0,0.2))
DBS_sum0<-rowSums(DBS0)/sum(rowSums(DBS0))
barplot(DBS_sum0,las=2,ylim=c(0,0.2))

####### 
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination")
s011 <- read.table("N1-S1.combination.Mutect_Strelka_union.vcf.readinfo.filtered",header=F,sep='\t')
nrow(s011)
s011<-s011[s011$V3=='T',]
s012<-s011[s011$V6>=0.1,]
head(s011$V6)
plot(density(s011$V6),xlim=c(0,1))
plot(density(s012$V6),xlim=c(0,1))

############
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination")
SBS<-matrix(c(0,1,2,2,4,8,937,744,905,1069,868,633),ncol = 2)
DBS<-matrix(c(0,1,2,2,4,8,6,8,14,10,11,13),ncol = 2)
DBS_ratio<-matrix(c(0,1,2,2,4,8,6/937,8/744,14/905,10/1069,11/868,13/633),ncol = 2)
head(SBS)
png(filename = "/home/users/jhyouk/06_mm10_SNUH_radiation/10_SNP_combination/dbs2.png",width=600,height = 600)
plot(DBS,ylim=c(0,20),xlab="Radiation dose(Gy)",ylab="The number of SNPs",pch=18,main="Single Base Substitutions",cex=2)
plot(DBS_ratio,ylim=c(0,0.03),xlab="Radiation dose(Gy)",ylab="The number of SNPs",pch=18,main="Single Base Substitutions",cex=2)
dev.off()



#########cumulative DSBS signature, 0Gy vs irradiated clonal murine pancreas samples ##############
DBS0 <- read.table("/home/users/jhyouk/06_mm10_SNUH_radiation/31_5_SNP_191010/my_analysis/DBS_control.reformat.txt",header=T,sep='\t',row.names = 1)
DBS1 <- read.table("/home/users/jhyouk/06_mm10_SNUH_radiation/31_5_SNP_191010/my_analysis/DBS_irradiation.reformat.txt",header=T,sep='\t',row.names = 1)

par(mfrow=c(2,1))
rowSums(DBS1)
DBS_sum<-rowSums(DBS1)/sum(rowSums(DBS1))
barplot(DBS_sum,las=2,ylim=c(0,0.2))
DBS_sum0<-rowSums(DBS0)/sum(rowSums(DBS0))
barplot(DBS_sum0,las=2,ylim=c(0,0.2))
dev.off()

pdf("DBS_siganture+101015.pdf")
barplot(rowSums(DBS1),las=2,main = 'irradiated samples')
barplot(rowSums(DBS0),las=2,main = 'control samples')
dev.off()
getwd()
