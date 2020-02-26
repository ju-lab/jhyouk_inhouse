library(tidyverse)
#SV vs Dose

getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/")
#### compare using FACS sorting case

########## in vitro pancreas (0,1,2,4,8Gy one shot)
total_sv <- read.table("summary_156_v7.txt",header=T,sep='\t')
total_sv$"radiation-related" <- total_sv$Balanced.Inversion + total_sv$Balanced.Translocation + total_sv$Simple.Deletion...1Mb..1  + total_sv$Double.minutes + total_sv$SSDI + total_sv$X2Rearrangements.from..3DSBs + total_sv$X.2Rearrangements.from..3DSBs+  total_sv$Chromoplexy + total_sv$Chromothripsis + total_sv$BFB.cycles
total_sv$"complex" <- total_sv$X2Rearrangements.from..3DSBs + total_sv$X.2Rearrangements.from..3DSBs+  total_sv$Chromoplexy + total_sv$SSDI
total_sv$all_del <- total_sv$Simple.Deletion...1Mb.

total_sv <- total_sv %>% filter(experiment == 'A' | experiment == 'B')
total_sv$SampleID
total_sv <- total_sv[-2,] # non-clonal
total_sv <- total_sv[-7,] # non-clonal
total_sv <- total_sv[-40,] # 8Gy d/t 1 sample
total_sv[35:40,c(1,15:21)]
nrow(total_sv)
total_sv[36,]$`radiation-related`<-3
input_file

num_one <- table(total_sv$Dose)
one_inv<-as.data.frame(total_sv %>% group_by(Dose) %>% summarise(mean(Balanced.Inversion),median(Balanced.Inversion),sd(Balanced.Inversion)))
one_tra<-as.data.frame(total_sv %>% group_by(Dose) %>% summarise(mean(Balanced.Translocation),median(Balanced.Translocation),sd(Balanced.Translocation)))
#total_sv %>% group_by(Dose) %>% summarise(mean(SSDI),median(SSDI),sd(SSDI))
one_radio<-as.data.frame(total_sv %>% group_by(Dose) %>% summarise(mean(`radiation-related`),median(`radiation-related`),sd(`radiation-related`)))
one_del<-as.data.frame(total_sv %>% group_by(Dose) %>% summarise(mean(all_del),median(all_del),sd(all_del)))
one_complex<-as.data.frame(total_sv %>% group_by(Dose) %>% summarise(mean(complex),median(complex),sd(complex)))
#total_sv %>% group_by(Dose) %>% summarise(mean(Total),median(Total),sd(Total))

colnames(one_inv)<-c("Dose","mean","median","sd")
colnames(one_tra)<-c("Dose","mean","median","sd")
colnames(one_radio)<-c("Dose","mean","median","sd")
colnames(one_del)<-c("Dose","mean","median","sd")
colnames(one_complex)<-c("Dose","mean","median","sd")

one_radio$number<-num_one
one_radio$ci<-1.96*one_radio$sd/sqrt(one_radio$number)
one_radio$se<-one_radio$sd/sqrt(one_radio$number)

one_del$number<-num_one
one_del$ci<-1.96*one_del$sd/sqrt(one_del$number)
one_del$se<-one_del$sd/sqrt(one_del$number)


pdf(file="SVs_vs_dose_191227.pdf")
plot(one_radio$Dose,one_radio$mean, col = alpha('black',1), pch=20,ylim=c(0,4.5), main = "Radiation-related SVs vs radiation-dose at once", xlab = "Dose at once (Gy)", ylab = "Mean of structural variations")
lines(one_radio$Dose,one_radio$mean, col = alpha('black',1))
arrows(one_radio$Dose,one_radio$mean-one_radio$se,one_radio$Dose,one_radio$mean+one_radio$se,length = 0.05,angle=90,code=3,col = alpha('black',1))
points(one_inv$Dose,one_inv$mean,col=alpha('dodgerblue4',0.7), pch=20)
lines(one_inv$Dose,one_inv$mean, col = alpha('dodgerblue4',0.7),lty=2)
points(one_tra$Dose,one_tra$mean,col=alpha('bisque4',0.7), pch=20)
lines(one_tra$Dose,one_tra$mean,col=alpha('bisque4',0.7),lty=2)
legend(0.5,4,c("radiation-related SVs", "balanced inversions", "balanced translocations"),lty = c(1,2,2), pch=20, col=c(alpha('black',1),alpha('dodgerblue4',0.7),alpha('bisque4',0.7)))
dev.off()

