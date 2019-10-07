library(tidyverse)
library(ggplot2)
library(extrafont)
library(sequenza)
library(lattice)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter")

#install.packages("extrafont")
#Deletion size distribution
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

#Simple statistical test
shapiro.test(control$size)
shapiro.test(irradi$size)
# reject 'Normal distribution'
wilcox.test(log10(control$size),log10(irradi$size)) # p>0.05

### SSDI size distribution
ssdi_list <- read.table("SSDI_size_127.txt",header=T,sep='\t')
ssdi_size <- log10(ssdi_list$Size)
ssdi_size
breaks = seq(1,8,by=0.5)
ssdi_cut <- cut(ssdi_size,breaks,right=F)
ssdi_freq = table(ssdi_cut)
ssdi_freq
ssdi_cum <- c(0,cumsum(ssdi_freq))/22
ssdi_cum

pdf("SSDI_Size_Distribution.pdf")
dev.new(family = "Arial")
plot(breaks,ssdi_cum,main="SSDI Size Distribution (N=22)",xlab="Size of segmental deletion (bp)",ylab="Cumulative probability",pch=20)
lines(breaks,ssdi_cum)
lines(c(1,3),c(0.8181818,0.8181818),lty=3)
lines(c(3,3),c(0,0.8181818),lty=3)
dev.off()


c<-c()
for(i in 1:100000){
a<-sample(x=1:100000000,size=2,replace = T)
b<-abs(a[1]-a[2])
c<-c(c,b)
}
c

expected_hist<-hist(log10(c),xlim=c(0,8),breaks = 500)
expected_hist$density
plot(expected_hist$breaks[-1],cumsum(expected_hist$density)/100,pch=20,xlab="Size of balanced inversion (bp)",ylab='Cumulative probability',main = "Expected Size Distribution")
cumsum(expected_hist$density)


L <- 100000000 ## length of chromosome
M <- 100000 ## number of simulations
X1 <- runif(M, 1, L)
X2 <- runif(M, 1, L)
D <- X1-X2
hist(abs(D), 10000, probability = T)


fx <- function (d) { 2/L*(1-(d)/L)}
dxx <- seq(1, L, length.out = 100000)
fxx <- sapply(dxx, fx)
plot(dxx, fxx, main="theoretical fx")



### Bal. INV size distribution
inv_list <- read.table("INV_size_127.txt",header=T,sep='\t')
inv_size <- log10(inv_list$Size)
breaks = seq(1,8,by=0.5)
inv_cut <- cut(inv_size,breaks,right=F)
inv_freq = table(inv_cut)
inv_cum <- c(0,cumsum(inv_freq))/204
inv_cum
pdf("INV_Size_Distribution.pdf")
plot(breaks,inv_cum,main="Balanced Inversion Size Distribution (N=102)",xlab="Size of balanced inversion (bp)",ylab="Cumulative probability",pch=20,ylim=c(0,1))
lines(breaks,inv_cum)
lines(c(3,3),c(0,0.058823529),lty=3)
lines(c(1,3),c(0.058823529,0.058823529),lty=3)
dev.off()

# Bal. TRA same chromosome
a<-matrix(c(6,47,1,38),nrow = 2)
a
fisher.test(a)


######### Size distribution
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/51_Cancer_Data")
input_file <- read.table("SSDI_selection_from_my_sample_same_strategy_6positions.txt", header=T)
additional_file <- as.data.frame(matrix(c(30725633,30725648,30725711,30725718,0,0,
                                          10059416,10059432,10059710,10059719,0,0,
                                          56106651,56106651,56107453,56107456,0,0),ncol = 6,byrow = T)) ####for repetitive & chromoplexy SSDI
additional_file
additional_file$V4 - additional_file$V1
additional_file$V3 - additional_file$V2
colnames(additional_file) <- colnames(input_file)
final_file <- rbind(input_file,additional_file)
final_file
ssdi_size <- final_file$del5 - final_file$del3
ssdi_size



#expected value of size distribution (random sampling)
L <- 100000000 ## length of chromosome
M <- 1000 ## number of simulations
X1 <- runif(M, 1, L)
X2 <- runif(M, 1, L)
D <- X1-X2
expected_size <- D

hist(abs(D), 10000, probability = T)

wilcox.test(log10(ssdi_size),log10(expected_size))
ks.test(log10(ssdi_size),log10(expected_size))

ks.test(ssdi_size,expected_size)


info_file <- read.table("INV_selection_from_my_sample_rearrange.txt",header=F)
inv_size <- info_file$V5 - info_file$V2
hist(inv_size)

ks.test(log10(ssdi_size),log10(inv_size))
ks.test(log10(inv_size),log10(expected_size))
inv_size


ssdi_size_sort<- sort(ssdi_size)
y_sort<-c(1/29*1:29)
y_sort

ex_y_sort<-c(1/1000*1:1000)
ex_y_sort

pdf(file = "Size_distribution_190930_1000.pdf")
plot(log10(ssdi_size_sort),y_sort,xlim=c(1.5,8.5),ylim=c(0,1),col='red2',cex=0.3)
lines(log10(ssdi_size_sort),y_sort,ylim=c(0,1),col='red2')
points(log10(sort(inv_size)),c(1/130*1:130), col = "blue2",cex=0.3)
lines(log10(sort(inv_size)),c(1/130*1:130), col = "blue2")
points(log10(sort(abs(expected_size))),ex_y_sort,col="gray50",cex=0.3)
lines(log10(sort(abs(expected_size))),ex_y_sort,col="gray50")
lines(c(1.5,3),c(0.68965517,0.68965517),lty=3,col='red')
lines(c(3,3),c(0,0.68965517),lty=3,col='red')
legend(2,1,c("SST","Bal. INV.","Expected length"),col=c('red','blue','gray50'),lty=1,pch=19)
dev.off()

######SST gap size distribution
gap1<-final_file$seg5 - final_file$del3
gap2<-final_file$del5 - final_file$seg3
gap3<-final_file$ins5 - final_file$ins3
length(gap3)
gap3<-gap3[1:26]
total_gap <- c(gap1,gap2,gap3)
length(total_gap)
hist(total_gap,right = F,breaks = seq(-5,55,by = 5))
summary(total_gap)
#shapiro.test(total_gap) non-parametric!
total_gap[total_gap>50]<-51
total_gap
78/86
29/2768
711-647

######SST microhomology
getwd()
mh_file <- read.table("SSDI_selection_from_my_sample_same_strategy_gap.txt",header=F)
mh<-c(mh_file$V6,0,0,2) #add 3 non-selected SSID deletion mh in my cohort
length(mh)
hist(mh,breaks = seq(-9.5,9.5,by = 1),right = F,probability = T,ylim=c(0,0.4))
length(mh[mh>0])
57/81
mh[mh>4]
73/81
74/81

