library(ComplexHeatmap)
getwd()
setwd('/home/users/yssong/uveal_melanoma/12_SNP_INDEL_annotation')

info <- read.table("snp_indel_list_1.txt",header=T,sep='\t',row.names = 1)
info[1:5,1:5]

class(info)
info <- as.matrix(info)

get_type_fun = function(x) strsplit(x, ";")[[1]]
get_type_fun(info)

info[1:5,1:5]
isFALSE(info[1,1]=="")

col = c(missense = "red", nonsense = "blue", splicing = 'green', frameshift = 'yellow')
oncoPrint(info,
          alter_fun = list(
            missense = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
                                                 gp = gpar(fill = col["missense"], col = NA)),
            nonsense = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
                                                   gp = gpar(fill = col["nonsense"], col = NA)),
            splicing = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
                                                      gp = gpar(fill = col["splicing"], col = NA)),
            frameshift = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
                                                      gp = gpar(fill = col["frameshift"], col = NA))
          ), col = col,show_column_names = T)


# Figure for chromothripsis segmentation
x<-c(3485766,4559044,4572762,5013825,5016252,7201907,7448811,8697086,8738488,11921126,11936612,11953551,15371093,15496942,15515653,15566321,15568170,17511041,17512410,18640930,18659281,20572843,20600502,21424067,22072614,22092195,22092242,22919681,22924175,22945510,24219772,24527882,24536289,24665000,24669536,25721042,25728354,25735432,25735640,26610572,26945502,27460661,27461425,28353188,29468000,31253805)
xx<- x-3485766
y<-rep(4,46)
z<-rep(c("red","red","green","green","blue","blue"),8)
pdf(file = "S1N2P16_4-8_chromothripsis_segmentation.pdf")
plot(x,y,type = 'h',col = z,axes=F,ylim=c(0,10))
text(x,8,labels = x,col=z,srt=90)
text(x,5,pos = 2,labels = seq(from=1,to=46),col=z)
dev.off()
?text
?axis()
?plot

a<-c(3485766,4559044,4572762,5013825,5016252,7201907,7448811,8697086,8738488,11921126,11936612,11953551,15371093,15496942,15515653,15566321,15568170,16500320,17511041,17512410,18640930,18659281,20572843,20600502,21424067,22072614,22092195,22092242,22919681,22924175,22945510,24219772,24292137,24527882,24536289,24665000,24669536,25721042,25728354,25735432,25735640,26610572,26945502,27460661,27461425,28353188,29468000,29792244,31253805)
b<-c(4559044,4572762,5013825,5016252,7201907,7448811,8697086,8738488,11921126,11936612,11953551,15371093,15496942,15515653,15566321,15568170,16500320,17511041,17512410,18640930,18659281,20572843,20600502,21424067,22072614,22092195,22092242,22919681,22924175,22945510,24219772,24292137,24527882,24536289,24665000,24669536,25721042,25728354,25735432,25735640,26610572,26945502,27460661,27461425,28353188,29468000,29792244,31253805,32083955)

c<- b-a
cbind(b,c)
c <- as.matrix(c,ncol=1)

pdf("temp.pdf")
barplot(c,horiz = T, beside = F,col=c("black","red","gray","blue"))
dev.off()



library(ggplot2)
d<-as.data.frame(cbind(b,c))
colnames(d) <- c("Abs","Rel")
d<-d[-49,]

initial_ring <- as.data.frame(matrix(data = c(1073278,200000,13718,200000,441063,200000,2427,200000,2185655,200000,246904,200000,1248275,200000,41402,200000,3182638,200000,15486,200000,16939,200000,3417542,200000,125849,200000,18711,200000,50668,200000,1849,200000,932150,1010721,200000,1369,200000,1128520,200000,18351,200000,1913562,200000,27659,200000,823565,200000,648547,200000,19581,200000,47,200000,827439,200000,4494,200000,21335,200000,1274262,200000,72365,235745,200000,8407,200000,128711,200000,4536,200000,1051506,200000,7312,200000,7078,200000,208,200000,874932,200000,334930,200000,515159,200000,764,200000,891763,200000,1114812,200000,324244,200000,1461561),ncol=1))
col <- c(rep(c("black","white"),16),'black',rep(c("gray95","white"),14),"gray95",rep(c("gray70","white"),14),"gray70","white","gray95")
length(col)
nrow(initial_ring)

