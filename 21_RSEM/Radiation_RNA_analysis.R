#############20200116 RNAseq 0, 0.5, 2, 6, 24hr after irradiation##############
library(tidyverse)
library(ComplexHeatmap, lib.loc = "/home/users/kjyi/R/x86_64-redhat-linux-gnu-library/3.6")
library(ggsci, lib.loc = "/home/users/kjyi/R/x86_64-redhat-linux-gnu-library/3.6")
library(circlize, lib.loc = "/home/users/kjyi/R/x86_64-redhat-linux-gnu-library/3.6")
library(ggrepel, lib.loc = "/home/users/kjyi/R/x86_64-redhat-linux-gnu-library/3.6")
#require(GSEABase, lib.loc = "/home/users/kjyi/R/x86_64-redhat-linux-gnu-library/3.6")
library(seriation, lib.loc = "/home/users/kjyi/R/x86_64-redhat-linux-gnu-library/3.6")



# Making matrix for 15 samples
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/21_RSEM/RSEM_output")
file_info <- read.table("radation_RNA_file_list.txt",header=T,sep='\t')
n=2
for(input_fn in file_info$filename){
  temp_file <- read.table(input_fn,header=T,sep='\t')
  if(input_fn == 'S1_0h-1_rsem.genes.results'){
    exp_table <- temp_file[,c(1,6)]
    colnames(exp_table)[n] <- input_fn
    n <- n+1
  }  else{
    exp_table <- cbind(exp_table,temp_file[,6])
    colnames(exp_table)[n] <- input_fn
    n <- n+1
  }
}
dim(exp_table)
exp_table

# match mouse gene_ID to human gene
biomart <- read.table("~/06_mm10_SNUH_radiation/21_RSEM/mart_export.txt",sep='\t',header = T)
biomart[,c(3,4)]
mousetohuman_biomart <- biomart[,c(3,2)]
colnames(mousetohuman_biomart)<-c("gene_id","Gene_name")
mousetohuman_biomart
exp_table2 <- exp_table %>% left_join(mousetohuman_biomart, by = c("gene_id"="gene_id"))
exp_table3 <- na.omit(exp_table2)
exp_table4 <- unique(exp_table3)
exp_table5 <- exp_table4[,-1] %>% group_by(Gene_name) %>% summarise_all(list(sum)) # sum same "Gene_name"
exp_table5[exp_table5$Gene_name == "HIST2H3A",][,10:16]
biomart
dim(exp_table5)
#log transformation for comparison of variances
exp_table6 <- exp_table5 %>% mutate_at(vars(-Gene_name),list(~log10(.+1)))
#select protein-coding gene only
bm_gt <- read.table("/home/users/jhyouk/99_reference/biomart/biomart_human_geneID_transcriptID_hgncsymbol_genetype_ensemblgenename_190522.txt",header=T,sep='\t') %>% as_tibble() %>% dplyr::select('Gene.name','Gene.type') %>% unique()
colnames(bm_gt) <- c("Gene_name","Gene_type")
exp_table7 <- exp_table6 %>% left_join(bm_gt, by = c("Gene_name"="Gene_name")) %>% filter(Gene_type == 'protein_coding')
# variance top 2500 gene choose
exp_table8 <- exp_table7 %>% as.data.frame() %>% column_to_rownames("Gene_name") %>% dplyr::select(-Gene_type)
temp <- apply(exp_table8,1,function(x) sd(x))
temp
temp2 <- apply(exp_table8,1,function(x) mean(x))
temp[3] / temp2[3]
exp_table8[1:4,]

exp_table8$var <- apply(exp_table8,1,function(x){sd(x)/mean(x)})
exp_table8$var[exp_table8$var == 'NaN'] <- 0
exp_table8$var 
exp_table8 <- exp_table8 %>% rownames_to_column("Gene_name")

var_genes <- exp_table8 %>% arrange(desc(var)) %>% .$Gene_name %>% .[1:2500]
var_genes
exp_table8 %>% arrange(desc(var))
exp_table5[exp_table5$Gene_name %in% var_genes,]


