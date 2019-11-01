library(tidyverse)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/")


par(mfrow=c(1,1))

class(file_list)
class(file_list[,1])
file_list[,1][1:3]

par(mfrow=c(1,2))
par(mar=(c(4.1,3.1,2.1,1.1)+1))
dev.off()

###all & subclonal_to_clonal,subclonal_to_subclonal,none_to_clonal,none_to_subclonal vaf plot####
pdf(file = "indel_plot_invitro_pancreas_190315.pdf")
file_list <- read.table("00_9_pancreas43.sh")
par(mfrow=c(1,2))
i=file_list[,1][1]
input_file <- read.table(paste(i,"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
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

#par(mfrow=c(1,2))
for (i in file_list[,1][2:43]){
  input_file <- read.table(paste(i,"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
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
pdf(file = "Indel_plot_invitro_breast_190315.pdf")
file_list <- read.table("00_9_breast21.sh")
par(mfrow=c(1,2))
i=file_list[,1][1]
input_file <- read.table(paste(i,"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
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
  input_file <- read.table(paste(i,"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
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
####


####none_to_clonal_number plot##
file_list <- read.table("00_9_pancreas43.sh")
num_clonal <- as.data.frame(matrix(c('sampleID','none&subclonal_to_clonal','subclonal_to_clonal','subclonal_to_subclonal','none_to_clonal','none_to_subclonal'),nrow=1))
colnames(num_clonal)<-c('sampleID','none&subclonal_to_all','subclonal_to_clonal','subclonal_to_subclonal','none_to_clonal','none_to_subclonal')
num_clonal

for (i in 2:43){
  input_file <- read.table(paste(file_list[,1][i],"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
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
  input_file <- read.table(paste(file_list[,1][i],"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
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
par(mfrow=c(1,1))
plot(num_clonal$sampleID[1:14],num_clonal$none_to_clonal[1:14],ylim=c(0,4000),col='red',main='none_to_clonal_invitro (red:39days,blue:59days, black(breast):74days)',xlab='Radiation dose', ylab='The number of INDELs')
points(num_clonal$sampleID[15:42],num_clonal$none_to_clonal[15:42],col='blue')
points(num_clonal$sampleID[43:62],num_clonal$none_to_clonal[43:62],col='black')
#max(num_clonal$none_to_clonal[1:20])

num_clonal$culture_time<- NA
num_clonal$culture_time
num_clonal[1:14,]$culture_time <- 39
num_clonal[15:42,]$culture_time <- 59
num_clonal[43:62,]$culture_time <- 74

plot(num_clonal$sampleID[1:14],as.numeric(num_clonal$`none&subclonal_to_all`[1:14])/as.numeric(num_clonal$culture_time[1:14]),ylim=c(0,60),col='red',main='none_to_clonal_invitro (red:39days,blue:59days, black: 74days)',xlab='Radiation dose', ylab='culture-associated snps per a day')
points(num_clonal$sampleID[15:42],as.numeric(num_clonal$`none&subclonal_to_all`[15:42])/as.numeric(num_clonal$culture_time[15:42]),col='blue')
points(num_clonal$sampleID[43:62],as.numeric(num_clonal$`none&subclonal_to_all`[43:62])/as.numeric(num_clonal$culture_time[43:62]),col='black')

#invitro culture associated INDELs
boxplot(as.numeric(num_clonal$`none&subclonal_to_all`[1:14]),as.numeric(num_clonal$`none&subclonal_to_all`[15:42]),as.numeric(num_clonal$`none&subclonal_to_all`[43:62]),ylim=c(0,8000),names=c('1st invitro panc (39days)','2nd invitro panc (59days)','invitro breast (74days)'), ylab='culture-associated indels (total)',main='Culture-associated INDELs (total)')
points(rep(1,14),as.numeric(num_clonal$`none&subclonal_to_all`[1:14]),col='red')
points(rep(2,28),as.numeric(num_clonal$`none&subclonal_to_all`[15:42]),col='blue')
points(rep(3,20),as.numeric(num_clonal$`none&subclonal_to_all`[43:62]))

#invitro culture associated INDELs per a day
boxplot(as.numeric(num_clonal$`none&subclonal_to_all`[1:14])/as.numeric(num_clonal$culture_time[1:14]),as.numeric(num_clonal$`none&subclonal_to_all`[15:42])/as.numeric(num_clonal$culture_time[15:42]),as.numeric(num_clonal$`none&subclonal_to_all`[43:62])/as.numeric(num_clonal$culture_time[43:62]),ylim=c(0,100),names=c('1st invitro panc (39days)','2nd invitro panc (59days)','invitro breast'), ylab='culture-associated indels per a day (79days)',main='culture-associated INDELs per a day')
points(rep(1,14),as.numeric(num_clonal$`none&subclonal_to_all`[1:14])/as.numeric(num_clonal$culture_time[1:14]),col='red')
points(rep(2,28),as.numeric(num_clonal$`none&subclonal_to_all`[15:42])/as.numeric(num_clonal$culture_time[15:42]),col='blue')
points(rep(3,20),as.numeric(num_clonal$`none&subclonal_to_all`[43:62])/as.numeric(num_clonal$culture_time[43:62]))


####### ratio of deletions / insertions ##########
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/")
file_list <- read.table("00_9_pancreas43.sh")
indel_ratio <- as.data.frame(matrix(c('dose','smallinsertion','smalldeletion','ratio','indel/snp ratio'),nrow=1))
colnames(indel_ratio)<-c('dose','smallinsertion','smalldeletion','ratio','indel/snp ratio')
indel_ratio
for (i in 2:43){
  input_indel <- read.table(paste(file_list[,1][i],"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
  input_snp <- as.numeric(nrow(read.table(paste("../31_SNP_New/",file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.vcf", sep=''),header=F)))
  input_denovo <- subset(input_indel, input_indel$V42 == 'none_to_clonal')
  input_ins <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) < str_length(.$V5))))
  input_del <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) > str_length(.$V5))))
  indel_ratio <- rbind(indel_ratio,list(file_list[,2][i],input_ins,input_del,round(input_del/input_ins,2),round((input_ins+input_del)/input_snp,2)))
}
indel_ratio <- indel_ratio[-1,]

file_list <- read.table("00_9_breast21.sh")
for (i in 2:21){
  input_indel <- read.table(paste(file_list[,1][i],"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.vcf", sep=''),header=F)
  input_snp <- as.numeric(nrow(read.table(paste("../31_SNP_New/",file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.vcf", sep=''),header=F)))
  input_denovo <- subset(input_indel, input_indel$V42 == 'none_to_clonal')
  input_ins <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) < str_length(.$V5))))
  input_del <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) > str_length(.$V5))))
  indel_ratio <- rbind(indel_ratio,list(file_list[,2][i],input_ins,input_del,round(input_del/input_ins,2),round((input_ins+input_del)/input_snp,2)))
}

par(mfrow=c(1,3))
plot(indel_ratio$dose[1:14],indel_ratio$`indel/snp ratio`[1:14],ylim=c(0,3),col='white',main='Ratio (INDEL/SNP) none_to_clonal_invitro',xlab='Radiation dose', ylab='Ratio del/ins')
points(indel_ratio$dose[15:42],indel_ratio$`indel/snp ratio`[15:42],col='blue')
points(indel_ratio$dose[43:62],indel_ratio$`indel/snp ratio`[43:62],col='black')

########non-repetitive indels#############
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/32_indel_filter/")
file_list <- read.table("00_9_pancreas43.sh")
indel_ratio <- as.data.frame(matrix(c('dose','smallinsertion','smalldeletion','indel'),nrow=1))
colnames(indel_ratio)<-c('dose','smallinsertion','smalldeletion','indel')
indel_ratio
for (i in 2:43){
  input_denovo <- tryCatch(read.table(paste(file_list[,1][i],"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.nonrepeat.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (input_denovo[1,1] =='no') { print('pass')
    
  }else
  {
  input_ins <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) < str_length(.$V5))))
  input_del <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) > str_length(.$V5))))
  indel_ratio <- rbind(indel_ratio,list(file_list[,2][i],input_ins,input_del,input_ins+input_del))}
}
indel_ratio <- indel_ratio[-1,]


file_list <- read.table("00_9_breast21.sh")
for (i in 2:21){
  input_denovo <- tryCatch(read.table(paste(file_list[,1][i],"_indel_union_2.readinfo.readc.rasmy.pon.filter1.readc.rasmy.filter2.nonrepeat.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (input_denovo[1,1] =='no') { print('pass')
    
  }else
  {
    input_ins <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) < str_length(.$V5))))
    input_del <- as.numeric(nrow(input_denovo %>% subset(str_length(.$V4) > str_length(.$V5))))
    indel_ratio <- rbind(indel_ratio,list(file_list[,2][i],input_ins,input_del,input_ins+input_del))}
}

