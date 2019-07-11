library(tidyverse)
library(ggplot2)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter")
del_list <- read.table("127_deletion_size_all.txt",header=T,sep='\t')
del_list[1:10,]
nrow(del_list)

control <- del_list[del_list$dose<0.1,]
irradi <- del_list[del_list$dose>0.5,]

pdf("DEL_Size_Distribution.pdf")
hist(log10(control$size),probability=T,xlim=c(0,10), ylim=c(0,1),nclass=25,col='gray80',border='gray80', main = "Size distribution of simple deletions", xlab = "Deletion size (bp)")
lines(density(log10(control$size)),col='gray',xlim=c(0,10))
hist(log10(irradi$size),probability=T,xlim=c(0,10), ylim=c(0,1),nclass=25,col=rgb(0,0,1,0.2),border=rgb(0,0,1,0.2),add=T)
lines(density(log10(irradi$size)),col=rgb(0,0,1),xlim=c(0,10))
legend(6,0.8,c("control","irradiation with ≥1Gy"),col=c(rgb(1,0,0),rgb(0,0,1)),lty=1)
dev.off()

shapiro.test(control$size)
shapiro.test(irradi$size)
# reject 'Normal distribution'
wilcox.test(log10(control$size),log10(irradi$size)) # p>0.05