write.table(var_genes,file="var_genes_sdbymean.txt",sep='\t',row.names = F)
#colnames(var_genes)
which(var_genes=='P53')

log_tpm <- exp_table8 %>% dplyr::filter(Gene_name %in% var_genes) %>% dplyr::select(-var) %>% column_to_rownames('Gene_name') %>% as.matrix()
log_tpm[1:5,1:5]
#scale() based on each row
?scale
scaled_exp <- t(log_tpm) %>% scale() %>% t()
exp_meta  <- read.table("radation_RNA_file_list.txt",header=T,sep='\t')
exp_meta2 <- exp_meta %>% dplyr::select(filename,time) %>% column_to_rownames("filename")
group_color <- pal_aaas("default")(10)[c(10,3,2,9,4)]
#pie(seq(1,10),col=pal_aaas("default")(10))
names(group_color) = c('0','24','2','0.5','6')
#pie(rep(1,10),col=group_color)
colnames(scaled_exp) <- colnames(scaled_exp) %>% strsplit("_rsem") %>% lapply(function(x) x[1]) %>% unlist
rownames(exp_meta2) <- rownames(exp_meta2) %>% strsplit("_rsem") %>% lapply(function(x) x[1]) %>% unlist


write.table(scaled_exp,file = "scaled_exp.txt",sep='\t')
#all_list <- list("P53_PATHWAY"=c("TP53","BAX","CDK1","MDM2","CCNE2"),
#                 "APOPTOSIS" = c("JUN","BAX","CDKN1A","FAS","BRCA1","CCND2","CDK2"),
#                 "DSB_REPAIR"=c("BRCA1","MRE11","RAD51","CDK2","BRCA2","POLQ","CHEK1","POLE","BLM","ATM")
#                 )

#By Enrichr,KEGG2019 Human, Reactome 2016, Bioplanet 2019
biomart[biomart$Gene.name=='HIF3A',]
all_list <- list("P53_pathway"=c("Trp53","Bax","Cdkn1a","Fas"),
                 "Cell_cycle" = c("Mdm2","Cdk1","Cdk2","Ccne1","Ccne2","Ccna2","Ccnb1"),
                 "DNA_replication" = c("Pole","Pcna","Rpa1","Rpa2"),
                 "DSB_Repair"=c("Brca1","Mre11a","Rad51","Brca2","Brip1","Blm","Atm"),
                 "Hypoxia-related"=c("Vegfa","Serpine1","Edn1","Hif3a")
                 )
selected_names <- names(all_list)

column_anno <- HeatmapAnnotation("Time" = exp_meta2$time,
                                 col = list("Time" = group_color),
                                 annotation_legend_param = list("Time" = list(title = "Time after irradiation",
                                                                              at = c('0','0.5','2','6','24'),
                                                                              labels = c('0hr','0.5hr','2hr','6hr','24hr')))
)
length(selected_names)
#myninecolor=RColorBrewer::brewer.pal(9,"Set1")[c(1,5,2,4,3,6)]
myninecolor=c("#FF7F00",
              "#4DAF4A",
              "#984EA3",
              "#377EB8",
              "Gray70")
#plot(c(1,2,3,4,5),c(1,2,3,4,5),col=myninecolor)
all_names = rownames(scaled_exp)
all_color=rep("black",length(all_names))
for(i in 1:length(selected_names)){
  all_color[all_names %in% all_list[[selected_names[i]]]] = myninecolor[i]
}
table(all_color)

ha = rowAnnotation(foo = anno_mark(at = which(all_color != "black"),
                                   labels = all_names[all_color != "black"], 
                                   lines_gp = gpar(col=all_color[which(all_color != "black")]),
                                   labels_gp = gpar(col=all_color[which(all_color != "black")],cex=1)))