initial_ring$pt <- initial_ring$V1/sum(initial_ring$V1)
initial_ring$ymax <- cumsum(initial_ring$pt)
initial_ring$ymin <- c(0,head(initial_ring$ymax,n=-1))
initial_ring$pt
initial_ring$ymax

initial_ring$col <- col
initial_ring$med <- (initial_ring$ymax+initial_ring$ymin)/2
initial_ring$col
label1<-LETTERS[seq(from=1,to=23)]
label2<-rep("",23)
label3<-letters[seq(from=1,to=23)]
label4<-rep("",23)
label5<-cbind(label1,label2,label3,label4)
label6<-as.vector(t(label5))
nrow(initial_ring)
?seq()

############ initial ring segment shattering for S1N2P16_4-8 chr15###########
library(ggplot2)
library(tidyverse)
theme_clean=function(base_size=12){
  theme_grey(base_size) %+replace%
    theme(
      axis.title=element_blank(),
      axis.text=element_blank(),
      panel.background=element_blank(),
      panel.grid=element_blank(),
      axis.ticks.length=unit(0,"cm"),
      axis.ticks.margin=unit(0,"cm"),
      panel.margin=unit(0,"lines"),
      plot.margin=unit(c(0,0,0,0),"lines"),
      complete=TRUE
    )
}  
chr15<-read.table("chr15_idogram.txt",header=F,sep='\t')
chr15
chr15$length = chr15$V3-chr15$V2
chr15$color <- NA
chr15$color[chr15$V5 == 'gpos100'] <- 'black'
chr15$color[chr15$V5 == 'gneg'] <- 'gray95'
chr15$color[chr15$V5 == 'gpos33'] <- 'gray70'
chr15$color[chr15$V5 == 'gpos66'] <- 'gray50'
chr15$text <- NA
chr15$text[chr15$V5 == 'gpos100'] <- 'white'
chr15$text[chr15$V5 == 'gneg'] <- 'black'
chr15$text[chr15$V5 == 'gpos33'] <- 'black'
chr15$text[chr15$V5 == 'gpos66'] <- 'white'
chr15$V4 <- gsub("q","",chr15$V4)
chr15
barplot(as.matrix(chr15$length,nrow = 1),horiz = T, beside = F,col=chr15$color,border = chr15$color,width = 1)
text((chr15$V2+chr15$V3)/2,0.25,col = chr15$text,labels = chr15$V4,cex = 0.7)

initial_ring <- read.table("4-8_chromothripsis_info.txt",header=T,sep='\t')
initial_ring
#initial_ring$ymax <- cumsum(initial_ring$percent)
#initial_ring$ymin <- c(0,head(initial_ring$ymax,n=-1))
#initial_ring$ypos <- (initial_ring$ymax+initial_ring$ymin)/2
pri_ring <- filter(.data = initial_ring,initial_ring$exist!='0')
pri_ring$percent <- pri_ring$size/sum(pri_ring$size)
pri_ring$ymax <- cumsum(pri_ring$percent)
pri_ring$ymin <- c(0,head(pri_ring$ymax,n=-1))
pri_ring$ypos <- (pri_ring$ymax+pri_ring$ymin)/2
pdf("ring.pdf")
ggplot(pri_ring)+
  geom_rect(aes(xmin=2.5,xmax=4,ymin=ymin,ymax=ymax),fill=pri_ring$col)+
  coord_polar(theta='y')+
  xlim(0,5)+
  #geom_text(aes(label=pri_ring$label,x=3.75+0.5*pri_ring$exist,y=ypos),size=3+0.5*pri_ring$exist,color = pri_ring$textcol)+
  #geom_segment(data=initial_ring,mapping=aes(x=3.5,xend=4.1,y=ypos,yend=ypos),linetype='dashed',color='gray')+
  theme_clean()

ggplot(initial_ring)+
  geom_rect(aes(xmin=3,xmax=4,ymin=ymin,ymax=ymax),fill=initial_ring$col)+
  coord_polar(theta='y')+
  xlim(0,5)+
  geom_text(aes(label=initial_ring$label,x=3.6+0.85*initial_ring$exist,y=ypos),size=6+initial_ring$exist,color = initial_ring$textcol)+
  geom_segment(data=initial_ring,mapping=aes(x=3.5+0.5*initial_ring$exist,xend=3.5+0.5*initial_ring$exist+0.1*initial_ring$exist,y=ypos,yend=ypos),color=initial_ring$textcol)+
  theme_clean()
