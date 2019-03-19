require(tidyverse)
require(readtext)

## Initiation of q-arms
#inipos = 124535434	# chr1
#inipos = 95326171	# chr2
#inipos = 93504854	# chr3
#inipos = 52660117	# chr4
#inipos = 49405641	# chr5
#inipos = 61830166	# chr6
#inipos = 61054331	# chr7
#inipos = 46838887	# chr8
#inipos = 50367679	# chr9
#inipos = 61632012	# chrX
#inipos = 13104553	# chrY
#inipos = 42254935	# chr10
#inipos = 54644205	# chr11
#inipos = 37856694	# chr12
#inipos = 19000000	# chr13
#inipos = 19000000	# chr14
#inipos = 20000000	# chr15
#inipos = 38335801	# chr16
#inipos = 25263006	# chr17
#inipos = 18460898	# chr18
#inipos = 27681782	# chr19
#inipos = 29369569	# chr20
#inipos = 14288129	# chr21
#inipos = 16000000	# chr22

## End of q-arms
chr1_q_endpos = 249250621	#chr1
chr2_q_endpos = 243199373	#chr2
chr3_q_endpos = 198022430	#chr3
chr4_q_endpos = 191154276	#chr4
chr5_q_endpos = 180915260	#chr5
chr6_q_endpos = 171115067	#chr6
chr7_q_endpos = 159138663	#chr7
chrX_q_endpos = 155270560	#chrX
chr8_q_endpos = 146364022	#chr8
chr9_q_endpos = 141213431	#chr9
chr10_q_endpos = 135534747	#chr10
chr11_q_endpos = 135006516	#chr11
chr12_q_endpos = 133851895	#chr12
chr13_q_endpos = 115169878	#chr13
chr14_q_endpos = 107349540	#chr14
chr15_q_endpos = 102531392	#chr15
chr16_q_endpos = 90354753	#chr16
chr17_q_endpos = 81195210	#chr17
chr18_q_endpos = 78077248	#chr18
chr20_q_endpos = 63025520	#chr20
chrY_q_endpos = 59373566	#chrY
chr19_q_endpos = 59128983	#chr19
chr22_q_endpos = 51304566	#chr22
chr21_q_endpos = 48129895	#chr21

## End of the p-arms
#endpos = 121535434	# chr1
#endpos = 92326171	# chr2
#endpos = 90504854	# chr3
#endpos = 49660117	# chr4
#endpos = 46405641	# chr5
#endpos = 58830166	# chr6
#endpos = 58054331	# chr7
#endpos = 43838887	# chr8
#endpos = 47367679	# chr9
#endpos = 58632012	# chrX
#endpos = 10104553	# chrY
#endpos = 39254935	# chr10
#endpos = 51644205	# chr11
#endpos = 34856694	# chr12
#endpos = 16000000	# chr13
#endpos = 16000000	# chr14
#endpos = 17000000	# chr15
#endpos = 35335801	# chr16
#endpos = 22263006	# chr17
#endpos = 15460898	# chr18
#endpos = 24681782	# chr19
#endpos = 26369569	# chr20
#endpos = 11288129	# chr21
#endpos = 13000000	# chr22

#requires!
#colnames(cninfo) = c("chr", "pos", "abscn")
#colnames(svinfo) = c("chr1", "pos1", "chr2", "pos2", "ori", "type")
#ori example: 3to3, 3to5, ...
#type example: DEL, DUP, TRA, INV

