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
