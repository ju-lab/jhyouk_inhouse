library(tidyverse)
library(DiffBind)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/22_ATACseq/analysis/")
samples <- read_tsv("atac_seq_samples.txt")
samples

# Reading in the peaksets for determining occupancy
prmt1 <- dba(sampleSheet = as.data.frame(samples),
             config=data.frame(RunParallel=TRUE, reportInit="DBA", DataType=DBA_DATA_GRANGES,
                               AnalysisMethod=DBA_DESEQ2, minQCth=15, fragmentSize=125,
                               bCorPlot=FALSE, th=0.05, bUsePval=FALSE))
?dba
prmt1
class(prmt1)
view(dba)

dba.plotHeatmap(prmt1,correlations = T) # using peak (bigBed file, so all contro data have same peak occupancy. no meaningful heatmap.)
dba.plotHeatmap(prmt1,correlations = F) # using peak (bigBed file, so all contro data have same peak occupancy. no meaningful heatmap.)
dba.plotPCA(prmt1,label='ID')
view(dba.plotHeatmap) 
prmt1$peaks 

# Counting reads for affinity scores (using bam files)
prmt1 <- dba.count(prmt1, summits = 500)

prmt1
dba.plotHeatmap(prmt1,correlations = T) 
dba.plotHeatmap(prmt1,correlations = F) 
dba.plotPCA(prmt1,label='ID')

#```{r define contrast}
prmt1
view(dba.contrast)
prmt1 <- dba.contrast(DBA = prmt1,
                      group1 = prmt1$samples$Condition == "irradia",
                      group2 = prmt1$samples$Condition == "control",
                      name1 = "irradia",
                      name2 = "control")
#prmt1 <- dba.contrast(prmt1,categories = DBA_CONDITION)
prmt1

prmt1 <- dba.analyze(prmt1)
prmt1
dba.plotHeatmap(prmt1,contrast=1,correlations = T) 
dba.plotHeatmap(prmt1,contrast=1,correlations = F) 

prmt1.DB<-dba.report(prmt1)
prmt1.DB

```{r pca plot}
dba.plotPCA(prmt1, label = "ID")

```

```{r MA plot}
dba.plotMA(prmt1)
dba.plotMA(prmt1, 1, cex.main = 0.7)



```{r}
dba.plotVolcano(prmt1,contrast = 1)
```
sum(prmt1.DB$Fold<0)
sum(prmt1.DB$Fold>0)
pvals<-dba.plotBox(prmt1)
pvals

dba.plotHeatmap(prmt1,contrast=1,correlations = F)

```{r fig.height=7, fig.width=7}
names(prmt1$masks)
prmt1
dba.plotVenn(DBA = prmt1, 
             mask = prmt1$masks$irradi)
```



```{r}
dba.report(prmt1, 1)
#dba.report(prmt1, 2)
```




```{r}
dba.report(prmt1,1) %>% as.data.frame
#dba.report(prmt1,2) %>% as.data.frame

write.bed <- function(grange, filename){
  grange %>% as.data.frame() %>%
    mutate(start = start-1) %>% 
    select(1:3) %>%
    mutate(name = paste0("depeak_",row_number())) %>%
    write_tsv(filename, col_names = F)
}

if(0){
  dba.report(prmt1,1) %>% as.data.frame %>% write_tsv("depeak_8KO_8Ctrl.txt")
  #dba.report(prmt1,2) %>% as.data.frame %>% write_tsv("atac/DiffBind/depeak_12KO_8Ctrl.txt")
  
  
  dba.report(prmt1,1) %>% as.data.frame %>% .[.$Fold > 0,] %>% write_tsv("depeak_Ctrl_decrease.txt")
  #dba.report(prmt1,2) %>% as.data.frame %>% .[.$Fold > 0,] %>% write_tsv("atac/DiffBind/depeak_12KO_8Ctrl_decrease.txt")
  dba.report(prmt1,1) %>% as.data.frame %>% .[.$Fold < 0,] %>% write_tsv("depeak_Ctrl_increase.txt")
  #dba.report(prmt1,2) %>% as.data.frame %>% .[.$Fold < 0,] %>% write_tsv("atac/DiffBind/depeak_12KO_8Ctrl_increase.txt")
  
  dba.report(prmt1,1) %>% write.bed("depeak_8Ctrl.bed")
  #wdba.report(prmt1,2) %>% head(2000) %>% write.bed("atac/DiffBind/depeak_12KO_8Ctrl.bed")
  dba.report(prmt1,1) 
  
  prmt1$merged %>% as.data.frame %>% write_tsv("merged.bed", col_names = F)
  prmt1$merged
  
  write_rds(prmt1, "prmt1.dba.Rds")
  write_rds(samples, "prmt1.samples.fordba.Rds")
}

