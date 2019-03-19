library(tidyverse)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/31_SNP_New/")

###DBS number##
file_list <- read.table("00_9_pancreas43.sh")
dbs <- as.data.frame(matrix(c('Dose','numberofDBS','Totalnone_to_clonalmutations'),nrow=1))
colnames(dbs)<-c('Dose','numberofDBS','Totalnone_to_clonalmutations')
dbs
file_list
for (i in 2:43){
  input_file <- tryCatch(read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonaldbs.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (nrow(input_file) == 1) input_num=0 else input_num=nrow(input_file)
  
  info_file <- read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.vcf", sep=''),header=F)
  dbs <- rbind(dbs,list(file_list[,2][i],nrow(input_file),nrow(info_file)))
  rownames(dbs)[i] <- file_list[,1][i]
}
dbs <- dbs[-1,]
dbs

file_list <- read.table("00_9_breast21.sh")
for (i in 2:21){
  input_file <- tryCatch(read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonaldbs.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (nrow(input_file) == 1) input_num=0 else input_num=nrow(input_file)
  
  info_file <- read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.vcf", sep=''),header=F)
  dbs <- rbind(dbs,list(file_list[,2][i],nrow(input_file),nrow(info_file)))
  rownames(dbs)[i] <- file_list[,1][i]
}
nrow(dbs)
dbs
par(mfrow=c(1,2))
#absolute number
plot(dbs$Dose[1:14],dbs$numberofDBS[1:14],ylim=c(0,50),col='red',main='none_to_clonal_invitro dbs(red:39days,blue:59days, black(breast): 74days)',xlab='Radiation dose', ylab='The number of SNPs',pch=16)
plot(dbs$Dose[15:42],dbs$numberofDBS[15:42],ylim=c(0,50),col='blue',main='none_to_clonal_invitro dbs(red:39days,blue:59days, black(breast): 74days)',xlab='Radiation dose', ylab='The number of SNPs',pch=16)
plot(dbs$Dose[43:62],dbs$numberofDBS[43:62],ylim=c(0,50),col='black',main='none_to_clonal_invitro dbs(red:39days,blue:59days, black(breast): 74days)',xlab='Radiation dose', ylab='The number of SNPs',pch=16)

#ratio
plot(dbs$Dose[1:14],as.numeric(dbs$numberofDBS[1:14])/as.numeric(dbs$Totalnone_to_clonalmutations[1:14]),ylim=c(0,0.05),col='red',main='none_to_clonal_invitro dbs(red:39days,blue:59days, black(breast): 74days)',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16)
plot(dbs$Dose[15:42],as.numeric(dbs$numberofDBS[15:42])/as.numeric(dbs$Totalnone_to_clonalmutations[15:42]),ylim=c(0,0.05),col='blue',main='none_to_clonal_invitro dbs(red:39days,blue:59days, black(breast): 74days)',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16)
plot(dbs$Dose[43:62],as.numeric(dbs$numberofDBS[43:62])/as.numeric(dbs$Totalnone_to_clonalmutations[43:62]),ylim=c(0,0.05),col='black',main='none_to_clonal_invitro dbs(red:39days,blue:59days, black(breast): 74days)',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16)

####DBS_signature#####
temp_list <- read.table("00_9_invitro_daughter.sh")
input_pancreas <- temp_list %>% subset(.$V3 == 'pancreas')
input_breast <- temp_list %>% subset(.$V3 == 'breast')

file_list <- input_pancreas
file_list <- input_breast
file_list <- temp_list

nrow(file_list[file_list$V2 == '0',])
nrow(file_list[file_list$V2 == '1',])
nrow(file_list[file_list$V2 == '2',])
nrow(file_list[file_list$V2 == '4' | file_list$V2 == '8'  ,])

jj=0
for (i in 1:nrow(file_list)){
  if (as.numeric(file_list[i,]$V2) == 2){
  #if (as.numeric(file_list[i,]$V2) == 4 | as.numeric(file_list[i,]$V2) == 8){
    input_file <- tryCatch(read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonaldbs.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
    if (nrow(input_file) == 1) {
      print(1)
    } else{
      if (jj==0) {
      temp_file <- input_file
      jj = 1
      } else {
      if (nrow(input_file)>1) temp_file <- rbind(temp_file,input_file)
      }
    }
  }
}
nrow(temp_file)
write.table(temp_file,file="dbs_0Gy_pancreas.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)
write.table(temp_file,file="dbs_1Gy_pancreas.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)
write.table(temp_file,file="dbs_2Gy_pancreas.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)
write.table(temp_file,file="dbs_4Gy_pancreas.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)
write.table(temp_file,file="dbs_0Gy_breast.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)
write.table(temp_file,file="dbs_1Gy_breast.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)
write.table(temp_file,file="dbs_2Gy_breast.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)
write.table(temp_file,file="dbs_4Gy_breast.vcf",sep = '\t',quote = FALSE,col.names = FALSE,row.names = FALSE)


par(mfrow=c(4,1),mar=c(3,3,1,1))

file_list <- input_breast
dbs_0gy <- read.table("dbs_0Gy_breast.dbs_sig.vcf")
dbs_1gy <- read.table("dbs_1Gy_breast.dbs_sig.vcf")
dbs_2gy <- read.table("dbs_2Gy_breast.dbs_sig.vcf")
dbs_4gy <- read.table("dbs_4Gy_breast.dbs_sig.vcf")
barplot(as.numeric(dbs_0gy$V2)/nrow(file_list[file_list$V2 == '0',]),names.arg = dbs_0gy$V1,cex.names = 0.5,main = "0Gy_DBS_breast",ylab = 'normalized ratio',ylim=c(0,3))
barplot(as.numeric(dbs_1gy$V2)/nrow(file_list[file_list$V2 == '1',]),names.arg = dbs_1gy$V1,cex.names = 0.5,main = "1Gy_DBS_breast",ylab = 'normalized ratio',ylim=c(0,3))
barplot(as.numeric(dbs_2gy$V2)/nrow(file_list[file_list$V2 == '2',]),names.arg = dbs_2gy$V1,cex.names = 0.5,main = "2Gy_DBS_breast",ylab = 'normalized ratio',ylim=c(0,3))
barplot(as.numeric(dbs_4gy$V2)/nrow(file_list[file_list$V2 == '4' | file_list$V2 == '8'  ,]),names.arg = dbs_4gy$V1,cex.names = 0.5,main = "4Gy_DBS_breast",ylab = 'normalized ratio',ylim=c(0,3))

file_list <- input_pancreas
dbs_0gy <- read.table("dbs_0Gy_pancreas.dbs_sig.vcf")
dbs_1gy <- read.table("dbs_1Gy_pancreas.dbs_sig.vcf")
dbs_2gy <- read.table("dbs_2Gy_pancreas.dbs_sig.vcf")
dbs_4gy <- read.table("dbs_4Gy_pancreas.dbs_sig.vcf")
barplot(as.numeric(dbs_0gy$V2)/nrow(file_list[file_list$V2 == '0',]),names.arg = dbs_0gy$V1,cex.names = 0.5,main = "0Gy_DBS_pancreas",ylab = 'normalized ratio',ylim=c(0,2))
barplot(as.numeric(dbs_1gy$V2)/nrow(file_list[file_list$V2 == '1',]),names.arg = dbs_1gy$V1,cex.names = 0.5,main = "1Gy_DBS_pancreas",ylab = 'normalized ratio',ylim=c(0,2))
barplot(as.numeric(dbs_2gy$V2)/nrow(file_list[file_list$V2 == '2',]),names.arg = dbs_2gy$V1,cex.names = 0.5,main = "2Gy_DBS_pancreas",ylab = 'normalized ratio',ylim=c(0,2))
barplot(as.numeric(dbs_4gy$V2)/nrow(file_list[file_list$V2 == '4' | file_list$V2 == '8'  ,]),names.arg = dbs_4gy$V1,cex.names = 0.5,main = "4Gy_DBS_pancreas",ylab = 'normalized ratio',ylim=c(0,2))


########clustered mutations#############
file_list <- read.table("00_9_pancreas43.sh")
dbs <- as.data.frame(matrix(c('Dose','numberofclustered','Totalnone_to_clonalmutations'),nrow=1))
colnames(dbs)<-c('Dose','numberofclustered','Totalnone_to_clonalmutations')
dbs
file_list
for (i in 2:43){
  input_file <- tryCatch(read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.cluster.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (nrow(input_file) == 1) input_num=0 else input_num=nrow(input_file)
  
  info_file <- read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.vcf", sep=''),header=F)
  dbs <- rbind(dbs,list(file_list[,2][i],nrow(input_file),nrow(info_file)))
  rownames(dbs)[i] <- file_list[,1][i]
}
dbs <- dbs[-1,]
dbs

file_list <- read.table("00_9_breast21.sh")
for (i in 2:21){
  input_file <- tryCatch(read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.cluster.vcf", sep=''),header=F),error=function(e) as.data.frame(matrix(c('no','line'),nrow=1)))
  if (nrow(input_file) == 1) input_num=0 else input_num=nrow(input_file)
  
  info_file <- read.table(paste(file_list[,1][i],"_union_2.readinfo.readc.rasmy_pon.filter1.mreadc.mrasmy.filter2.none_to_clonal.vcf", sep=''),header=F)
  dbs <- rbind(dbs,list(file_list[,2][i],nrow(input_file),nrow(info_file)))
  rownames(dbs)[i] <- file_list[,1][i]
}
nrow(dbs)
dbs
par(mfrow=c(1,2))
par(mfrow=c(1,1))
#absolute number
plot(dbs$Dose[1:14],dbs$numberofclustered[1:14],ylim=c(0,50),col='red',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='The number of SNPs',pch=16)
plot(dbs$Dose[15:42],dbs$numberofclustered[15:42],ylim=c(0,50),col='blue',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='The number of SNPs',pch=16)
plot(dbs$Dose[43:62],dbs$numberofclustered[43:62],ylim=c(0,50),col='black',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='The number of SNPs',pch=16)

#ratio
plot(dbs$Dose[1:14],as.numeric(dbs$numberofclustered[1:14])/as.numeric(dbs$Totalnone_to_clonalmutations[1:14]),ylim=c(0,0.05),col='red',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16)
plot(dbs$Dose[15:42],as.numeric(dbs$numberofclustered[15:42])/as.numeric(dbs$Totalnone_to_clonalmutations[15:42]),ylim=c(0,0.05),col='blue',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16)
plot(dbs$Dose[43:62],as.numeric(dbs$numberofclustered[43:62])/as.numeric(dbs$Totalnone_to_clonalmutations[43:62]),ylim=c(0,0.05),col='black',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16)

par(mfrow=c(1,3))
#absolute number
boxplot(as.numeric(dbs$numberofclustered[1:14]) ~ as.numeric(dbs$Dose[1:14]),ylim=c(0,50),col='red',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='abs. number',pch=16,pars = list(boxwex=0.5),border='red')
boxplot(as.numeric(dbs$numberofclustered[15:42]) ~ as.numeric(dbs$Dose[15:42]),ylim=c(0,50),col='blue',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='abs. number',pch=16,pars = list(boxwex=0.5),border='blue')
boxplot(as.numeric(dbs$numberofclustered[43:62]) ~ as.numeric(dbs$Dose[43:62]),ylim=c(0,50),col='black',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='abs. number',pch=16,pars = list(boxwex=0.5))

#ratio
boxplot(as.numeric(dbs$numberofclustered[1:14])/as.numeric(dbs$Totalnone_to_clonalmutations[1:14]) ~ as.numeric(dbs$Dose[1:14]),ylim=c(0,0.05),col='red',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16,pars = list(boxwex=0.5),border='red')
boxplot(as.numeric(dbs$numberofclustered[15:42])/as.numeric(dbs$Totalnone_to_clonalmutations[15:42]) ~ as.numeric(dbs$Dose[15:42]),ylim=c(0,0.05),col='blue',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16,pars = list(boxwex=0.5),border='blue')
boxplot(as.numeric(dbs$numberofclustered[43:62])/as.numeric(dbs$Totalnone_to_clonalmutations[43:62]) ~ as.numeric(dbs$Dose[43:62]),ylim=c(0,0.025),col='black',main='none_to_clonal_invitro clustered snps',xlab='Radiation dose', ylab='Ratio (dbs/total)',pch=16,pars = list(boxwex=0.5))