par(mfrow=c(1,3))
plot(indel_ratio$dose[1:14],indel_ratio$smalldeletion[1:14],ylim=c(0,30),col='white',main='none_to_clonal_invitro nonrepetitive indels',xlab='Radiation dose', ylab='The number of INDELs')
points(indel_ratio$dose[15:42],indel_ratio$smalldeletion[15:42],col='blue')
points(indel_ratio$dose[43:62],indel_ratio$smalldeletion[43:62],col='black')

indel_ratio[43:62,]



###########################################
########191016 indel count comparison######
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/32_5_INDEL_191010/mouse/")
info_file = read.table("00_9_mouse_human_191010.txt",header=T)
info_file[1:5,1:5]
batch_A <- info_file[info_file$batch=='A' & info_file$clonality == 'clonal',]
batch_A
file_list <- c()
for (i in batch_A[,1]){
  temp<-read.table(file = paste0(i,".true.clonal.combine.vcf"),header=T)
  file_list <- c(file_list,nrow(temp))
}
file_list
batch_A$SNPs_clonal <- file_list
nrow(batch_A)
plot(batch_A$Dose,batch_A$SNPs_clonal,ylim = c(0,3000))

batch_B <- info_file[info_file$batch=='B' & info_file$clonality == 'clonal',]
length(batch_B[,1])
b_list <- c()
for (i in batch_B[,1]){
  temp<-read.table(file = paste0(i,".true.clonal.combine.vcf"),header=T)
  b_list <- c(b_list,nrow(temp))
}
b_list
batch_B$SNPs_clonal <- b_list
batch_B
points(batch_B$Dose,batch_B$SNPs_clonal,col='brown')