draw_svsketch <- function(cninfo, svinfo, chri, inipos, endpos){
  cninfo$id = paste(cninfo$chr, cninfo$pos, sep=":")
  
  ### Load and parse the SV information for driver chain (from dchain file)
  isv <- svinfo
  isv$group[isv$type=="DEL"] = 1
  isv$group[isv$type=="DUP"] = 2
  isv$group[isv$type=="TRA"] = 5
  isv$group[isv$type=="unknown"] = 6
  isv$group[isv$type=="INV" & isv$ori == "5to5"] = 3
  isv$group[isv$type=="INV" & isv$ori == "3to3"] = 4
  isv$svid = paste(isv$chr1, isv$pos1, isv$group, sep=":")
  isv$svid2 = paste(isv$chr2, isv$pos2, isv$group, sep=":")
  isv$chrpos1 = paste(isv$chr1, isv$pos1, sep=":")
  isv$chrpos2 = paste(isv$chr2, isv$pos2, sep=":")
  ## Plotting SVs for chr4
  isvintra <- subset(isv, isv$chr1 == chri & isv$chr2 == chri)
  isvinter1 <- subset(isv, isv$chr1 == chri & isv$chr2 != chri)
  isvinter2 <- subset(isv, isv$chr1 != chri & isv$chr2 == chri)
  isvsingle <- subset(isv, (isv$chr1 == chri & is.na(pos2) == T) | (isv$chr2 == chri & is.na(pos1) == T))
  
  
  par(mar=c(5.1,4.1,10.1,2.1))
  k <<- max(cninfo$abscn[cninfo$chr==chri], na.rm=T)
  plot(cninfo$abscn[cninfo$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)] ~ cninfo$pos[cninfo$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)], pch=20, col=rgb(0,0,0,.7), ylim=c(0,1.1*k), xlim = c(inipos, endpos), ylab="Absolute CN", xlab=paste0("Positions on chromosome ", chri), frame=F, xaxt = "n")
  axis(1, at = cninfo$pos[cninfo$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)]%/%10000000*10000000)
  ## Breakpoints
  ### DELETIONS (blue)
  if (length(isvintra$svid[isvintra$group==1]) != 0){
    segments(isvintra$pos1[isvintra$group==1], 0, isvintra$pos1[isvintra$group==1], k*1.6, lty=1, xpd=TRUE, col=rgb(0,0,255/255,.4))
    segments(isvintra$pos2[isvintra$group==1], 0, isvintra$pos2[isvintra$group==1], k*1.6, lty=1, xpd=TRUE, col=rgb(0,0,255/255,.4))
  }
  ### TANDEM DUPLICATIONS (green)
  if (length(isvintra$svid[isvintra$group==2]) != 0){
    segments(isvintra$pos1[isvintra$group==2], 0, isvintra$pos1[isvintra$group==2], k*1.6, lty=1, xpd=TRUE, col=rgb(110/255,139/255,61/255,.4))
    segments(isvintra$pos2[isvintra$group==2], 0, isvintra$pos2[isvintra$group==2], k*1.6, lty=1, xpd=TRUE, col=rgb(110/255,139/255,61/255,.4))
  }
  ### HEAD-TO-HEAD INVERSIONS (red)
  if (length(isvintra$svid[isvintra$group==3]) != 0){
    segments(isvintra$pos1[isvintra$group==3], 0, isvintra$pos1[isvintra$group==3], k*1.3, lty=1, xpd=TRUE, col=rgb(255/255,0,0,.4))
    segments(isvintra$pos2[isvintra$group==3], 0, isvintra$pos2[isvintra$group==3], k*1.3, lty=1, xpd=TRUE, col=rgb(255/255,0,0,.4))
  }
  ### TAIL-TO-TAIL INVERSIONS (orange)
  if (length(isvintra$svid[isvintra$group==4]) != 0){
    segments(isvintra$pos1[isvintra$group==4], 0, isvintra$pos1[isvintra$group==4], k*1.3, lty=1, xpd=TRUE, col=rgb(255/255,128/255,0,.4))
    segments(isvintra$pos2[isvintra$group==4], 0, isvintra$pos2[isvintra$group==4], k*1.3, lty=1, xpd=TRUE, col=rgb(255/255,128/255,0,.4))
  }
  ### INTERCHROMOSOMAL TRANSLOCATIONS (purple)
  if (length(isvinter1$svid[isvinter1$group==5]) != 0){
    segments(isvinter1$pos1[isvinter1$group==5], 0, isvinter1$pos1[isvinter1$group==5], k*1.9, lty=1, xpd=TRUE, col=rgb(75/255,0/255,130/255,.4))
    for (i in 1:length(isvinter1$pos1)){
      text(x = isvinter1$pos1[isvinter1$group==5][i], y = k*1.1, labels = isvinter1$chrpos2[i], cex =0.5)
    }
  }
  if (length(isvinter2$svid[isvinter2$group==5]) != 0){
    segments(isvinter2$pos2[isvinter2$group==5], 0, isvinter2$pos2[isvinter2$group==5], k*1.9, lty=1, xpd=TRUE, col=rgb(75/255,0/255,130/255,.4))
    for (i in 1:length(isvinter2$pos2)){
      text(x = isvinter2$pos2[isvinter2$group==5][i], y = k*1.1, labels = isvinter2$chrpos1[i], cex =0.5)
    } 
  }
  
  ### Unknown mate(single) (gray)
  if (length(isvsingle$svid) != 0){
    segments(isvsingle$pos1, 0, isvsingle$pos1, k*1.9, lty=1, xpd=TRUE, col=rgb(96/255,96/255,96/255,.4))
    segments(isvsingle$pos2, 0, isvsingle$pos2, k*1.9, lty=1, xpd=TRUE, col=rgb(96/255,96/255,96/255,.4))
  }
  
  
  ## Horizontal Lines for Formatting
  segments(inipos,k*1.3,endpos,k*1.3, col=rgb(0,0,0,.4), lty=1, xpd=TRUE)
  segments(inipos,k*1.6,endpos,k*1.6, col=rgb(0,0,0,.4), lty=1, xpd=TRUE)
  segments(inipos,k*1.9,endpos,k*1.9, col=rgb(0,0,0,.4), lty=1, xpd=TRUE)
  
  theta=seq(0,pi, len=100)
  if (nrow(isvintra) !=0 ){
    isvintra$rad=abs(isvintra$pos2-isvintra$pos1)/2
    deldf <- isvintra[isvintra$group==1,]
    dupdf <- isvintra[isvintra$group==2,]
    hhidf <- isvintra[isvintra$group==3,]
    ttidf <- isvintra[isvintra$group==4,]
  }
  ## DELETIONS
  if (length(isvintra$svid[isvintra$group==1])!=0){
    for (j in seq(1,length(unique(deldf$svid)),1)){
      x = deldf$rad[j]*cos(theta)+((deldf$pos1[j]+deldf$pos2[j])/2)
      y = k*0.1*sin(theta)+k*1.6
      lines(x,y,col=rgb(0,0,255/255,.4), xpd=TRUE)
    }
  }
  
  ## DUPLICATIONS
  if (length(isvintra$svid[isvintra$group==2])!=0){
    for (j in seq(1,length(unique(dupdf$svid)),1)){
      x = dupdf$rad[j]*cos(theta)+((dupdf$pos1[j]+dupdf$pos2[j])/2)
      y = -k*0.1*sin(theta)+k*1.6
      lines(x,y,col=rgb(110/255,139/255,61/255,.4), xpd=TRUE)
    }
  }
  
  ## HEAD-TO-HEAD INVERSIONS
  if (length(isvintra$svid[isvintra$group==3])!=0){
    for (j in seq(1,length(unique(hhidf$svid)),1)){
      x = hhidf$rad[j]*cos(theta)+((hhidf$pos1[j]+hhidf$pos2[j])/2)
      y = k*0.1*sin(theta)+k*1.3
      lines(x,y,col=rgb(255/255,0,0,.4), xpd=TRUE)
    }
  }
  
  ## TAIL-TO-TAIL INVERSIONS
  if (length(isvintra$svid[isvintra$group==4])!=0){
    for (j in seq(1,length(unique(ttidf$svid)),1)){
      x = ttidf$rad[j]*cos(theta)+((ttidf$pos1[j]+ttidf$pos2[j])/2)
      y = -k*0.1*sin(theta)+k*1.3
      lines(x,y,col=rgb(255/255,128/255,0,.4), xpd=TRUE)
    }
  }
}




