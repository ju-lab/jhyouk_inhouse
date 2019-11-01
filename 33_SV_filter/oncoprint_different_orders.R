################## Heatmap for different orders ##################
library(tidyverse)
library(ComplexHeatmap)
library(circlize)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/")

initial_file <- t(read.table("summary_156_v7.txt",sep='\t',header = T,row.names = 1))
#initial_file[1:20,1:2]
initial_file[1,]<-as.numeric(initial_file[1,])
initial_file[5,]<-as.numeric(initial_file[5,])
initial_file[20,]<-as.numeric(initial_file[20,])
initial_file[1:20,1:3]
temp_file <- t(apply(initial_file[-c(1:4),],1,as.numeric))
temp_file[1:16,1:3]
colnames(temp_file)<-colnames(initial_file)

#input_file for hd_order
input_file <- as.matrix(replace(temp_file,temp_file>1,1))

hd_matrix <- as.matrix(temp_file[,c(72:156)])
h1_matrix <- as.matrix(temp_file[,c(59:71)])
c0_matrix <- as.matrix(temp_file[,c(1:58)])
hd_matrix[1:5,1:5]

#new column_order

hd_file <- as.data.frame(t(initial_file[,c(72:156)]))
hd_file_sort <- t(hd_file[order(as.numeric(hd_file$Dose),hd_file$species,hd_file$tissue,decreasing = F),])
hd_matrix <- as.matrix(t(apply(hd_file_sort[-c(1:4),],1,as.numeric)))
hd_matrix[1:16,1:3]
colnames(hd_matrix) <- colnames(hd_file_sort)

h1_file <- as.data.frame(t(initial_file[,c(59:71)]))
h1_file_sort <- t(h1_file[order(as.numeric(h1_file$Dose),h1_file$species,h1_file$tissue,decreasing = T),])
h1_matrix <- as.matrix(t(apply(h1_file_sort[-c(1:4),],1,as.numeric)))
h1_matrix[1:16,1:3]
colnames(h1_matrix) <- colnames(h1_file_sort)

c0_file <- as.data.frame(t(initial_file[,c(1:58)]))
c0_file_sort <- t(c0_file[order(as.numeric(c0_file$Dose),c0_file$species,c0_file$tissue,decreasing = T),])
c0_matrix <- as.matrix(t(apply(c0_file_sort[-c(1:4),],1,as.numeric)))
c0_matrix[1:16,1:3]
colnames(c0_matrix) <- colnames(c0_file_sort)

hd_file_sort[1:5,1:5]



#color and annotation
hd_info<-as.matrix(rbind(initial_file["tissue",72:156],initial_file[1,72:156],initial_file["species",72:156]))
rownames(hd_info) <- c("tissue","dose","species")
hd_matrix_pct<-input_file[,72:156]
#hd_matrix_pct[1:16,1:3]
hd_matrix_pct<-hd_matrix_pct[-16,]
pct<-round(apply(hd_matrix_pct,1,sum)*100/ncol(hd_matrix),0)
row_anno_hd<-rowAnnotation("Pct" = anno_text(paste0(pct,"%"),gp = gpar(fontsize = 10),just="center",location=0.5))

col_fun = colorRamp2(c(0,1,4,8,20),c("gray90","royalblue1","royalblue4","red","red"))

hd_info[1:3,1:5]

### change  a few tissues, doses, species
col_anno_hd<-columnAnnotation("Total SVs" = anno_barplot(hd_matrix["Total",],ylim = c(0,40)),"Species" = hd_file_sort["species",],"Tissue" = hd_file_sort["tissue",], 
                              "Dose" = hd_file_sort["Dose",],show_annotation_name=F,col = list("Tissue"=c("pancreas"="seashell2","liver"="tan3","breast"="lightpink2","lung"="azure3",
                                                                                                     "stomach"="mistyrose1","small_intestine"="lightyellow2","colon"="navajowhite2","fallopian_tube"="mediumpurple1"),
                                                                                          "Dose" = c("0" = "beige","1"= "lemonchiffon1","2"="lemonchiffon2","4"="khaki1","8"="khaki2",
                                                                                                     "20"="khaki3","50" = "khaki4"),
                                                                                          "Species" = c("mouse" = "gray80","human"="antiquewhite2"))
                              )