#scaled_exp[1:5,1:5]
#get_order(o1p)
o1p = seriate(as.dist(1-cor(t(scaled_exp))), method = "TSP") # about genes
o1pgw = hclust(as.dist(1-cor(t(scaled_exp)))) # about genes
o2pgw = seriate(as.dist(1-cor(scaled_exp)), method = "GW")
#exp_pal = colorRamp2(c(-3,0,3), c('#253494',"gray90",'#f03b20'))
o1pgw %>% cutree(k = 4) %>% {.[.==1]} %>% names %>% cat(sep="\n") # Group 3 -> p53 signaling pathway
o1pgw %>% cutree(k = 4) %>% {.[.==2]} %>% names %>% cat(sep="\n") # Group 4 -> unspecified pathway
o1pgw %>% cutree(k = 4) %>% {.[.==4]} %>% names %>% cat(sep="\n") # Group 1 -> Hypoxia pathway
o1pgw %>% cutree(k = 4) %>% {.[.==3]} %>% names %>% cat(.[1:103],sep="\n")# Group 2 -> Cell cycle, DNA repair pathway
o1pgw %>% cutree(k = 4) %>% table(.)

#colorRamp2
exp_pal = circlize::colorRamp2(c(-3,0,3), c('#253494',"gray90",'#f03b20'))
h1<-Heatmap(scaled_exp,
        width = unit(8,"cm"),height = unit(11,"cm"),
        show_row_dend = T,show_column_dend = T,
        show_row_names = F,show_column_names = F,
        row_split = 4,show_heatmap_legend = F,
        top_annotation = column_anno,
        #right_annotation = ha,
        left_annotation = rowAnnotation( width = unit(4.5, "mm"),d=anno_block(
          gp = gpar(fill = c("gray70","#377EB8","#FF7F00","gray50")),
          labels = c("group1", "group2", "group3","group4"),
          labels_gp = gpar(col = "white", fontsize = 7)
        )),
        row_title_gp = gpar(col="#00000000"),
        row_gap = unit(0.5, "mm"),
        #column_order =c(1,2,10,3,12,11,4,6,5,7,9,8,13,14,15)
        #column_order =c(1,2,3,10,12,11,7,8,9,15,14,13,4,6,5),
        col= exp_pal,
        row_order = get_order(o1p),
        #cluster_columns = as.dendrogram(o2pgw[[1]]),
        cluster_rows = as.dendrogram(o1pgw)
        )
h1


lgd = Legend(labels = selected_names, title = "Gene ontology", legend_gp = gpar(col = myninecolor,bg="white"),
             labels_gp = gpar(col = myninecolor),
             type = "lines")
lgd2 = Legend(col_fun = exp_pal, title = "Normalized gene expression")
lgd12=packLegend(lgd,lgd2)
draw(lgd12)

pdf("heatmap_200225.pdf")
draw(h1, annotation_legend_list = lgd12)
dev.off()


#PCA - no DESeq2
install.packages("factoextra")
library(factoextra)
log_tpm
file_info[1:15,]
log_tpm 
pca_exp <- prcomp(t(log_tpm),scale=F)
pca_exp
?prcomp
par(mar=c(5.1,4.1,4.1,2.1))
file_info$color <- c(rep(group_color[1],3),rep(group_color[2],3),rep(group_color[3],3),rep(group_color[4],3),rep(group_color[5],3))
plot(pca_exp$x[,1],pca_exp$x[,2],col=file_info$color,pch=19)
par(mar=c(1,1,1,1))
view(fviz_pca_ind)

fviz_pca_ind(pca_exp,
             col.ind = (factor(file_info$time)), # color by groups
             palette = unique(file_info$color),
             addEllipses = TRUE, # Concentration ellipses
             ellipse.type = "confidence",
             legend.title = "Groups",
             repel = T,geom = "point",habillage ="none"
)

pie(seq(1,15),col=file_info$color)
#library(ggfortify)
#install.packages("ggfortify")
#c("#1B1919FF","#1B1919FF","#1B1919FF","#008B45FF","#008B45FF","#008B45FF","#EE0000FF","#EE0000FF","#EE0000FF","#808180FF","#808180FF","#808180FF","#631879FF","#631879FF","#631879FF")

#PCA using DESeq2