#points(one_complex$Dose,one_complex$mean,col=alpha('red',0.7), pch=20)
#lines(one_complex$Dose,one_complex$mean,col=alpha('red',0.7),lty=2)

pdf("simple_del_dose.pdf")
plot(one_del$Dose,one_del$mean,col=alpha('lightskyblue4',1), pch=20,ylim=c(0,3.5), main = "Simple Deletions (<1Mb) vs radiation-dose at once", xlab = "Dose (at once)", ylab = "Mean number of simple deletions (<1Mb)")
lines(one_del$Dose,one_del$mean, col = alpha('lightskyblue4',1))
arrows(one_del$Dose,one_del$mean-one_del$se,one_del$Dose,one_del$mean+one_del$se,length = 0.05,angle=90,code=3,col = alpha('lightskyblue4',1))
dev.off()

#legend(0.5,4,c("radiation-related SVs", "balanced inversions", "balanced translocations"),lty = c(1,2,2))
#points(one_tra$Dose,one_3$mean,col=alpha('red',0.4), pch=20)


######### in vivo 8Gy (low dose, 2x4, 8x1)
total_sv <- read.table("summary_156_v2.txt",header=T,sep='\t')
total_sv$"radiation-related" <- total_sv$Balanced.Inversion + total_sv$Balanced.Translocation + total_sv$Simple.Deletion...1Mb..1  + total_sv$Double.minutes + total_sv$SSDI + total_sv$X2Rearrangements.from..3DSBs + total_sv$X.2Rearrangements.from..3DSBs+  total_sv$Chromoplexy + total_sv$Chromothripsis + total_sv$BFB.cycles
total_sv$all_del <- total_sv$Simple.Deletion...1Mb.

total_sv <- total_sv %>% subset(experiment == 'LA' | experiment == 'D24' | experiment == 'D81')
total_sv$SampleID
total_sv <- total_sv[-9,]



frc_inv<-total_sv %>% group_by(experiment) %>% summarise(mean(Balanced.Inversion),median(Balanced.Inversion),sd(Balanced.Inversion))
frc_tra<-total_sv %>% group_by(experiment) %>% summarise(mean(Balanced.Translocation),median(Balanced.Translocation),sd(Balanced.Translocation))
#total_sv %>% group_by(experiment) %>% summarise(mean(SSDI),median(SSDI),sd(SSDI))
#total_sv %>% group_by(experiment) %>% summarise(mean(Rearrangements.with..3DSBs),median(Rearrangements.with..3DSBs),sd(Rearrangements.with..3DSBs))
frc_radio<-total_sv %>% group_by(experiment) %>% summarise(mean(`radiation-related`),median(`radiation-related`),sd(`radiation-related`))
#total_sv %>% group_by(experiment) %>% summarise(mean(Total),median(Total),sd(Total))
frc_del<-total_sv %>% group_by(experiment) %>% summarise(mean(all_del),median(all_del),sd(all_del))

colnames(frc_inv)<-c("Dose","mean","median","sd")
colnames(frc_tra)<-c("Dose","mean","median","sd")
colnames(frc_radio)<-c("Dose","mean","median","sd")
colnames(frc_del)<-c("Dose","mean","median","sd")

frc_radio$number<-table(total_sv$experiment)
frc_radio$ci<-1.96*frc_radio$sd/sqrt(frc_radio$number)
frc_radio$se<-frc_radio$sd/sqrt(frc_radio$number)

frc_del$number<-table(total_sv$experiment)
frc_del$ci<-1.96*frc_del$sd/sqrt(frc_del$number)
frc_del$se<-frc_del$sd/sqrt(frc_del$number)

frc_inv <- frc_inv[c(3,2,1),]
frc_tra <- frc_tra[c(3,2,1),]
frc_radio <- frc_radio[c(3,2,1),]
frc_del<- frc_del[c(3,2,1),]

