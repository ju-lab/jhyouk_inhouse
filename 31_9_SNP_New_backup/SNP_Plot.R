library(tidyverse)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/")

par(mfrow=c(1,1))
file_list <- read.table("00_9_union_list_invitro_pancreas.txt")

class(file_list)
class(file_list[,1])
file_list[,1][1:3]

par(mfrow=c(1,2))
par(mar=(c(4.1,3.1,2.1,1.1)+1))


###all & subclonal_to_clonal,subclonal_to_subclonal,none_to_clonal,none_to_subclonal vaf plot####
pdf(file = "SNV_cellfraction_plot_NMcut2_invitro_pancreas.pdf")

i=file_list[,1][1]
input_file <- read.table(paste(i,"_union_2.readinfo.readc.rasmy_pon_b6_4.filter1.mreadc.rasmy.filter2.vcf", sep=''),header=F)
input_true_all <- input_file %>% subset(.$V37 =='TRUE')
input_true_all <- input_true_all %>% {.$V43[.$V43>2]<-3;.}
 #proportion
hist(input_true_all[,43],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_all (total mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,2),xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray')
lines(density(input_true_all[,43]))
abline(v=1.0,col='red');abline(v=0.8,col='blue')
 #vaf
#hist(input_true_all[,36],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_all_vaf (total mutation=',nrow(input_true_all),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray')
#lines(density(input_true_all[,36]))
#abline(v=0.5,col='red');abline(v=0.4,col='blue')

par(mfrow=c(1,2))
for (i in file_list[,1][27:27]){
  input_file <- read.table(paste(i,"_union_2.readinfo.readc.rasmy_pon_b6_4.filter1.mreadc.rasmy.filter2_exercise.vcf", sep=''),header=F)
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
  hist(input_true_new[,41],breaks = seq(0,3,by=0.02), probability = T,main = paste(i,'_new (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,2),xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray')
  lines(density(input_true_new[,41]))
  abline(v=1.0,col='red');abline(v=0.8,col='blue')

  hist(input_true_new[,34],breaks = seq(0,1,by=0.01), probability = T,main = paste(i,'_new_vaf (clonal mutation=',nrow(input_clonal),')',sep = ''),xlim=c(0,1),xlab="Variant allele frequency (VAF)", ylab = "Density", border='gray',col='gray')
  lines(density(input_true_new[,34]))
  abline(v=0.5,col='red');abline(v=0.4,col='blue')
  
  }
dev.off()
plot(1,1)
####

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
num_clonal <- as.data.frame(matrix(c('sampleID','none&subclonal_to_all','subclonal_to_clonal','none_to_clonal','none_to_subclonal'),nrow=1))
colnames(num_clonal)<-c('sampleID','none&subclonal_to_all','subclonal_to_clonal','none_to_clonal','none_to_subclonal')
num_clonal

####none_to_clonal_number plot##
for (i in 2:43){
  input_file <- read.table(paste(file_list[,1][i],"_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.filter1.mreadc.rasmy.filter2.vcf", sep=''),header=F)
  input_true_all <- input_file %>% subset(.$V37 =='TRUE') %>% subset(.$V29<=2)
  
  sc <- nrow(input_true_all %>% subset(.$V44 == 'subclonal_to_clonal'))  
  nc <- nrow(input_true_all %>% subset(.$V44 == 'none_to_clonal'))
  ns <- nrow(input_true_all %>% subset(.$V44 == 'none_to_subclonal'))
  nc_a <- nrow(input_true_all %>% subset(.$V44 == 'subclonal_to_subclonal')) + sc + nc + ns
  num_clonal <- rbind(num_clonal,list(file_list[,2][i],nc_a,sc,nc,ns))
  rownames(num_clonal)[i] <- file_list[,1][i]
}

num_clonal <- num_clonal[-1,]
num_clonal

plot(num_clonal$sampleID,num_clonal$none_to_clonal)
plot(num_clonal$sampleID[1:14],num_clonal$none_to_clonal[1:14],ylim=c(0,2000),col='red',main='none_to_clonal_invitro_pancreas (red:39days,blue:longer)',xlab='Radiation dose', ylab='The number of SNPs')
points(num_clonal$sampleID[15:42],num_clonal$none_to_clonal[15:42],ylim=c(0,2000),col='blue')

#num_clonal <- num_clonal %>% mutate('portion' = as.numeric(.$none_to_clonal) / (as.numeric(.$none_to_clonal)+as.numeric(.$none_to_subclonal )))
#plot(num_clonal$sampleID[1:14],num_clonal$portion[1:14],ylim=c(0,1),col='red')
#points(num_clonal$sampleID[15:42],num_clonal$portion[15:42],ylim=c(0,1),col='blue')

nrow(num_clonal)
num_clonal[14:15,]
par(mfrow=c(1,1),mar=c(5,4,3,2)+0.1)


####
input_file<-read.table(paste("S1-0Gy-2","_union_2_normalpanel1_11.readinfo.readc.rasmy_pon_b6_4_pon_balbc_7.filter1.mreadc.rasmy.vcf",sep=''),header=F)

#######histogram + bar plot combo for vaf plot
plot(density(as.numeric(input_file[input_file$V37=='TRUE',]$V36)),xlim=c(0,1));abline(v=0.5,col='red');abline(v=0.30,col='blue')

input_new <- input_file %>% subset(input_file$V37 =='TRUE')
#input_new <- input_new %>% subset(input_new$V44 == 'none_to_subclonal' | input_new$V44 == 'none_to_clonal')

nrow(input_file)
nrow(input_new)
table(is.na(input_new[,36]))

hist(input_new[,36],breaks = 100, probability = T,main = 'S1-0Gy-2',xlim=c(0,1),xlab="Estimated cell proportion", ylab = "Density", border='gray',col='gray')
lines(density(input_new[,36]))
abline(v=0.5,col='red');abline(v=0.30,col='blue')

plot(density(as.numeric(input_new$V36)),xlim=c(0,2));abline(v=1,col='red');abline(v=0.9,col='blue')
par(mfrow=c(1,1))







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