dev.off()

segm<- read.table("4-8_seg_info.txt",header=T,sep='\t')
segm
temp<-as.data.frame(matrix(c("",500000,"white",0,"white"),nrow = 1))
colnames(temp)<-colnames(segm)
for(i in 1:26){
  if(i==1){
    new_seg<-rbind(segm[i,],temp[1,])
  } else {
    new_seg<-rbind(new_seg,segm[i,],temp[1,])
  }
  
}
rownames(new_seg)<-seq(from=1,to=52)
new_seg<-new_seg[-10,]
rownames(new_seg)<-seq(from=1,to=51)
new_seg<-new_seg[-19,]
rownames(new_seg)<-seq(from=1,to=50)
new_seg<-new_seg[-26,]
rownames(new_seg)<-seq(from=1,to=49)
new_seg[11,"size"] <- 1000000
new_seg$ymax <- cumsum(new_seg$size)
new_seg$ymin <- c(0,head(new_seg$ymax,n=-1))
new_seg$ypos <- (new_seg$ymax + new_seg$ymin) / 2
new_seg$label[10]<-"";new_seg$label[18]<-"";new_seg$label[25]<-""
#new_seg[new_seg$col=='black',]$textcol<-'black'
new_seg<-new_seg[-8,]
rownames(new_seg)<-seq(from=1,to=48)

pdf("4-8_preligation.pdf")
barplot(as.matrix(new_seg$size,nrow = 1),horiz = T, beside = F,col=new_seg$col,border = new_seg$col,width = 1)
text(new_seg$ypos,0.2,col = new_seg$textcol,labels = new_seg$label,cex = 0.7)
dev.off()
new_seg
seg2<-new_seg[new_seg$size!="500000",]
seg2<-seg2[seg2$size!="1000000",]
nrow(seg2)
seg2
pdf("4-8_ligation.pdf")
barplot(as.matrix(seg2$size,nrow = 1),horiz = T, beside = F,col=seg2$col,border = seg2$col,width = 1)
dev.off()

pdf("4-8_cn3.pdf")
seg3<-rbind(c("chr19","100000","brown","1","black",0,0,0),seg2,c("chr15","100000","gray","1","black",0,0,0))
nrow(seg3)
seg4<-rbind(seg3,as.data.frame(apply(seg3,2,rev)))
seg4$ymax<-cumsum(seg4$size)
seg4$ymin<-c(0,head(seg4$ymax,n=-1))
seg4$ypos<-(seg4$ymax+seg4$ymin)/2
seg4
ggplot(seg4)+
  geom_rect(aes(xmin=2.5,xmax=4,ymin=ymin,ymax=ymax),fill=seg4$col)+
  coord_polar(theta='y',start = 3*pi/2)+
  xlim(0,5)+
  theme_clean()
dev.off()



#lost segments
lowercase <- letters[1:26]
if( %in% lowercase)
lost_seg <- initial_ring[initial_ring$label %in% lowercase,]
nrow(lost_seg)

temp_lost<-as.data.frame(matrix(c("",200000,0,0,0,"white",0,-1,"white"),nrow = 1))
colnames(temp_lost) <- colnames(lost_seg)
for(i in 1:22){
  if(i==1){
    new_lost<-rbind(lost_seg[i,],temp_lost[1,])
  } else {
    new_lost<-rbind(new_lost,lost_seg[i,],temp_lost[1,])
  }
}
new_lost
new_lost$ymax <-cumsum(new_lost$size)
new_lost$ymin <- c(0,head(new_lost$ymax,-1))
new_lost$ypos <- (new_lost$ymax+new_lost$ymin)/2

pdf("4-8-lost.pdf")
barplot(as.matrix(new_lost$size,nrow = 1),horiz = T, beside = F,col=new_lost$col,border = new_lost$col,width = 1,ylim=c(0,2))
text(new_lost$ypos,0.1,col = new_lost$textcol,labels = new_lost$label,cex = 1)
dev.off()