frc_radio 
frc_del
frc_radio$mean
pdf(file="SVs_vs_8fx.pdf")
plot(c(1,2,3),frc_radio$mean, col = alpha('black',1), pch=20,xlim=c(0.5,3.5),ylim=c(0,4.5), main = "Radiation-related SVs vs 8Gy fractions", xlab = "Fractions", ylab = "Mean number of structural variations")
lines(c(1,2,3),frc_radio$mean, col = alpha('black',1))
arrows(c(1,2,3),frc_radio$mean-frc_radio$se,c(1,2,3),frc_radio$mean+frc_radio$se,length = 0.05,angle=90,code=3,col = alpha('black',1))
points(c(1,2,3),frc_inv$mean,col=alpha('dodgerblue4',0.7), pch=20)
lines(c(1,2,3),frc_inv$mean, col = alpha('dodgerblue4',0.7),lty=2)
points(c(1,2,3),frc_tra$mean,col=alpha('bisque4',0.7), pch=20)
lines(c(1,2,3),frc_tra$mean,col=alpha('bisque4',0.7),lty=2)
#legend(0.5,2.5,c("radiation-related SVs", "balanced inversions", "balanced translocations"),lty = c(1,2,2), pch=20, col=c(alpha('black',1),alpha('dodgerblue4',0.7),alpha('bisque4',0.7)))
dev.off()

points(c(1,2,3),frc_del$mean,col=alpha('red',0.4), pch=20)

pdf("simple_del_fractions.pdf")
plot(c(1,2,3),frc_del$mean,col=alpha('lightskyblue4',1), pch=20,xlim=c(0.5,3.5),ylim=c(0,7.5), main = "Simple Deletions (<1Mb) vs 8Gy fractions", xlab = "Fractions", ylab = "Mean number of simple deletions (<1Mb)")
lines(c(1,2,3),frc_del$mean, col = alpha('lightskyblue4',1))
arrows(c(1,2,3),frc_del$mean-frc_del$se,c(1,2,3),frc_del$mean+frc_del$se,length = 0.05,angle=90,code=3,col = alpha('lightskyblue4',1))
dev.off()





########### in vitro pancreas & in vivo 2Gy multiple (2x1, 2x4, 2x10, 2x25)
total_sv <- read.table("summary_156_v2.txt",header=T,sep='\t')
total_sv$"radiation-related" <- total_sv$Balanced.Inversion + total_sv$Balanced.Translocation + total_sv$Simple.Deletion...1Mb..1  + total_sv$Double.minutes + total_sv$SSDI + total_sv$X2Rearrangements.from..3DSBs + total_sv$X.2Rearrangements.from..3DSBs+  total_sv$Chromoplexy + total_sv$Chromothripsis + total_sv$BFB.cycles
total_sv$all_del <- total_sv$Simple.Deletion...1Mb.

total_sv <- total_sv %>% subset(experiment == 'D24' | experiment == 'D20' | ((experiment == 'A'| experiment == 'B') & Dose == '2') | (experiment == 'H' & Dose == '50'))
total_sv$SampleID
total_sv <- total_sv[-17,]
total_sv$experiment[total_sv$experiment=='B']<-'A'
total_sv[,1:3]

multiple_inv<-total_sv %>% group_by(experiment) %>% summarise(mean(Balanced.Inversion),median(Balanced.Inversion),sd(Balanced.Inversion))
multiple_tra<-total_sv %>% group_by(experiment) %>% summarise(mean(Balanced.Translocation),median(Balanced.Translocation),sd(Balanced.Translocation))
#total_sv %>% group_by(experiment) %>% summarise(mean(SSDI),median(SSDI),sd(SSDI))
#total_sv %>% group_by(experiment) %>% summarise(mean(Rearrangements.with..3DSBs),median(Rearrangements.with..3DSBs),sd(Rearrangements.with..3DSBs))
multiple_radio<-total_sv %>% group_by(experiment) %>% summarise(mean(`radiation-related`),median(`radiation-related`),sd(`radiation-related`))
#total_sv %>% group_by(experiment) %>% summarise(mean(Total),median(Total),sd(Total))
multiple_del<-total_sv %>% group_by(experiment) %>% summarise(mean(all_del),median(all_del),sd(all_del))