par(mfrow=c(1,1))

shapiro.test(batch_A$SNPs_clonal) #<0.5 -> use non-parametric!
wilcox.test(batch_A$SNPs_clonal,batch_B$SNPs_clonal)

t.test(batch_A$SNPs_clonal,batch_B$SNPs_clonal)
1066/39
1404/59
(1404-1066)/20
pdf("/home/users/jhyouk/06_mm10_SNUH_radiation/32_5_INDEL_191010/mouse/indel_group_comparison_boxplot.pdf")
boxplot(batch_A$SNPs_clonal,batch_B$SNPs_clonal,boxwex=0.25,names = c("Group A","Group B"),ylab= "The number of indels",ylim=c(0,2500))
stripchart(list(batch_A$SNPs_clonal,batch_B$SNPs_clonal), vertical = TRUE, 
           method = "jitter", add = TRUE, pch = 20, col = alpha('black',0.2))
dev.off()


a_control <- filter(batch_A,batch_A$Dose==0)
a_ir <- filter(batch_A,batch_A$Dose>0)
t.test(a_control$SNPs_clonal,a_ir$SNPs_clonal)
wilcox.test(a_control$SNPs_clonal,a_ir$SNPs_clonal)

b_control <- filter(batch_B,batch_B$Dose==0)
b_ir <- filter(batch_B,batch_B$Dose>0)
t.test(b_control$SNPs_clonal,b_ir$SNPs_clonal)
wilcox.test(b_control$SNPs_clonal,b_ir$SNPs_clonal)
length(a_control)
length(a_ir)

###non-repetitive indels###