#draw heatmap
ht_hd <- Heatmap(hd_matrix[-16,],name = "Number of SVs",col=col_fun,right_annotation = row_anno_hd,show_row_names = F,
                 cluster_rows = F, show_column_dend = F, column_order = 1:ncol(hd_matrix),row_split = c(rep("A",5),rep("B",10)),
                 row_gap = unit(3,"mm"),border = F,top_annotation = col_anno_hd, row_title = NULL,rect_gp = gpar(type = "none"),show_column_names = F,
                 layer_fun = function(j, i, x, y, width, height, fill){
                   v=abs(pindex(hd_matrix,i,j))
                   for(k in 0:8){
                     assign(paste0("n",k),v==k)
                   }
                   grid.rect(x = x, y = y, width = width*0.5, height = height*0.9, gp=gpar(fill=col_fun(0),col=col_fun(0)))
                   for(k in 1:8){
                     try(grid.rect(x = x[get(paste0("n",k))], y = y[get(paste0("n",k))], width = width*0.4, height = height*0.9, gp=gpar(fill=col_fun(k),col=col_fun(k))),silent = T)
                   }
                   ld<- pindex(hd_matrix,i,j)<0
                   try(grid.points(x = x[ld], y = y[ld],pch = 18,size=unit(1,"mm"),gp=gpar(col = 'white')),silent = T)
                 }
)
#ht_hd

#color and annotation
h1_info<-as.matrix(rbind(initial_file["tissue",59:71],initial_file[1,59:71],initial_file["species",59:71]))
rownames(h1_info) <- c("tissue","dose","species")
h1_matrix_pct<-input_file[,59:71]
#h1_matrix_pct[1:16,1:3]
h1_matrix_pct<-h1_matrix_pct[-16,]
pct<-round(apply(h1_matrix_pct,1,sum)*100/ncol(h1_matrix),0)
row_anno_h1<-rowAnnotation("Pct" = anno_text(paste0(pct,"%"),gp = gpar(fontsize = 10),just="center",location=0.5))

col_fun = colorRamp2(c(0,1,4,8,20),c("gray90","royalblue1","royalblue4","red","red"))

h1_info[1:3,1:5]

### change  a few tissues, doses, species
col_anno_h1<-columnAnnotation("Total SVs" = anno_barplot(h1_matrix["Total",],ylim = c(0,40)),"Species" = h1_file_sort["species",],"Tissue" = h1_file_sort["tissue",], 
                              "Dose" = h1_file_sort["Dose",],show_annotation_name=F,col = list("Tissue"=c("pancreas"="seashell2","liver"="tan3","breast"="lightpink2","lung"="azure3",
                                                                                                          "stomach"="mistyrose1","small_intestine"="lightyellow2","colon"="navajowhite2","fallopian_tube"="mediumpurple1"),
                                                                                               "Dose" = c("0" = "beige","1"= "lemonchiffon1","2"="lemonchiffon2","4"="khaki1","8"="khaki2",
                                                                                                          "20"="khaki3","50" = "khaki4"),
                                                                                               "Species" = c("mouse" = "gray80","human"="antiquewhite2"))
)
#draw heatmap
ht_h1 <- Heatmap(h1_matrix[-16,],name = "Number of SVs",col=col_fun,right_annotation = row_anno_h1,show_row_names = F,
                 cluster_rows = F, show_column_dend = F, column_order = 1:ncol(h1_matrix),row_split = c(rep("A",5),rep("B",10)),
                 row_gap = unit(3,"mm"),border = F,top_annotation = col_anno_h1, row_title = NULL,rect_gp = gpar(type = "none"),show_column_names = F,
                 layer_fun = function(j, i, x, y, width, height, fill){
                   v=abs(pindex(h1_matrix,i,j))
                   for(k in 0:8){
                     assign(paste0("n",k),v==k)
                   }
                   grid.rect(x = x, y = y, width = width*0.5, height = height*0.9, gp=gpar(fill=col_fun(0),col=col_fun(0)))
                   for(k in 1:8){
                     try(grid.rect(x = x[get(paste0("n",k))], y = y[get(paste0("n",k))], width = width*0.4, height = height*0.9, gp=gpar(fill=col_fun(k),col=col_fun(k))),silent = T)
                   }
                   ld<- pindex(h1_matrix,i,j)<0
                   try(grid.points(x = x[ld], y = y[ld],pch = 18,size=unit(1,"mm"),gp=gpar(col = 'white')),silent = T)
                 }
)
#ht_h1


