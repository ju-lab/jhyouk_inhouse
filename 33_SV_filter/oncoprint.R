################## Start from Here for Heatmap ######################
library(tidyverse)
library(ComplexHeatmap)
library(circlize)
getwd()
setwd("/home/users/jhyouk/06_mm10_SNUH_radiation/33_SV_filter/")

ori_file <- read.table("matrix86_R.txt",sep='\t',header = T,row.names = 1)
initial_file <- read.table("matrix_may.txt",sep='\t',header = T,row.names = 1)
temp_file <- initial_file[-1,]
input_file <- as.matrix(replace(temp_file,temp_file>1,1))


hd_matrix <- as.matrix(temp_file[,c(37:86)])
h1_matrix <- as.matrix(temp_file[,c(24:36)])
#L8_matrix <-  as.matrix(input_file[,c(20:23)])
c0_matrix <- as.matrix(temp_file[,c(1:23)])

#column_order from oncoprint function
order_file <- input_file[c(7,8,9,10,11,12,13,14,15,3,1,2,4,5,6),]
hd_file <- list(sv = as.matrix(order_file[,c(37:86)]))
col = c(sv = "blue")
hd<-oncoPrint(hd_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),gp = gpar(fill = "#CCCCCC", col = NA))}
                                        ,sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),col=col,show_column_names = T,row_order = c(1:nrow(hd_file$sv)))
hd_order<-column_order(hd)

#add large deletion and direct return of simpleF
temp_hd<-rbind(ori_file["large_DEL",37:86],hd_matrix)
for (i in 1:50){
  if(temp_hd["large_DEL",i]>0){
    temp_hd["Simple Deletion",i] <-temp_hd["Simple Deletion",i]*-1
  }
}
temp_hd
hd_matrix <- as.matrix(temp_hd[-1,])
temp_hd2<-ori_file["direct return",37:86]
temp_hd2
for (i in 1:50){
  if(temp_hd2["direct return",i]>0){
    hd_matrix["SimpleF",i] <-hd_matrix["SimpleF",i]*-1
  }
}

#add tissue and experiment information
info_file <- read.table("00_9_86_temp.sh",sep='\t',header = F, row.names = 1)
#gsub("-",".",colnames(info_file_t[1:5,1:5]))
rownames(info_file)<-gsub("-",".",rownames(info_file))
colnames(initial_file)<-gsub("X","",colnames(initial_file))
for(i in colnames(initial_file)){
  initial_file["tissue",i] <- info_file[i,3]
  initial_file["experiment",i] <- info_file[i,4]
}

#color and annotation
hd_info<-as.matrix(rbind(initial_file["tissue",37:86],initial_file[1,37:86],initial_file["experiment",37:86]))
hd_matrix_pct<-input_file[,37:86]
pct<-apply(hd_matrix_pct,1,sum)*100/ncol(hd_matrix)
row_anno_hd<-rowAnnotation("Pct" = anno_text(paste0(pct,"%"),gp = gpar(fontsize = 10),just="center",location=0.5))

col_fun = colorRamp2(c(0,1,4,8),c("gray90","royalblue1","royalblue4","red"))
col_anno_hd<-columnAnnotation("Total SVs" = anno_barplot(colSums(abs(hd_matrix)),ylim = c(0,15)),"Experiment" = hd_info["experiment",],"Tissue" = hd_info["tissue",], 
                           "Dose2" = hd_info["Dose",],show_annotation_name=F,col = list("Tissue"=c("pancreas"="seashell2","liver"="tan4","breast"="pink"),
                                                                "Dose2" = c("0" = "beige","0.1"= "lemonchiffon1","1"="lemonchiffon2","2"="khaki1","4"="khaki2",
                                                                            "8"="khaki3","20" = "khaki4"),
                                                                "Experiment" = c("A" = "antiquewhite1","B"="antiquewhite2","C"="antiquewhite3","D"="cornsilk2")))

#draw heatmap
ht_hd <- Heatmap(hd_matrix,name = "Number of SVs",col=col_fun,right_annotation = row_anno_hd,show_row_names = F,
        cluster_rows = F, show_column_dend = F, column_order = hd_order,row_split = c(rep("A",6),rep("B",9)),
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

##For c0
#order
c0_file <- list(sv = as.matrix(input_file[,c(1:23)]))
c0<-oncoPrint(c0_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),
              gp = gpar(fill = "#CCCCCC", col = NA))},sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),
              col=col,show_column_names = T,row_order = c(1:nrow(c0_file$sv)))
c0_order<-column_order(c0)

#annotation
c0_info<-as.matrix(rbind(initial_file["tissue",1:23],initial_file[1,1:23],initial_file["experiment",1:23]))
c0_matrix_pct<-input_file[,1:23]
pct_c0<-round(apply(c0_matrix_pct,1,sum)*100/ncol(c0_matrix),digits = 0)
row_anno_c0<-rowAnnotation("Pct" = anno_text(paste0(pct_c0,"%"),gp = gpar(fontsize = 10),just="center",location=0.5))


