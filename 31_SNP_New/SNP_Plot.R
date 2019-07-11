library(tidyverse)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/31_2_SNP_updated_190315/")

par(mfrow=c(1,1))
file_list <- read.table("00_9_pancreas43.sh")

class(file_list)
class(file_list[,1])
file_list[,1][1:3]

par(mfrow=c(1,2))
par(mar=(c(4.1,3.1,2.1,1.1)+1))


###all & subclonal_to_clonal,subclonal_to_subclonal,none_to_clonal,none_to_subclonal vaf plot####
file_list <- read.table("00_9_pancreas43.sh")
pdf(file = "SNV_plot_invitro_pancreas_190313.pdf")
par(mfrow=c(1,2))
i=file_list[,1][1]
input_file <- read.table(paste(i,"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.vcf", sep=''),header=F)
input_true_all <- input_file %>% subset(.$V35 =='TRUE')
input_true_all <- input_true_all %>% {.$V41[.$V41>2]<-3;.}
input_clonal <- input_true_all %>% subset(.$V41 >= 0.6)
 #proportion
hist(input_true_all[,41],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_all (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,2),xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray',cex.main=0.8)
lines(density(input_true_all[,41]))
abline(v=1.0,col='red');abline(v=0.8,col='blue')
 #vaf
hist(input_true_all[,34],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_all_vaf (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
lines(density(input_true_all[,34]))
abline(v=0.5,col='red');abline(v=0.4,col='blue')

par(mfrow=c(1,2))
for (i in file_list[,1][2:43]){
  input_file <- read.table(paste(i,"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V35 =='TRUE')
  input_true_all <- input_true_all %>% {.$V41[.$V41>2]<-3;.}
  #all
  #hist(input_true_all[,43],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_all (total mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,2), xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray')
  #lines(density(input_true_all[,43]))
  #abline(v=1.0,col='red');abline(v=0.8,col='blue')
  #hist(input_true_all[,36],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_all_vaf (total mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray')
  #lines(density(input_true_all[,36]))
  #abline(v=0.5,col='red');abline(v=0.4,col='blue')
  
  #new(remove clonal mother cell mutation)
  input_true_new <- subset(input_true_all,input_true_all$V42 == 'none_to_subclonal' | input_true_all$V42 == 'none_to_clonal' | input_true_all$V42 == 'subclonal_to_clonal' | input_true_all$V42 == 'subclonal_to_subclonal')
  input_clonal <- subset(input_true_all, input_true_all$V42 == 'none_to_clonal' | input_true_all$V42 == 'subclonal_to_clonal' | input_true_all$V42 == 'subclonal_to_subclonal')
  hist(input_true_new[,41],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_new (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,2),xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_new[,41]))
  abline(v=1.0,col='red');abline(v=0.8,col='blue')

  hist(input_true_new[,34],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_new_vaf (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_new[,34]))
  abline(v=0.5,col='red');abline(v=0.4,col='blue')
  
  }
dev.off()

#breast
file_list <- read.table("00_9_breast21.sh")
pdf(file = "SNV_plot_invitro_breast_190313.pdf")
par(mfrow=c(1,2))
i=file_list[,1][1]
input_file <- read.table(paste(i,"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.vcf", sep=''),header=F)
input_true_all <- input_file %>% subset(.$V35 =='TRUE')
input_true_all <- input_true_all %>% {.$V41[.$V41>2]<-3;.}
input_clonal <- input_true_all %>% subset(.$V41 >= 0.156)
#proportion
hist(input_true_all[,41],breaks = seq(0,3,by=0.02), probability = T,main = i,xlim=c(0,2),xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray',cex.main=0.8)
lines(density(input_true_all[,41]))
abline(v=0.74,col='brown');abline(v=0.26,col='red');abline(v=0.156,col='blue')
#vaf
hist(input_true_all[,34],breaks = seq(0,1,by=0.01), probability = T,main = i,xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
lines(density(input_true_all[,34]))
abline(v=0.37,col='brown');abline(v=0.13,col='red');abline(v=0.078,col='blue')

for (i in file_list[,1][2:21]){
  input_file <- read.table(paste(i,"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V35 =='TRUE')
  input_true_all <- input_true_all %>% {.$V41[.$V41>2]<-3;.}
  #all
  #hist(input_true_all[,43],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_all (total mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,2), xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray')
  #lines(density(input_true_all[,43]))
  #abline(v=1.0,col='red');abline(v=0.8,col='blue')
  #hist(input_true_all[,36],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_all_vaf (total mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray')
  #lines(density(input_true_all[,36]))
  #abline(v=0.5,col='red');abline(v=0.4,col='blue')
  
  #new(remove clonal mother cell mutation)
  input_true_new <- subset(input_true_all,input_true_all$V42 == 'none_to_subclonal' | input_true_all$V42 == 'none_to_clonal' | input_true_all$V42 == 'subclonal_to_clonal' | input_true_all$V42 == 'subclonal_to_subclonal')
  input_clonal <- subset(input_true_all, input_true_all$V42 == 'none_to_clonal' | input_true_all$V42 == 'subclonal_to_clonal' | input_true_all$V42 == 'subclonal_to_subclonal')
  hist(input_true_new[,41],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_new (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,2),xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_new[,41]))
  abline(v=1.0,col='red');abline(v=0.8,col='blue')
  
  hist(input_true_new[,34],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_new_vaf (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_new[,34]))
  abline(v=0.5,col='red');abline(v=0.4,col='blue')
  
}
dev.off()


#invivo_1st
par(mfrow=c(1,2))
file_list <- read.table("00_9_invivo_1st.sh",header = F)
file_list[1:3,1:3]
pdf(file = "SNV_plot_invivo_1st_190321.pdf")
for (i in file_list[,1][1:nrow(file_list)]){
  input_file <- read.table(paste(i,"_snp_union_2.readinfo.readc.rasmy_PanelofNormal.filter1.coverage.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V35 =='TRUE')
  input_clonal <- input_true_all %>% subset(.$V36 >=0.6)
  input_true_all <- input_true_all %>% {.$V37[.$V37>3]<-3;.}
  
  hist(input_true_all[,37],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_all (clonal mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,2), xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_all[,37]))
  abline(v=1.0,col='red');abline(v=0.6,col='blue')
  hist(input_true_all[,34],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_all_vaf (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_all[,34]))
  abline(v=0.5,col='red');abline(v=0.3,col='blue')
}
dev.off()

#invivo_2nd_1
par(mfrow=c(1,2))
file_list <- read.table("00_9_invivo_2nd_1.txt",header = F)
file_list[1:3,1:3]
pdf(file = "SNV_plot_invivo_2nd_1_190612.pdf")
par(mfrow=c(1,2))
for (i in file_list[,1][1:nrow(file_list)]){
#for (i in file_list[,1][1:30]){
  input_file <- read.table(paste(i,"_snp_union_2.readinfo.readc.rasmy_PanelofNormal.filter1.coverage.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V35 =='TRUE')
  input_clonal <- input_true_all %>% subset(.$V37 >=0.6)
  input_true_all <- input_true_all %>% {.$V37[.$V37>3]<-3;.}

  hist(input_true_all[,37],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_all (clonal mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,2), xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_all[,37]))
  abline(v=1.0,col='red');abline(v=0.6,col='blue')
  #input_true_all$V34[input_true_all$V34>1]
  
  #hist(input_true_all[,34],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_all_vaf (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  hist(input_true_all[,34],breaks = seq(0,1,by=0.01), probability = T,main=nrow(input_clonal),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_all[,34]))
  abline(v=0.5,col='red');abline(v=0.3,col='blue')
}
dev.off()

#human
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/GRCh37/31_SNP_annotation")
par(mfrow=c(1,1))
file_list <- read.table("00_9_human_1st.txt",header = F)
file_list[1:3,1:3]
pdf(file = "SNV_plot_human_190711_v3.pdf")
par(mfrow=c(1,2))
for (i in file_list[,1][1:nrow(file_list)]){
#for (i in file_list[,1][3:4]){
  input_file <- read.table(paste(i,"_snp_union_2.readinfo.readc.rasmy_PanelofNormal.filter1.coverage.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V35 =='TRUE')
  #input_clonal <- input_true_all %>% subset(.$V37 >=0.6)
  input_clonal <- input_true_all %>% subset(.$V34 >=0.3)
  input_true_all <- input_true_all %>% {.$V37[.$V37>3]<-3;.}
  
  hist(input_true_all[,37],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_all (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,2), xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_all[,37]))
  abline(v=1.0,col='red');abline(v=0.6,col='blue')
  #input_true_all$V34[input_true_all$V34>1]
  
  #hist(input_true_all[,34],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_all_vaf (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  hist(input_true_all[,34],breaks = seq(0,1,by=0.01), probability = T,main=nrow(input_clonal),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
  lines(density(input_true_all[,34]))
  abline(v=0.5,col='red');abline(v=0.3,col='blue')
}
dev.off()



#### decision of cut-off of varNM ####
varNM <- data.frame(matrix(c('5','por5','2','por2'),nrow=1))
rownames(varNM,c('5','por5','2','por2'))
varNM


for (i in file_list[,1][2:43]){
  input_file <- read.table(paste(i,"_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.filter1.mreadc.rasmy.filter2.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(input_file$V37 =='TRUE')
  
  input_target <- input_true_all %>% subset(input_true_all$V29<=4)
  new_clonal <- nrow(input_target[input_target$V44=='none_to_clonal'|input_target$V44=='subclonal_to_clonal',])
  new_sub <- nrow(input_target[input_target$V44=='none_to_subclonal'|input_target$V44=='subclonal_to_clonal',])

  input_target <- input_true_all %>% subset(input_true_all$V29<=2)
  d_clonal <- nrow(input_target[input_target$V44=='none_to_clonal'|input_target$V44=='subclonal_to_clonal',])
  d_sub <- nrow(input_target[input_target$V44=='none_to_subclonal'|input_target$V44=='subclonal_to_clonal',])
  temp <- as.data.frame(matric(c(new_clonal,new_sub,d_clonal,d_sub)),row.names='')
  varNM <- rbind(varNM,list(new_clonal,new_sub,d_clonal,d_sub))
}
varNM  

for (i in 2:2){
  print(file_list[,1][i])
  }


####none_to_clonal_number plot##
file_list <- read.table("00_9_pancreas43.sh")
num_clonal <- as.data.frame(matrix(c('sampleID','none&subclonal_to_clonal','subclonal_to_clonal','subclonal_to_subclonal','none_to_clonal','none_to_subclonal'),nrow=1))
colnames(num_clonal)<-c('sampleID','none&subclonal_to_all','subclonal_to_clonal','subclonal_to_subclonal','none_to_clonal','none_to_subclonal')
num_clonal

for (i in 2:43){
  input_file <- read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V35 =='TRUE')
  
  sc <- nrow(input_true_all %>% subset(.$V42 == 'subclonal_to_clonal'))  
  nc <- nrow(input_true_all %>% subset(.$V42 == 'none_to_clonal'))
  ns <- nrow(input_true_all %>% subset(.$V42 == 'none_to_subclonal'))
  ss <- nrow(input_true_all %>% subset(.$V42 == 'subclonal_to_subclonal'))
  nc_a <- ss + sc + nc
  num_clonal <- rbind(num_clonal,list(file_list[,2][i],nc_a,sc,ss,nc,ns))
  rownames(num_clonal)[i] <- file_list[,1][i]
}

num_clonal <- num_clonal[-1,]
#num_clonal
#par(mfrow=c(1,1))

file_list <- read.table("00_9_breast21.sh")

for (i in 2:21){
  input_file <- read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V35 =='TRUE')
  
  sc <- nrow(input_true_all %>% subset(.$V42 == 'subclonal_to_clonal'))  
  nc <- nrow(input_true_all %>% subset(.$V42 == 'none_to_clonal'))
  ns <- nrow(input_true_all %>% subset(.$V42 == 'none_to_subclonal'))
  ss <- nrow(input_true_all %>% subset(.$V42 == 'subclonal_to_subclonal'))
  nc_a <- ss + sc + nc
  num_clonal <- rbind(num_clonal,list(file_list[,2][i],nc_a,sc,ss,nc,ns))
  rownames(num_clonal)[i] <- file_list[,1][i]
}
#num_clonal <- num_clonal[-1,]
#num_clonal
plot(num_clonal$sampleID[1:14],num_clonal$none_to_clonal[1:14],ylim=c(0,2500),col='red',main='none_to_clonal_invitro (red:39days,blue:59days, black(breast): 74days)',xlab='Radiation dose', ylab='The number of SNPs')
points(num_clonal$sampleID[15:42],num_clonal$none_to_clonal[15:42],ylim=c(0,2500),col='blue')
points(num_clonal$sampleID[43:62],num_clonal$none_to_clonal[43:62],ylim=c(0,2500),col='black')
#max(num_clonal$none_to_clonal[1:20])

num_clonal$culture_time<- NA
num_clonal$culture_time
num_clonal[1:14,]$culture_time <- 39
num_clonal[15:42,]$culture_time <- 59
num_clonal[43:62,]$culture_time <- 74

plot(num_clonal$sampleID[1:14],as.numeric(num_clonal$`none&subclonal_to_all`[1:14])/as.numeric(num_clonal$culture_time[1:14]),ylim=c(0,60),col='red',main='none_to_clonal_invitro (red:39days,blue:59days, black: 74days)',xlab='Radiation dose', ylab='culture-associated snps per a day')
points(num_clonal$sampleID[15:42],as.numeric(num_clonal$`none&subclonal_to_all`[15:42])/as.numeric(num_clonal$culture_time[15:42]),col='blue')
points(num_clonal$sampleID[43:62],as.numeric(num_clonal$`none&subclonal_to_all`[43:62])/as.numeric(num_clonal$culture_time[43:62]),col='black')

#invitro culture associated SNPs
boxplot(as.numeric(num_clonal$`none&subclonal_to_all`[1:14]),as.numeric(num_clonal$`none&subclonal_to_all`[15:42]),as.numeric(num_clonal$`none&subclonal_to_all`[43:62]),ylim=c(0,4000),names=c('1st invitro panc (39days)','2nd invitro panc (59days)','invitro breast (74days)'), ylab='culture-associated snps (total)',main='Culture-associated SNPs (total)')
points(rep(1,14),as.numeric(num_clonal$`none&subclonal_to_all`[1:14]),col='red')
points(rep(2,28),as.numeric(num_clonal$`none&subclonal_to_all`[15:42]),col='blue')
points(rep(3,20),as.numeric(num_clonal$`none&subclonal_to_all`[43:62]))

#invitro culture associated SNPs per a day
boxplot(as.numeric(num_clonal$`none&subclonal_to_all`[1:14])/as.numeric(num_clonal$culture_time[1:14]),as.numeric(num_clonal$`none&subclonal_to_all`[15:42])/as.numeric(num_clonal$culture_time[15:42]),as.numeric(num_clonal$`none&subclonal_to_all`[43:62])/as.numeric(num_clonal$culture_time[43:62]),ylim=c(0,50),names=c('1st invitro panc (39days)','2nd invitro panc(59days)','invitro breast (74days)'), ylab='culture-associated snps per a day',main='culture-associated SNPs per a day')
points(rep(1,14),as.numeric(num_clonal$`none&subclonal_to_all`[1:14])/as.numeric(num_clonal$culture_time[1:14]),col='red')
points(rep(2,28),as.numeric(num_clonal$`none&subclonal_to_all`[15:42])/as.numeric(num_clonal$culture_time[15:42]),col='blue')
points(rep(3,20),as.numeric(num_clonal$`none&subclonal_to_all`[43:62])/as.numeric(num_clonal$culture_time[43:62]))

###### depth vs cell_portion plot
#plot(as.numeric(input_file[input_file$V37=='TRUE',]$V40),as.numeric(input_file[input_file$V37=='TRUE',]$V43),xlim=c(0,100))
plot(0,0,xlim=c(0,5),ylim=c(0,2),col='white')
points(as.numeric(input_file[input_file$V37=='TRUE',]$V40),as.numeric(input_file[input_file$V37=='TRUE',]$V43))
points(as.numeric(input_file[input_file$V37=='TRUE' & (input_file$V44 == 'subclonal_to_subclonal'| input_true$V44 == 'none_to_subclonal'),]$V40),as.numeric(input_file[input_file$V37=='TRUE'& (input_file$V44 == 'subclonal_to_subclonal'| input_true$V44 == 'none_to_subclonal'),]$V43),col='red')

# depth vs cell_portion plot
#plot(as.numeric(input_file[input_file$V37=='TRUE',]$V40),as.numeric(input_file[input_file$V37=='TRUE',]$V36),xlim=c(0,100))
plot(0,0,xlim=c(0,5),ylim=c(0,1),col='white')
points(as.numeric(input_file[input_file$V37=='TRUE',]$V40),as.numeric(input_file[input_file$V37=='TRUE',]$V36))
points(as.numeric(input_file[input_file$V37=='TRUE' & (input_file$V44 == 'subclonal_to_subclonal'| input_true$V44 == 'none_to_subclonal'),]$V40),as.numeric(input_file[input_file$V37=='TRUE'& (input_file$V44 == 'subclonal_to_subclonal'| input_true$V44 == 'none_to_subclonal'),]$V36),col='red')

# upstream & downstream normalized coverage
input_true <- input_file %>% subset(input_file$V37 =='TRUE')
plot(0,0,xlim = c(0,5),ylim = c(0,5),col='white')
points(input_true$V40,input_true$V41)
points(input_true[(input_true$V44 == 'subclonal_to_subclonal' | input_true$V44 == 'none_to_subclonal'),]$V40,input_true[(input_true$V44 == 'subclonal_to_subclonal'|input_true$V44 == 'none_to_subclonal'),]$V41,col='red')

########non-repetitive snps#############
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/31_2_SNP_updated_190315/")
file_list <- read.table("00_9_pancreas43.sh")
snp_nonrepeat <- as.data.frame(matrix(c('dose','snp'),nrow=1))
colnames(snp_nonrepeat)<-c('dose','snp')
for (i in 2:43){
  input_file <- tryCatch(read.table(paste(file_list[,1][i],"_snp_union_2.readinfo.readc.rasmy_PanelofNormal.filter1.readc.rasmy.filter2.nonrepeat.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (input_file[1,1] =='no') { print('pass')
  }else  {
    snp_nonrepeat <- rbind(snp_nonrepeat,list(file_list[i,2],nrow(input_file)))
    rownames(snp_nonrepeat)[i] <- file_list[i,1]
  }
}
snp_nonrepeat <- snp_nonrepeat [-1,]
snp_nonrepeat

file_list <- read.table("00_9_breast21.sh")
for (i in 2:21){
  input_file <- tryCatch(read.table(paste(file_list[,1][i],"_snp_union_2.readinfo.readc.rasmy_PanelofNormal.filter1.readc.rasmy.filter2.nonrepeat.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (input_file[1,1] =='no') { print('pass')
  }else  {
    snp_nonrepeat <- rbind(snp_nonrepeat,list(file_list[i,2],nrow(input_file)))
    rownames(snp_nonrepeat)[i] <- file_list[i,1]
  }
}
par(mfrow=c(1,3))
plot(snp_nonrepeat$dose[1:14],snp_nonrepeat$snp[1:14],ylim=c(0,1100),col='white',main='none_to_clonal_invitro nonrepetitive snps',xlab='Radiation dose', ylab='The number of SNPs')
points(snp_nonrepeat$dose[15:42],snp_nonrepeat$snp[15:42],col='blue')
points(snp_nonrepeat$dose[43:62],snp_nonrepeat$snp[43:62],col='black')




######Fallopian tube############
library(tidyverse)
getwd()
setwd("/home/users/jhyouk/10_fallopian_tube/11_SNP_INDEL/")

input_file <- read.table("ON015-7.true.vcf",header=F)
input_file <- read.table("2B1-2.true.vcf",header=F)
input_file <- read.table("4B2-7.true.vcf",header=F)
input_file[1:3,1:3]
#vaf
hist(input_file[,34],breaks = seq(0,1,by=0.01), probability = T,main = "ON015-7",xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
hist(input_file[,34],breaks = seq(0,1,by=0.01), probability = T,main = "2B1-2",xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)
hist(input_file[,34],breaks = seq(0,1,by=0.01), probability = T,main = "4B2-7",xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray',cex.main=0.8)

lines(density(input_file[,34]))
abline(v=0.5,col='red');abline(v=0.3,col='blue')
par(mfrow=c(1,1))