library(DESeq2)
library(tximport)
library(tidyverse)
library(NMF)
file_info$filename
samples <- matrix(file_info$ID,ncol = 1)
samples <- samples %>% as.data.frame()
samples$condition <- c("pre","pre","pre","24h","24h","24h","2h","2h","2h","30m","30m","30m","6hr","6hr","6hr")
samples
files <- file.path(paste(samples$V1,"_rsem.genes.results",sep=""))
names(files) <- samples$V1

txi <- tximport(files,type = 'rsem',txIn=FALSE,txOut = FALSE)
str(txi)
summary(txi$length)
txi$length[txi$length == 0] <- 1 
samples <- samples %>% as.data.frame() %>% column_to_rownames('V1')
samples
dds <- DESeqDataSetFromTximport(txi, colData = samples, design =  ~condition)
counts(dds)


keep <- rowSums(counts(dds)) >= 10 # for saving memory
keep
dds <- dds[keep,] 
dds$condition <- relevel(dds$condition, ref = "pre")
dds <- DESeq(dds)

dds

res <- results(dds,tidy=TRUE)
vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE,col="red")
vsd
plotPCA(vsd)
pcaData <- plotPCA(vsd, returnData=TRUE)
pcaData$color <- file_info$color
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, col=I(color))) +
  geom_point(size=3) +
  xlab(paste0("PC1 (",percentVar[1],"%)")) +
  ylab(paste0("PC2 (",percentVar[2],"%)")) + 
  coord_fixed() +
  theme_minimal() +
  geom_vline(xintercept = 0,linetype="dotted") + 
  geom_hline(yintercept = 0,linetype="dotted") +
  scale_color_manual(name = "Time after Irradiation", labels = unique(pcaData$group),
                     values = unique(pcaData$color))

#kjyi code
par(mar=c(5.1,4.1,2.1,8),xpd=F)
plot(pcaData$PC1, pcaData$PC2, col="#00000000",bg=pcaData$color, pch=21,cex=2,bty='n',xaxt='n',yaxt='n',xlab="",ylab="",asp=1,xlim=c(-20,25),ylim=c(-15,15),type='n')
abline(h=c(-4:5*5),v=c(-3:4*5),col="grey80",lwd=0.5)
abline(h=0,v=0,lty=2)
axis(side = 1,at = c(-1:2*10),tick = F)
axis(side = 2,at = c(-2:2*10),tick = F)
mtext(text = paste0("PC1 (",percentVar[1],"%)"),side = 1,line = 2)
mtext(text = paste0("PC2 (",percentVar[2],"%)"),side = 2,line = 2)
legend(25,0,legend = c("pre","24h","2h","30m","3h"),pt.bg=rainbow(5),col="#00000000",pch=21,bty='n',title = "Time after",pt.cex=2,xpd=T)

#My code
pdf("PCA_vsd.pdf")
par(mar=c(12.1,4.1,10.1,8),xpd=F)
plot(0, 0, asp=1,xlim=c(-10,15),ylim=c(-10,13),type='n',xlab="",ylab="",bty='n',xaxt='n',yaxt='n')
abline(h=c(-4:6*2.5),v=c(-3:4*5),col="grey80",lwd=0.5)
abline(h=0,v=0,lty=2)
axis(side = 1,at = c(-1:2*10),tick = F)
axis(side = 2,at = c(-2:4*5),tick = F)
mtext(text = paste0("PC1 (",percentVar[1],"%)"),side = 1,line = 2)
mtext(text = paste0("PC2 (",percentVar[2],"%)"),side = 2,line = 2)
points(pcaData$PC1, pcaData$PC2, col="#00000000",bg=pcaData$color, pch=21,cex=1.5)
legend(30,5,legend = c("pre","30m","2h","6h","24h"),pt.bg=unique(pcaData$color)[c(1,4,3,5,2)],col="#00000000",pch=21,bty='n',title = "Time",pt.cex=1.5,xpd=T)
dev.off()



#######Heatmap using DESeq2 value
library(pheatmap)
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:2500]
df <- as.data.frame(colData(dds)[,"condition"])
counts(dds)
rownames(df) <- colnames(dds)
pheatmap::pheatmap(assay(vsd)[select,], cluster_rows=T, show_rownames=FALSE,
         cluster_cols=T, annotation_col=df)
