setwd("~/06_mm10_SNUH_radiation/21_RSEM")
#devtools::install_github("hadley/tidyverse")
#if (!requireNamespace("BiocManager", quietly = TRUE))
  #install.packages("BiocManager")
BiocManager::install("tximport", version = "3.8")
library(tximport)
library(tidyverse)
library("readr")
BiocManager::install("tximportData")
library("tximportData")
dir <- system.file("extdata", package="tximportData")
dir
samples <- read.table(file.path(dir,"samples.txt"), header=TRUE)
head(samples)
samples$condition <- factor(rep(c("A","B"),each=3))
rownames(samples) <- samples$run
samples[,c("pop","center","run","condition")]
files <- file.path(dir,"salmon", samples$run, "quant.sf.gz")
files %>% head()
names(files) <- samples$run
tx2gene <- read_csv(file.path(dir, "tx2gene.gencode.v27.csv"))
head(tx2gene)
txi <- tximport(files, type="salmon", tx2gene=tx2gene)
head(txi)
ddsTxi <- DESeqDataSetFromTximport(txi,
                                   colData = samples,
                                   design = ~ condition)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2", version = "3.8")
BiocManager::install("copynumber", version = "3.8")
nlibrary(DESeq2)
library("copynumber")
require("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design= ~ batch + condition)
dds <- DESeq(dds)
resultsNames(dds) # lists the coefficients
res <- results(dds, name="condition_trt_vs_untrt")
# or to shrink log fold changes association with condition:
res <- lfcShrink(dds, coef="condition_trt_vs_untrt", type="apeglm")
R --version
version


if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")
install.packages("readtext")
install.packages("devtools")
devtools::install_github('kevinblighe/EnhancedVolcano')


###TPM of Myc in mfallopian tube sample
bfb<-c(185.31,162.25,128.76)
con<-c(54.86,55.30,58.82)
t.test(bfb,con)
wilcox.test(bfb,con)
summary(bfb)
summary(con)
mean(bfb)/mean(con)

#difference using Myc count of DESeq data 
bfb_count<-c(3105.00,2992.00,2237.00)
control_count<-c(1094.00,1031.00,975.00)
t.test(bfb_count,control_count)
summary(bfb_count)

boxplot(con,bfb,ylim=c(0,200),names = c("control","mm_study4_fallopian_tube_SO2"),ylab= "TPM",boxwex=0.25)
stripchart(list(con,bfb),vertical = TRUE, 
           method = "jitter", add = TRUE, pch = 20, col = alpha('black',0.2))

con_ci<-1.96*sd(con)/sqrt(3)
bfb_ci<-1.96*sd(bfb)/sqrt(3)

pdf("BFB_Myc_TPM.pdf")
barplot(c(mean(con),mean(bfb)),space = 10,ylim=c(0,200),border = F,names.arg = c("control","mm_study4_fallopian_tube_SO2"),ylab= "TPM",col='gray')
arrows(10.5,mean(con)-con_ci,10.5,mean(con)+con_ci,length = 0.1,angle=90,code=3,col = alpha('gray',1),lwd = 2)
arrows(21.5,mean(bfb)-con_ci,21.5,mean(bfb)+con_ci,length = 0.1,angle=90,code=3,col = alpha('gray',1),lwd=2)
dev.off()

rc_del$number<-table(total_sv$experiment)
frc_del$ci<-1.96*frc_del$sd/sqrt(frc_del$number)
frc_del$se<-frc_del$sd/sqrt(frc_del$number)

arrows(c(1,2,3),frc_radio$mean-frc_radio$se,c(1,2,3),frc_radio$mean+frc_radio$se,length = 0.05,angle=90,code=3,col = alpha('black',1))



###mfallopian tube DEG####
#set working directory
setwd("~/06_mm10_SNUH_radiation/21_RSEM")
rm(list=ls())

library(DESeq2)
library(tximport)
#BiocManager::install("tximport")
library(tidyverse)
library(NMF)
#library(tibble)
#install.packages("NMF")

#rm(list=ls())

samples <- matrix(c('BFB-1','BFB-2','BFB-3','control-R','control-F','control-B'),ncol = 1)
samples <- samples %>% as.data.frame()
samples$condition <- rep(c('BFB','control'),each=3)
samples
files <- file.path(paste(samples$V1,"_rsem.genes.results",sep=""))
names(files) <- samples$V1

txi <- tximport(files,type = 'rsem',txIn=FALSE,txOut = FALSE)
str(txi)
txi$length[txi$length == 0] <- 1 
samples <- samples %>% as.data.frame() %>% column_to_rownames('V1')
samples
dds <- DESeqDataSetFromTximport(txi, colData = samples, design =  ~condition)
dds
keep <- rowSums(counts(dds)) >= 10 # for saving memory
dds <- dds[keep,] 
dds$condition <- relevel(dds$condition, ref = "control")
dds <- DESeq(dds)
res <- results(dds,tidy=TRUE)

#vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)

biomart <- read.table("~/06_mm10_SNUH_radiation/21_RSEMmart_export.txt",sep='\t',header = T)
head(biomart)
res
res21 <- res %>% mutate(sig=padj<0.05) %>% tbl_df()
colnames(res21)[1] <- "row"
res22 <- res21 %>% arrange(padj) %>% left_join(biomart, by = c("row"="Gene.stable.ID.1"))
biomart <- biomart[,c(3,4,1,2)]
biomart
res21
write.table(res22,"BFB_mouse_fallopian_DESeq2_result.txt",sep='\t')

table(is.na(res22$Gene.name))

# supervised heatmap using aheatmap function
pdf("Heatmap.pdf")
aheatmap(assay(rld)[arrange(res21, padj, pvalue)$row[1:50], ], labRow =  arrange(res21, padj, pvalue)$'Gene name'[1:50], scale="row", 
         distfun="euclidean", annCol=select(samples,condition), col=c("green","black","black","red"))
aheatmap(assay(rld)[arrange(res21, padj, pvalue)$row[1:50], ], labRow =  arrange(res21, padj, pvalue)$'Gene name'[1:50], scale="none", 
         distfun="euclidean", annCol=select(samples,condition), col=c("green","black","black","red"))
dev.off()

?aheatmap
?dist

# plotCounts per a gene
plotCounts(dds2,gene="ENSMUSG00000017146", intgroup = "condition",main = 'Brca1')
plotCounts(dds2,gene="ENSMUSG00000041147", intgroup = "condition",main = 'Brca2')
plotCounts(dds2,gene="ENSMUSG00000059552", intgroup = "condition",main = 'Trp53')
plotCounts(dds2,gene="ENSMUSG00000026187", intgroup = "condition",main = 'Xrcc5')

# volcano plot using ggplot2
res21 %>% ggplot(aes(log2FoldChange, -1*log10(pvalue), col=sig)) + geom_point() + ggtitle("Volcano plot")
res21 %>% ggplot(aes(baseMean, -1*log10(pvalue), col=sig)) + geom_point() + ggtitle("Volcano plot")