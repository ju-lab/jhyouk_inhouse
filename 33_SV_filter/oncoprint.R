library(tidyverse)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/")
#library(devtools)
#install_github("jokergoo/ComplexHeatmap")
library(ComplexHeatmap)

initial_file <- read.table("matrix_may.txt",sep='\t',header = T,row.names = 1)
initial_file[1,]
temp_file <- initial_file[-1,]
input_file <- list(sv = as.matrix(replace(temp_file,temp_file>1,1)))
class(input_file)
col = c(sv = "blue")
oncoPrint(mat = input_file, alter_fun = list(background = function(x, y, w, h) {
  grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
            gp = gpar(fill = "#CCCCCC", col = NA))},sv = function(x,y,w,h) grid.rect(x,y,w*0.9,h*0.9,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,column_order = NULL,row_order = NULL)

try_file <- list(sv = as.matrix(initial_file[-1,]))
oncoPrint(mat = try_file, alter_fun = list(sv = function(x,y,w,h) grid.rect(x,y,w*0.9,h*0.9,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,column_order = NULL,row_order = NULL)
try_file$sv[1:5,1:5]

ncol(input_file)
# Using oncoPrint function
initial_file <- read.table("matrix_may.txt",sep='\t',header = T,row.names = 1)
initial_file[1,]
temp_file <- initial_file[-1,]
input_file <- as.matrix(replace(temp_file,temp_file>1,1))
col = c(sv = "blue")

hd_file <- list(sv = as.matrix(input_file[,c(37:86)]))
hd_file$sv[1:5,1:5]
h1_file <- list(sv = as.matrix(input_file[,c(24:36)]))
L8_file <-  list(sv = as.matrix(input_file[,c(20:23)]))
control <- list(sv = as.matrix(input_file[,c(1:19)]))
par(mfrow=c(1,1))
order_file <- input_file[c(7,8,11,1,2,3,4,5,6,9,10,12,13,14,15),]
hd_file <- list(sv = as.matrix(order_file[,c(37:86)]))
nrow(input_file)

oncoPrint(hd_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
          ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = c(1:nrow(hd_file$sv)))

oncoPrint(h1_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
          ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = NULL)

oncoPrint(L8_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
          ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = NULL)
oncoPrint(control, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
          ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = NULL)

#Customized ongogrid from Heatmap function
#need column order : mutual exclusivity



library(circlize)
hd_matrix <- as.matrix(temp_file[,c(37:86)])
hd_matrix[1:3,1:3]
h1_matrix <- as.matrix(input_file[,c(24:36)])
L8_matrix <-  as.matrix(input_file[,c(20:23)])
c0_matrix <- as.matrix(input_file[,c(1:19)])

col_fun = colorRamp2(c(0,1,2,8),c("gray90","dodgerblue","dodgerblue2","dodgerblue4"))
Heatmap(hd_matrix,name = "Number of SVs",col=col_fun, column_title = "Radiation_dose", column_title_side = 'bottom',
        cluster_rows = F, show_column_dend = F, row_names_side = "left")

#h1 <- Heatmap(h1_matrix,name = "Number of SVs",col=col_fun, column_title = "Radiation_dose", column_title_side = 'bottom',
              cluster_rows = F, show_column_dend = F, column_dend_reorder = T, row_names_side = "left")
#L8 <- Heatmap(L8_matrix,name = "Number of SVs",col=col_fun, column_title = "Radiation_dose", column_title_side = 'bottom',
              cluster_rows = F, show_column_dend = F, column_dend_reorder = T, row_names_side = "left")
#c0 <- Heatmap(c0_matrix,name = "Number of SVs",col=col_fun, column_title = "Radiation_dose", column_title_side = 'bottom',
              cluster_rows = F, show_column_dend = F, column_dend_reorder = T, row_names_side = "left")
#hd+h1+L8+c0

temp <- replace(hd_matrix,hd_matrix>1,1)
temp[1:5,1:5]
temp2 <- temp[c(-3,-5),]  
temp2[1:5,1:5]
hd_matrix[1:5,1:5] 

Heatmap(ysort(hd_matrix),name = "Number of SVs",col=col_fun, column_title = "Radiation_dose", column_title_side = 'bottom',
        cluster_rows = F, show_column_dend = F, row_names_side = "left")
Heatmap(ysort(temp),name = "Number of SVs",col=col_fun, column_title = "Radiation_dose", column_title_side = 'bottom',
        cluster_rows = F, show_column_dend = F, row_names_side = "left")


#############Start from Here for Figure 1#############
#Decide column order using Oncoprint algorithm
initial_file <- read.table("matrix_may.txt",sep='\t',header = T,row.names = 1)
initial_file[1,]
temp_file <- initial_file[-1,]
input_file <- as.matrix(replace(temp_file,temp_file>1,1))
col = c(sv = "blue")
#hd_file <- list(sv = as.matrix(input_file[,c(37:86)]))

order_file <- input_file[c(7,8,9,10,11,12,13,14,15,3,1,2,4,5,6),]
hd_file <- list(sv = as.matrix(order_file[,c(37:86)]))

#oncoPrint(hd_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
                                    ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = c(1:nrow(hd_file$sv)))
hd<-oncoPrint(hd_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
                                        ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = c(1:nrow(hd_file$sv)))
hd_order<-column_order(hd)
oncoPrint(hd_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
                                    ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = c(1:nrow(hd_file$sv)))

library(circlize)
ori_file <- read.table("matrix86_R.txt",sep='\t',header = T,row.names = 1)
initial_file <- read.table("matrix_may.txt",sep='\t',header = T,row.names = 1)
#initial_file[1,]
temp_file <- initial_file[-1,]
hd_matrix <- as.matrix(temp_file[,c(37:86)])
h1_matrix <- as.matrix(temp_file[,c(24:36)])
#L8_matrix <-  as.matrix(input_file[,c(20:23)])
c0_matrix <- as.matrix(temp_file[,c(1:19)])
col_fun = colorRamp2(c(0,1,2,8),c("gray90","dodgerblue","dodgerblue2","dodgerblue4"))

num_sv<-HeatmapAnnotation("Total SVs" = anno_barplot(colSums(hd_matrix)))
Heatmap(hd_matrix,name = "Number of SVs",col=col_fun, column_title = "Radiation_dose", column_title_side = 'bottom',
        cluster_rows = F, show_column_dend = F, row_names_side = "left", column_order = hd_order,row_split = c(rep("A",6),rep("B",9)),
        row_gap = unit(3,"mm"),border = T,top_annotation = num_sv,row_title = NULL)


ori_file[1:10.1:5]