?pheatmap
assay(vsd)[select,]
a
BiocManager::install("vsn")
library(hexbin)
install.packages("hexbin")
meanSdPlot(assay(vsd))

target_list <- assay(vsd)
target_list
idtoname <- biomart[,c(3,4)]

colnames(idtoname)<-c("gene_id","Gene_name")
temp_target <- target_list %>% as.data.frame() %>% rownames_to_column(var = "gene_id")
exp_table[1:3,1:3]

target_list2 <- temp_target %>% left_join(idtoname, by = c("gene_id"="gene_id"))
target_list3 <- target_list2 %>% na.omit() %>% unique

target_list3
target_list5 <- target_list3[,-1] %>% group_by(Gene_name) %>% summarise_all(list(sum)) # sum same "Gene_name"


#select protein-coding gene only of mouse
bm_gt <- read.table("/home/users/jhyouk/99_reference/biomart/mouse_geneID_geneName_Gene_type.txt",header=T,sep=',') %>% as_tibble() %>% dplyr::select('Gene.name','Gene.type') %>% unique()

colnames(bm_gt) <- c("Gene_name","Gene_type")
target_list6 <- target_list5 %>% left_join(bm_gt, by = c("Gene_name"="Gene_name")) %>% filter(Gene_type == 'protein_coding')
# variance top 2500 gene choose
target_list8 <- target_list6 %>% as.data.frame() %>% column_to_rownames("Gene_name") %>% dplyr::select(-Gene_type)

target_list8$var <- apply(target_list8,1,function(x) var(x))
#target_list8$var[target_list8$var == 'NaN'] <- 0
target_list8$var 
target_list8 <- target_list8 %>% rownames_to_column("Gene_name")
var_genes <- target_list8 %>% arrange(desc(var)) %>% .$Gene_name %>% .[1:2500]
log_tpm <- target_list8 %>% dplyr::filter(Gene_name %in% var_genes) %>% dplyr::select(-var) %>% column_to_rownames('Gene_name') %>% as.matrix()
log_tpm

scaled_exp <- t(log_tpm) %>% scale() %>% t()
exp_meta  <- read.table("radation_RNA_file_list.txt",header=T,sep='\t')
exp_meta2 <- exp_meta %>% dplyr::select(filename,time) %>% column_to_rownames("filename")
group_color <- pal_aaas("default")(10)[c(10,3,2,9,4)]
#pie(seq(1,10),col=pal_aaas("default")(10))
names(group_color) = c('0','24','2','0.5','6')
#pie(rep(1,10),col=group_color)
colnames(scaled_exp) <- colnames(scaled_exp) %>% strsplit("_rsem") %>% lapply(function(x) x[1]) %>% unlist
rownames(exp_meta2) <- rownames(exp_meta2) %>% strsplit("_rsem") %>% lapply(function(x) x[1]) %>% unlist

#biomart[biomart$Gene.name=='HIF3A',]
all_list <- list("P53_pathway"=c("Trp53","Mdm2","Bax","Cdkn1a","Fas"),
                 "Cell_cycle" = c("Cdk1","Cdk2","Ccne1","Ccne2","Ccna2","Ccnb1"),
                 "DNA_replication" = c("Pole","Pcna","Rpa1","Rpa2"),
                 "DSB_Repair"=c("Brca1","Mre11a","Rad51","Brca2","Brip1","Blm","Atm"),
                 "Hypoxia-related"=c("Vegfa","Serpine1","Edn1")
)
selected_names <- names(all_list)

column_anno <- HeatmapAnnotation("Time" = exp_meta2$time,
                                 col = list("Time" = group_color),
                                 annotation_legend_param = list("Time" = list(title = "Time after irradiation",
                                                                              at = c('0','0.5','2','6','24'),
                                                                              labels = c('0hr','0.5hr','2hr','6hr','24hr')))
)
#length(selected_names)
#myninecolor=RColorBrewer::brewer.pal(9,"Set1")[c(1,5,2,4,3,6)]
myninecolor=c("#FF7F00",
              "#4DAF4A",
              "#984EA3",
              "#377EB8",
              "Gray70")
