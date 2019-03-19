setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/")
sv<-matrix(c(0,1,2,2,4,8,0,1,8,9,6,12),ncol = 2)
head(sv)

png(filename = "/home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/number_sv.png",width=600,height = 600)
plot(sv,ylim=c(0,16),xlab="Radiation dose(Gy)",ylab="The number of rearrangements",pch=18,main="Structural Variations",cex=2)
dev.off()