#########################
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/")
fusiongene_dt <- read_tsv('FusionGene_driverSVclass.txt')
fusiongene_dt <- fusiongene_dt %>% filter(is.na(Sample) == F)

setwd("C:/Users/USER/OneDrive - kaist.ac.kr/Documents/KAIST/Lab files/01_MyProjects/03_LUAD_SV/06_Final_data/05_smoothened_CN/01_Fusion")
filelist = readtext('./*.absCN')$doc_id
idlist <- sapply(filelist, function(x) unlist(strsplit(x,"\\."))[1])


### J.Youk
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/")
isv <- read.csv("S1-2Gy-2.delly.somatic.vcf.BPinfo4.filter1.rearrange.SVvaf.dellyVaf",header=F,as.is=T,sep='\t')
isv
#isv <- isv %>% filter(cluster == 0)
isv <- isv[,c(1:7)]
colnames(isv) <- c("chr1", "pos1", "chr2", "pos2", "mh", "ori", "type")
#isv <- isv %>% 
  #mutate(chr1 = as.integer(chr1), pos1 = as.integer(pos1), chr2 = as.integer(chr2), pos2 = as.integer(pos2)) %>%
  #mutate(type = ifelse(is.na(pos2) == T, "unknown", type))

setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/")
cninfofull <- read.csv("S1-2Gy-2.mpileup.100kbcov.absCN", header=F, as.is=T, sep="\t")
cninfofull <- cninfofull[c(5:28533),]
colnames(cninfofull) <- c("chr", "pos", "nd", "td", "abscn")
cninfofull

pdf(file = "/home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/unbal_inv.pdf")
draw_svsketch(cninfofull, isv, 11, 20000000, 21000000 )
dev.off()
#######################################################