#<5
control_nr = c(12, 7, 13, 9, 20, 14, 19, 23, 10)
ir_nr = c(22, 33, 1, 32, 42, 34, 17, 55, 80, 52, 84, 82, 87, 69, 73, 57, 69, 36, 34, 28, 46, 51, 42, 41, 49, 43, 43, 30, 31, 28, 21)

wilcox.test(control_nr,ir_nr)
t.test(control_nr,ir_nr)
summary(control_nr)
summary(ir_nr)
length(control_nr)
length(ir_nr)

a_control_nr<-c(12, 7, 13, 9, 20)
a_ir_nr<-c(22, 33, 1, 32, 42, 34, 17, 55)
b_control_nr<-c(14, 19, 23, 10)
b_ir_nr<-c(80, 52, 84, 82, 87, 69, 73, 57, 69, 36, 34, 28, 46, 51, 42, 41, 49, 43, 43, 30, 31, 28, 21)

wilcox.test(a_control_nr,a_ir_nr)
t.test(a_control_nr,a_ir_nr)

wilcox.test(b_control_nr,b_ir_nr)
t.test(b_control_nr,b_ir_nr)

wilcox.test(a_control_nr,b_control_nr)
t.test(a_control_nr,b_control_nr)
summary(a_control_nr)
summary(a_ir_nr)
summary(b_control_nr)
summary(b_ir_nr)

pdf("/home/users/jhyouk/06_mm10_SNUH_radiation/32_5_INDEL_191010/mouse/non_repetitive_indels_boxplot.pdf")
boxplot(a_control_nr,a_ir_nr,b_control_nr,b_ir_nr,boxwex=0.3,names = c("control","irradiation","control","irradiation"),ylab= "The number of indels",ylim=c(0,100))
stripchart(list(a_control_nr,a_ir_nr,b_control_nr,b_ir_nr), vertical = TRUE, 
           method = "jitter", add = TRUE, pch = 20, col = alpha('black',0.2))
dev.off()






###histogram of nonrepetitive indels###
control_size <- read.table("/home/users/jhyouk/06_mm10_SNUH_radiation/32_5_INDEL_191010/mouse/nonrepetitive_indel_control.txt",header=F)
ir_size <- read.table("/home/users/jhyouk/06_mm10_SNUH_radiation/32_5_INDEL_191010/mouse/nonrepetitive_indel_ir.txt",header=F)
pdf("/home/users/jhyouk/06_mm10_SNUH_radiation/32_5_INDEL_191010/mouse/nonrepetitive_indel_size_distribution.pdf")
hist(rowSums(control_size),breaks = seq(from = -35.5, to = 99.5, by = 1),col=rgb(0,0,1,0.3),border=F,freq = F,right = F,ylim=c(0,0.6), main = "Indel size distribution of control and irradiated samples",xlab = 'Indel size (bp)')
hist(rowSums(ir_size),breaks = seq(from = -35.5, to = 99.5, by = 1),col=rgb(1,0,0,0.3),border=F,add=T,freq = F,right = F)
legend(60,0.4,c("control","irradiation"),fill=c(rgb(1,0,0,0.3),rgb(0,0,1,0.3)),border=F)
dev.off()

summary(rowSums(control_size))
summary(rowSums(ir_size))
t.test(rowSums(control_size),rowSums(ir_size))

length(rowSums(control_size)[rowSums(control_size)>2])
length(rowSums(control_size)[rowSums(control_size)>0])

length(rowSums(ir_size)[rowSums(ir_size)>2])
length(rowSums(ir_size)[rowSums(ir_size)>0])

a<-matrix(c(101-23,23,1292-686,686),nrow=2,byrow = T)
chisq.test(a)
a
pdf("/home/users/jhyouk/06_mm10_SNUH_radiation/32_5_INDEL_191010/mouse/3bp_1-2bp_barplot.pdf")
barplot(c(a[1,2]/a[1,1],a[2,2]/a[2,1]),ylim=c(0,1.5),space = 3,xlab='control samples (n=9) / irradiated samples (n=31)',ylab=">3bp small deletions / 1-2bp small deletions",col='gray',border='gray')
dev.off()