#plot(c(1,2,3,4,5),c(1,2,3,4,5),col=myninecolor)
all_names = rownames(scaled_exp)
all_color=rep("black",length(all_names))
for(i in 1:length(selected_names)){
  all_color[all_names %in% all_list[[selected_names[i]]]] = myninecolor[i]
}
table(all_color)

ha = rowAnnotation(foo = anno_mark(at = which(all_color != "black"),
                                   labels = all_names[all_color != "black"], 
                                   lines_gp = gpar(col=all_color[which(all_color != "black")]),
                                   labels_gp = gpar(col=all_color[which(all_color != "black")],cex=1)))
#scaled_exp[1:5,1:5]
#get_order(o1p)
o1p = seriate(as.dist(1-cor(t(scaled_exp))), method = "TSP") # about genes
o1pgw = hclust(as.dist(1-cor(t(scaled_exp)))) # about genes
o2pgw = seriate(as.dist(1-cor(scaled_exp)), method = "GW")
#exp_pal = colorRamp2(c(-3,0,3), c('#253494',"gray90",'#f03b20'))
o1pgw %>% cutree(k = 4) %>% {.[.==1]} %>% names %>% cat(sep="\n") # Group 3 -> p53 signaling pathway
o1pgw %>% cutree(k = 4) %>% {.[.==2]} %>% names %>% cat(sep="\n") # Group 4 -> unspecified pathway
o1pgw %>% cutree(k = 4) %>% {.[.==4]} %>% names %>% cat(sep="\n") # Group 1 -> Hypoxia pathway
o1pgw %>% cutree(k = 4) %>% {.[.==3]} %>% names %>% cat(.[1:103],sep="\n")# Group 2 -> Cell cycle, DNA repair pathway
o1pgw %>% cutree(k = 4) %>% table(.)

#colorRamp2
exp_pal = circlize::colorRamp2(c(-3,0,3), c('#253494',"gray90",'#f03b20'))

o1pgw %>% cutree(k = 3) %>% {.[.==1]} %>% names %>% cat(sep="\n") # Group 3 -> p53 signaling pathway
o1pgw %>% cutree(k = 3) %>% {.[.==2]} %>% names %>% cat(sep="\n") # Group 4 -> unspecified pathway
o1pgw %>% cutree(k = 3) %>% {.[.==3]} %>% names %>% cat(sep="\n") # Group 1 -> Hypoxia pathway
o1pgw %>% cutree(k = 3) %>% table(.)

h2<-Heatmap(scaled_exp,
        width = unit(8,"cm"),height = unit(11,"cm"),
        show_row_dend = F,show_column_dend = F,
        show_row_names = F,show_column_names = F,
        row_split = 2,show_heatmap_legend = F,
        top_annotation = column_anno,
        right_annotation = ha,
        column_order =c(1,2,3,10,12,11,7,8,9,15,14,13,4,6,5),
        row_order = get_order(o1p),
        cluster_rows = rev(as.dendrogram(o1pgw)),
        col= exp_pal,
        row_title_gp = gpar(col="#00000000"),
        row_gap = unit(0.5, "mm"),
        left_annotation = rowAnnotation( width = unit(4.5, "mm"),d=anno_block(
              gp = gpar(fill = c("#377EB8","gray50")),
              labels = c("upregulated", "downregulated"),
              labels_gp = gpar(col = "white", fontsize = 9))))

lgd = Legend(labels = selected_names, title = "Gene ontology", legend_gp = gpar(col = myninecolor,bg="white"),
             labels_gp = gpar(col = myninecolor),
             type = "lines")
lgd2 = Legend(col_fun = exp_pal, title = "Normalized gene expression")
lgd12=packLegend(lgd,lgd2)
draw(lgd12)

pdf("heatmap_200226.pdf")
draw(h2, annotation_legend_list = lgd12)
dev.off()