col_anno_c0<-columnAnnotation("Total SVs" = anno_barplot(colSums(abs(c0_matrix)),ylim = c(0,15)),"Experiment" = c0_info["experiment",],"Tissue" = c0_info["tissue",], 
                              "Dose" = c0_info["Dose",],annotation_name_side = "left", 
                              col = list("Tissue"=c("pancreas"="seashell2","liver"="tan4","breast"="pink"),
                                         "Dose" = c("0" = "beige","0.1"= "lemonchiffon1","1"="lemonchiffon2","2"="khaki1","4"="khaki2",
                                                    "8"="khaki3","20" = "khaki4"),
                                         "Experiment" = c("A" = "antiquewhite1","B"="antiquewhite2","C"="antiquewhite3","D"="cornsilk4","MA"="antiquewhite1",
                                                          "MC"="antiquewhite2","LA"="cornsilk1","LB"="cornsilk1")))


ht_c0 <- Heatmap(c0_matrix,name = "Number of SVs",col=col_fun,right_annotation = row_anno_c0,row_names_centered = T,row_names_gp = gpar(fontsize=10),
        cluster_rows = F, show_column_dend = F, row_names_side = "left", column_order = c0_order,row_split = c(rep("A",6),rep("B",9)),
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
?anno_simple
##For h1
#order
order_file_h1 <- input_file[c(7,8,9,1,2,3,4,5,6,10,11,12,13,14,15),]
h1_file <- list(sv = as.matrix(order_file_h1[,c(24:36)]))
h1<-oncoPrint(h1_file, alter_fun = list(background = function(x, y, w, h) {grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"),
                                                                                     gp = gpar(fill = "#CCCCCC", col = NA))},sv = function(x,y,w,h) grid.rect(x,y,w*0.5,h*0.4,gp=gpar(fill=col,col=NA))),
              col=col,show_column_names = T,row_order = c(1:nrow(h1_file$sv)))
h1_order<-column_order(h1)

#add large deletion and direct return of simpleF
temp_h1<-rbind(ori_file["large_DEL",24:36],h1_matrix)
for (i in 1:13){
  if(temp_h1["large_DEL",i]>0){
    temp_h1["Simple Deletion",i] <-temp_h1["Simple Deletion",i]*-1
  }
}
h1_matrix <- as.matrix(temp_h1[-1,])
temp_h12<-ori_file["direct return",24:36]
for (i in 1:13){
  if(temp_h12["direct return",i]>0){
    h1_matrix["SimpleF",i] <-h1_matrix["SimpleF",i]*-1
  }
}
h1_matrix

#annotation
h1_info<-as.matrix(rbind(initial_file["tissue",24:36],initial_file[1,24:36],initial_file["experiment",24:36]))
h1_matrix_pct<-input_file[,24:36]
pct_h1<-round(apply(h1_matrix_pct,1,sum)*100/ncol(h1_matrix),digits = 0)
row_anno_h1<-rowAnnotation("Pct" = anno_text(paste0(pct_h1,"%"),gp = gpar(fontsize = 10),just="center",location=0.5))

?anno_barplot
col_anno_h1<-columnAnnotation("Total SVs" = anno_barplot(colSums(abs(h1_matrix)),ylim = c(0,15)),"Experiment" = h1_info["experiment",],"Tissue" = h1_info["tissue",], 
                              "Dose1" = h1_info["Dose",],show_annotation_name=F,col = list("Tissue"=c("pancreas"="seashell2","liver"="tan4","breast"="pink"),
                                                                   "Dose1" = c("0" = "beige","0.1"= "lemonchiffon1","1"="lemonchiffon2","2"="khaki1","4"="khaki2",
                                                                               "8"="khaki3","20" = "khaki4"),
                                                                   "Experiment" = c("A" = "antiquewhite1","B"="antiquewhite2","C"="antiquewhite3",
                                                                                    "D"="cornsilk4","MA"="antiquewhite1","MC"="antiquewhite2","LA"="cornsilk1","LB"="cornsilk1")))

ht_h1<- Heatmap(h1_matrix,name = "Number of SVs",col=col_fun,right_annotation = row_anno_h1,show_row_names = F,
        cluster_rows = F, show_column_dend = F, column_order = h1_order,row_split = c(rep("A",6),rep("B",9)),
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

ht<-ht_c0 + ht_h1 + ht_hd
?pdf
#pdf(file = "oncogrid_190509.pdf",width = 8.27, height = 11.69) # for A4 size
pdf(file = "oncogrid_190510.pdf",width = 8.27, height = 5)
draw(ht,merge_legend=T)
dev.off()

