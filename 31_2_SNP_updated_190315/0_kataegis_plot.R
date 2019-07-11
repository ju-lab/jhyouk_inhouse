# kataegis plot in interested regions.

snp_color <- function(ref,alt){
  if(ref == 'C'){
    if(alt == 'A'){
      return("skyblue")
    } else if(alt == 'G'){
      return("black")
    } else{
      return("red")
    }
  } else if(ref == 'G'){
    if(alt == 'T'){
      return("skyblue")
    } else if(alt == 'C'){
      return("black")
    } else{
      return("red")
    }    
  } else if(ref == 'T'){
    if(alt == 'A'){
      return("gray80")
    } else if(alt == 'C'){
      return("yellowgreen")
    } else{
      return("plum1")
    }
  } else{
    if(alt == 'T'){
      return("gray80")
    } else if(alt == 'G'){
      return("yellowgreen")
    } else{
      return("plum1")
    }
  }  
}

draw_kataegis <- function(clonalsnp,chr,pos_start,pos_end){
  snp <- clonalsnp[clonalsnp$chr == chr,]
  snp$prev_pos <- c(0,head(snp$pos,n=-1))
  snp$distance <- log10(snp$pos - snp$prev_pos)
  return(snp)
  snp$color <- NA
  for(i in 1:nrow(snp)){
    snp$color[i] <- snp_color(snp$ref[i],snp$alt[i])
  }
  
  
  plot(snp$pos[snp$pos>pos_start & snp$pos<pos_end],snp$distance[snp$pos>pos_start & snp$pos<pos_end],col = snp$color[snp$pos>pos_start & snp$pos<pos_end],pch=19,xlim=c(pos_start,pos_end),ylim = c(0,8),xaxt = "n", yxat="n",frame=F, ylab = "inter-mutation distance (log10 scale)",xlab="positions on chromosome",cex=0.7)
  
  axis(2, at = c(1,2,3,4,5,6,7,8))
  
  axis(1, at = seq(pos_start,pos_end,by = 10000000))
  
  #  plot(cninfo$abscn[clonalsnp$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)] ~ cninfo$pos[cninfo$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)], pch=20, col=rgb(0,0,0,.7), ylim=c(0,1.1*k), xlim = c(inipos, endpos), ylab="Absolute CN", xlab=paste0("Positions on chromosome ", chri), frame=F, xaxt = "n")
  
}

nrow(snp)

setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/31_2_SNP_updated_190315/")
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/GRCh37/31_SNP_annotation/")
clonalsnp <- read.csv("HBIR2-1_snp_true.vcf",header=F,as.is=T,sep='\t')
clonalsnp <- read.csv("mm_study4_fallopian_IR_SO2_snp_true.vcf",header=T,as.is=T,sep='\t')
clonalsnp <- clonalsnp[,c(1:5)]
colnames(clonalsnp) <- c("chr", "pos", "rs", "ref", "alt")

pdf("S1N2P15_2-6_chrX_kataegis.pdf")
draw_kataegis(clonalsnp, 12, 60000000, 122000000)
draw_kataegis(clonalsnp, 'X', 30000000, 171000000)
dev.off()

draw_kataegis(clonalsnp, 15, 1000000, 42000000)

draw_kataegis(clonalsnp, 14, 0, 80000000)
draw_kataegis(clonalsnp, 15, 0, 102000000)
par(mfrow=c(1,1))
draw_kataegis(clonalsnp, 1, 0, 202000000)

pdf("legend.pdf")
plot(1,1)
legend(1,1,c("C>A","C>G","C>T","T>A","T>C","T>G"),col = c("skyblue","black","red","gray80","yellowgreen","plum1"),pch=19,cex=0.7)
dev.off()