#color and annotation
c0_info<-as.matrix(rbind(initial_file["tissue",1:58],initial_file[1,1:58],initial_file["species",1:58]))
rownames(c0_info) <- c("tissue","dose","species")
c0_matrix_pct<-input_file[,1:58]
#c0_matrix_pct[1:16,1:3]
c0_matrix_pct<-c0_matrix_pct[-16,]
pct<-round(apply(c0_matrix_pct,1,sum)*100/ncol(c0_matrix),0)
row_anno_c0<-rowAnnotation("Pct" = anno_text(paste0(pct,"%"),gp = gpar(fontsize = 10),just="center",location=0.5))

col_fun = colorRamp2(c(0,1,4,8,20),c("gray90","royalblue1","royalblue4","red","red"))

c0_info[1:3,1:5]

### change  a few tissues, doses, species
col_anno_c0<-columnAnnotation("Total SVs" = anno_barplot(c0_matrix["Total",],ylim = c(0,40)),"Species" = c0_file_sort["species",],"Tissue" = c0_file_sort["tissue",], 
                              "Dose" = c0_file_sort["Dose",],show_annotation_name=T,annotation_name_side="left",col = list("Tissue"=c("pancreas"="seashell2","liver"="tan3","breast"="lightpink2","lung"="azure3",
                                                                                                          "stomach"="mistyrose1","small_intestine"="lightyellow2","colon"="navajowhite2","fallopian_tube"="mediumpurple1"),
                                                                                               "Dose" = c("0" = "beige","1"= "lemonchiffon1","2"="lemonchiffon2","4"="khaki1","8"="khaki2",
                                                                                                          "20"="khaki3","50" = "khaki4"),
                                                                                               "Species" = c("mouse" = "gray80","human"="antiquewhite2"))
)
#draw heatmap
ht_c0 <- Heatmap(c0_matrix[-16,],name = "Number of SVs",col=col_fun,right_annotation = row_anno_c0,row_names_centered = T,row_names_gp = gpar(fontsize=10),
                 cluster_rows = F, row_names_side = "left", show_column_dend = F, column_order = 1:ncol(c0_matrix),row_split = c(rep("A",5),rep("B",10)),
                 row_gap = unit(3,"mm"),border = F,top_annotation = col_anno_c0, row_title = NULL,rect_gp = gpar(type = "none"),show_column_names = F,
                 layer_fun = function(j, i, x, y, width, height, fill){
                   v=abs(pindex(c0_matrix,i,j))
                   for(k in 0:8){
                     assign(paste0("n",k),v==k)
                   }
                   grid.rect(x = x, y = y, width = width*0.5, height = height*0.9, gp=gpar(fill=col_fun(0),col=col_fun(0)))
                   for(k in 1:8){
                     try(grid.rect(x = x[get(paste0("n",k))], y = y[get(paste0("n",k))], width = width*0.4, height = height*0.9, gp=gpar(fill=col_fun(k),col=col_fun(k))),silent = T)
                   }
                   ld<- pindex(c0_matrix,i,j)<0
                   try(grid.points(x = x[ld], y = y[ld],pch = 18,size=unit(1,"mm"),gp=gpar(col = 'white')),silent = T)
                 }
)
ht_c0


ht<-ht_c0 + ht_h1 + ht_hd

setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter")
pdf("ht_c0.pdf")
ht_c0
dev.off()
pdf("ht_h1.pdf")
ht_h1
dev.off()
pdf("ht_hd.pdf")
ht_hd
dev.off()

setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter")
pdf("Figure1b_heatmap_191015.pdf")
draw(ht,merge_legend=T)
dev.off()