colnames(multiple_inv)<-c("Dose","mean","median","sd")
colnames(multiple_tra)<-c("Dose","mean","median","sd")
colnames(multiple_radio)<-c("Dose","mean","median","sd")
colnames(multiple_del)<-c("Dose","mean","median","sd")

multiple_radio$number<-table(total_sv$experiment)
multiple_radio$ci<-1.96*multiple_radio$sd/sqrt(multiple_radio$number)
multiple_radio$se<-multiple_radio$sd/sqrt(multiple_radio$number)

multiple_del$number<-table(total_sv$experiment)
multiple_del$ci<-1.96*multiple_del$sd/sqrt(multiple_del$number)
multiple_del$se<-multiple_del$sd/sqrt(multiple_del$number)

multiple_inv

multiple_inv <- multiple_inv[c(1,3,2,4),]
multiple_tra <- multiple_tra[c(1,3,2,4),]
multiple_radio <- multiple_radio[c(1,3,2,4),]
multiple_del <- multiple_del[c(1,3,2,4),]

pdf(file="SVs_vs_2gy_multiple.pdf")
plot(c(1,2,3,4),multiple_radio$mean, col = alpha('black',1), pch=20,xlim=c(0.5,4.5),ylim=c(0,10), main = "Radiation-related SVs vs multiple times of 2Gy irradiation", xlab = "Number of irradiations", ylab = "Mean number of structural variations")
lines(c(1,2,3,4),multiple_radio$mean, col = alpha('black',1))
arrows(c(1,2,3,4),multiple_radio$mean-multiple_radio$se,c(1,2,3,4),multiple_radio$mean+multiple_radio$se,length = 0.05,angle=90,code=3,col = alpha('black',1))
points(c(1,2,3,4),multiple_inv$mean,col=alpha('dodgerblue4',0.7), pch=20)
lines(c(1,2,3,4),multiple_inv$mean, col = alpha('dodgerblue4',0.7),lty=2)
points(c(1,2,3,4),multiple_tra$mean,col=alpha('bisque4',0.7), pch=20)
lines(c(1,2,3,4),multiple_tra$mean,col=alpha('bisque4',0.7),lty=2)
#legend(1,6,c("radiation-related SVs", "balanced inversions", "balanced translocations"),lty = c(1,2,2), pch=20, col=c(alpha('black',1),alpha('dodgerblue3',0.4),alpha('bisque3',0.4)))
dev.off()

#points(c(1,2,3,4),multiple_del$mean,col=alpha('bisque3',0.4), pch=20)
pdf("simple_del_2gy_multiple_times.pdf")
plot(c(1,2,3,4),multiple_del$mean,col=alpha('lightskyblue4',1), pch=20,xlim=c(0.5,4.5),ylim=c(0,12), main = "Simple Deletions (<1Mb) vs multiple times of 2Gy irradiation", xlab = "Number of irradiations", ylab = "Mean number of simple deletions (<1Mb)")
lines(c(1,2,3,4),multiple_del$mean, col = alpha('lightskyblue4',1))
arrows(c(1,2,3,4),multiple_del$mean-multiple_del$se,c(1,2,3,4),multiple_del$mean+multiple_del$se,length = 0.05,angle=90,code=3,col = alpha('lightskyblue4',1))
#legend(1,6,"Simple Deletions < 1Mb",lty = 1, pch=20, col=alpha('lightskyblue4',1))
dev.off()


#simple test
a<-matrix(c(30,10,69,5),nrow=2,byrow = F)
a
chisq.test(a)



#SVs vs tissues
total_sv <- read.table("summary_127_nouse.txt",header=T,sep='\t')
total_sv$"radiation-related" <- total_sv$Balanced.Inversion + total_sv$Balanced.Translocation + total_sv$Simple.Deletion...1Mb..1  + total_sv$Direct_return + total_sv$Double.minutes + total_sv$SSDI + total_sv$Rearrangements.with..3DSBs + total_sv$Chromoplexy + total_sv$Chromothripsis + total_sv$BFB.cycles
total_sv$all_del <- total_sv$Simple.Deletion...1Mb.
total_sv[total_sv$Dose==0 & (total_sv$Experiment == 'E1' |total_sv$Experiment == 'E2') ,c(1,21)]