title: "ATAC-seq analysis part 2"
output: html_notebook
---



```{r load}
library(DiffBind)
library(tidyverse)
library(genomation)

prmt1 <- read_rds("prmt1.dba.Rds")
samples <- read_rds("prmt1.samples.fordba.Rds")
prmt1
samples

#dba.report(prmt1,2)
#depeak_12wKO_8ctrl <- dba.report(prmt1,2) %>% resize(width = 2001, fix = "center")
#depeak_12wKO_8ctrl$Fold %>% hist(breaks = 30)
#depeak_12wKO_8ctrl
depeak_resize<-dba.report(prmt1) %>% resize (width = 2001, fix="center")

- need to use normalized coverage file (normalized without chrM)

```{r}
control_0Gy_2 = ScoreMatrix(target = "coverage/0Gy_2.bw", windows = depeak_resize)
control_0Gy_3 = ScoreMatrix(target = "coverage/0Gy_3.bw", windows = depeak_resize)
control_0Gy_5 = ScoreMatrix(target = "coverage/0Gy_5.bw", windows = depeak_resize)
control_0Gy_7 = ScoreMatrix(target = "coverage/0Gy_7.bw", windows = depeak_resize)
irradi_2Gy_1 = ScoreMatrix(target = "coverage/2Gy_1.bw", windows = depeak_resize)
irradi_2Gy_3 = ScoreMatrix(target = "coverage/2Gy_3.bw", windows = depeak_resize)
irradi_8Gy_1 = ScoreMatrix(target = "coverage/8Gy_1.bw", windows = depeak_resize)

#Ctrl_8w_2 = ScoreMatrix(target = "/home/users/kjyi/Projects/beta/atac/shortcut/coverage/Ctrl_8w_2.bw", windows = depeak_12wKO_8ctrl)
#Ctrl_8w_3 = ScoreMatrix(target = "/home/users/kjyi/Projects/beta/atac/shortcut/coverage/Ctrl_8w_3.bw", windows = depeak_12wKO_8ctrl)
#biKO_8w_1 = ScoreMatrix(target = "/home/users/kjyi/Projects/beta/atac/shortcut/coverage/biKO_8w_1.bw", windows = depeak_12wKO_8ctrl)
#biKO_8w_3 = ScoreMatrix(target = "/home/users/kjyi/Projects/beta/atac/shortcut/coverage/biKO_8w_3.bw", windows = depeak_12wKO_8ctrl)
#biKO_12w_1 = ScoreMatrix(target = "/home/users/kjyi/Projects/beta/atac/shortcut/coverage/biKO_12w_1.bw", windows = depeak_12wKO_8ctrl)
#biKO_12w_2 = ScoreMatrix(target = "/home/users/kjyi/Projects/beta/atac/shortcut/coverage/biKO_12w_2.bw", windows = depeak_12wKO_8ctrl)


radiation_list <- ScoreMatrixList(targets = list(
  control_0Gy_2=control_0Gy_2,
  control_0Gy_3=control_0Gy_3,
  control_0Gy_5=control_0Gy_5,
  control_0Gy_7=control_0Gy_7,
  irradi_2Gy_1=irradi_2Gy_1,
  irradi_2Gy_3=irradi_2Gy_3,
  irradi_8Gy_1=irradi_8Gy_1
))
```



```{r}
multiHeatMatrix(radiation_list,
                xcoords = c(-1000,1000), # display x axis -1000~0~1000
                common.scale = T, # do not color-scale separately
                winsorize = c(0,99), # discard upper 1% outlier
                order = T,
                xlab = "Peak center",
                group = list(closed = which(depeak_resize$Fold < 0),
                             open = which(depeak_resize$Fold > 0)),
                group.col = c("red", "green"))

```




```{r}
sml_n_12wKO_8ctrl <- ScoreMatrixList(targets = list(
  Ctrl_8w=(Ctrl_8w_1+Ctrl_8w_2+Ctrl_8w_3)/3,
  biKO_8w=(biKO_8w_1+biKO_8w_3)/2,
  biKO_12w=(biKO_12w_1+biKO_12w_2)/2
))

multiHeatMatrix(sml_n_12wKO_8ctrl,
                xcoords = c(-1000,1000), # display x axis -1000~0~1000
                common.scale = T, # do not color-scale separately
                winsorize = c(0,99), # discard upper 1% outlier
                order = T,
                xlab = "Peak center",
                group = list(closed = which(depeak_resize$Fold < 0),
                             open = which(depeak_resize$Fold > 0)),
                group.col = c("red", "green"))

```


https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE30298
(Identification and analysis of pancreatic islet specific enhancers, Diabetologia 2013 Mar;56(3):542-52. )

```{r}
read_tsv("public/hoffman/table2.txt")
```