for (tnm in idlist){
  print(tnm)
  
  setwd("C:/Users/USER/OneDrive - kaist.ac.kr/Documents/KAIST/Lab files/01_MyProjects/03_LUAD_SV/06_Final_data/05_smoothened_CN/01_Fusion")
  cninfofull <- read.csv(paste0(tnm, ".mpileup.100kbcov.absCN"), header=F, as.is=T, sep="\t")
  cninfofull <- cninfofull[c(5:28533),]
  colnames(cninfofull) <- c("chr", "pos", "nd", "td", "abscn")
  setwd("C:/Users/USER/OneDrive - kaist.ac.kr/Documents/KAIST/Lab files/01_MyProjects/03_LUAD_SV/06_Final_data/03_SVs/01_Fusion")
  isv <- read_tsv(paste0(tnm,".sv_gap_seg"))
  isv <- isv %>% filter(cluster == 0)
  isv <- isv[,c(1:7)]
  colnames(isv) <- c("chr1", "pos1", "chr2", "pos2", "mh", "ori", "type")
  isv <- isv %>% 
    mutate(chr1 = as.integer(chr1), pos1 = as.integer(pos1), chr2 = as.integer(chr2), pos2 = as.integer(pos2)) %>%
    mutate(type = ifelse(is.na(pos2) == T, "unknown", type))
  
  setwd("C:/Users/USER/OneDrive - kaist.ac.kr/Documents/KAIST/Lab files/01_MyProjects/03_LUAD_SV/07_Figures_Rscripts/driver_chain_yilong_plot_spark")
  chromolist <- union(isv$chr1[is.na(isv$chr1) == F], isv$chr2[is.na(isv$chr2) == F])
  for (chromo in chromolist){
    isv %>% filter(chr1 == chromo) %>% .$pos1 -> a
    isv %>% filter(chr2 == chromo & is.na(pos2)==F) %>% .$pos2 -> b
    endpos <- get(paste0('chr',chromo,'_q_endpos'))
    poslist <- as.numeric(union(a,b))
    margin = 10000000
    startpos <-  max(min(poslist)-margin,0)
    endpos <- min(max(poslist)+margin, endpos)
    xscale <- endpos-startpos
    pdf(paste0(tnm, ".svsketch.chr", chromo, ".", Sys.Date(), ".pdf"), height=5, width=xscale/5000000)
    draw_svsketch(cninfofull, isv, chromo, startpos, endpos )
    if (chromo == fusiongene_dt$chr1[fusiongene_dt$Sample == tnm]){
      segments(fusiongene_dt$start1[fusiongene_dt$Sample == tnm],0,fusiongene_dt$end1[fusiongene_dt$Sample == tnm],0, col="red", lty=1, lwd = 5, xpd=TRUE)
      text(x =fusiongene_dt$end1[fusiongene_dt$Sample == tnm]+1000000, y = 0, labels = fusiongene_dt$fusion_gene1[fusiongene_dt$Sample == tnm], cex =0.5)
    }
    if (chromo == fusiongene_dt$chr2[fusiongene_dt$Sample == tnm]){
      segments(fusiongene_dt$start2[fusiongene_dt$Sample == tnm],0,fusiongene_dt$end2[fusiongene_dt$Sample == tnm],0, col="red", lty=1, lwd = 5, xpd=TRUE)
      text(x =fusiongene_dt$end2[fusiongene_dt$Sample == tnm] + 1000000, y = 0, labels = fusiongene_dt$fusion_gene2[fusiongene_dt$Sample == tnm], cex =0.5)
    }
    dev.off()
  }
}
#setwd("C:/Users/USER/OneDrive - kaist.ac.kr/Documents/KAIST/Lab files/01_MyProjects/03_LUAD_SV/07_Figures_Rscripts/Case_plot/driver_plot")
#pdf(paste0(tnm, ".svsketch.chr", chri, ".pdf"), height=5, width=16)

cninfo <- cninfofull
svinfo <- isv
chri <- chromo
inipos <- startpos
endpos <- endpos

plot(cninfo$abscn[cninfo$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)] ~ cninfo$pos[cninfo$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)], pch=20, col=rgb(0,0,0,.7), ylim=c(0,1.1*k), xlim = c(inipos, endpos), ylab="Absolute CN", xlab=paste0("Positions on chromosome ", chri), frame=F, xaxt = "n")
axis(1, at = cninfo$pos[cninfo$chr==chri & (cninfo$pos > inipos & cninfo$pos < endpos)]%/%10000000*10000000)
dev.off()
