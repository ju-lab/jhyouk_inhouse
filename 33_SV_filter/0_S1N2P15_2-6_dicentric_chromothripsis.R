# S1N2P15_2-6 dicentric chromosome

setwd("/home/users/jhyouk/99_reference/mouse/mm10")
chr15 <- read.table("cytoBandIdeo_mouse_chr12.txt")
chr15$length = chr15$V3-chr15$V2
chr15$color <- NA
chr15$color[chr15$V5 == 'gpos100'] <- 'black'
chr15$color[chr15$V5 == 'gneg'] <- 'gray95'
chr15$color[chr15$V5 == 'gpos33'] <- 'gray70'
chr15$color[chr15$V5 == 'gpos66'] <- 'gray50'
chr15$V4 <- gsub("q","",chr15$V4)
chr15
pdf("chr12_ideogram.pdf")
barplot(as.matrix(chr15$length,nrow = 1),horiz = T, beside = F,col=chr15$color,border = chr15$color,width = 1)
dev.off()

chr15 <- read.table("cytoBandIdeo_mouse_chrX.txt")
chr15$length = chr15$V3-chr15$V2
chr15$color <- NA
chr15$color[chr15$V5 == 'gpos100'] <- 'black'
chr15$color[chr15$V5 == 'gneg'] <- 'gray95'
chr15$color[chr15$V5 == 'gpos33'] <- 'gray70'
chr15$color[chr15$V5 == 'gpos66'] <- 'gray50'
chr15$V4 <- gsub("q","",chr15$V4)
chr15
pdf("chrX_ideogram.pdf")
barplot(as.matrix(chr15$length,nrow = 1),horiz = T, beside = F,col=chr15$color,border = chr15$color,width = 1)
dev.off()

setwd("/home/users/jhyouk/99_reference/mouse/mm10")
chr15 <- read.table("cytoBandIdeo_mouse_chrX.txt")
chr15$length = chr15$V3-chr15$V2
chr15$color <- NA
chr15$color[chr15$V5 == 'gpos100'] <- 'thistle4'
chr15$color[chr15$V5 == 'gneg'] <- 'thistle1'
chr15$color[chr15$V5 == 'gpos33'] <- 'thistle2'
chr15$color[chr15$V5 == 'gpos66'] <- 'thistle3'
chr15$V4 <- gsub("q","",chr15$V4)
chr15
pdf("chrX_ideogram.pdf")
barplot(as.matrix(chr15$length,nrow = 1),horiz = T, beside = F,col=chr15$color,border = chr15$color,width = 1)
dev.off()

setwd("/home/users/jhyouk/99_reference/mouse/mm10")
chr15 <- read.table("cytoBandIdeo_mouse_chrX.txt")
chr15$length = chr15$V3-chr15$V2
chr15$color <- NA
chr15$color[chr15$V5 == 'gpos100'] <- 'plum4'
chr15$color[chr15$V5 == 'gneg'] <- 'plum1'
chr15$color[chr15$V5 == 'gpos33'] <- 'plum2'
chr15$color[chr15$V5 == 'gpos66'] <- 'plum3'
chr15$V4 <- gsub("q","",chr15$V4)
chr15
pdf("chrX_ideogram.pdf")
barplot(as.matrix(chr15$length,nrow = 1),horiz = T, beside = F,col=chr15$color,border = chr15$color,width = 1)
dev.off()



######### chr 14
setwd("/home/users/jhyouk/99_reference/mouse/mm10")
chr15 <- read.table("cytoBandIdeo_mouse_chr14.txt")
chr15$length = chr15$V3-chr15$V2
chr15$color <- NA
chr15$color[chr15$V5 == 'gpos100'] <- 'bisque4'
chr15$color[chr15$V5 == 'gneg'] <- 'bisque1'
chr15$color[chr15$V5 == 'gpos33'] <- 'bisque2'
chr15$color[chr15$V5 == 'gpos66'] <- 'bisque3'
pdf("chr14_ideogram.pdf")
barplot(as.matrix(chr15$length,nrow = 1),horiz = T, beside = F,col=chr15$color,border = chr15$color,width = 1)
dev.off()

######### chr 15
setwd("/home/users/jhyouk/99_reference/mouse/mm10")
chr15 <- read.table("cytoBandIdeo_mouse_chr15.txt")
chr15$length = chr15$V3-chr15$V2
chr15$color <- NA
chr15$color[chr15$V5 == 'gpos100'] <- 'darkseagreen4'
chr15$color[chr15$V5 == 'gneg'] <- 'darkseagreen1'
chr15$color[chr15$V5 == 'gpos33'] <- 'darkseagreen2'
chr15$color[chr15$V5 == 'gpos66'] <- 'darkseagreen3'
pdf("chr15_ideogram.pdf")
barplot(as.matrix(chr15$length,nrow = 1),horiz = T, beside = F,col=chr15$color,border = chr15$color,width = 1)
dev.off()
