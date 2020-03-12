###############################
# 
# A SET OF HELPER FUNCTIONS
# 
# Written by Joonoh Lim (Ju lab; joonoh.lim@kaist.ac.kr)  
#
# First created on 2020-1-14
# Last modified on 2020-3-4
###############################
library(magrittr)

# FUNCTION: mkdir
mkdir <- function(path=NULL){
  if(!dir.exists(path)){
    dir.create(path, recursive=TRUE)
  }
} # create directory if it does not exist

# FUNCTION: generateFeatureSet2
# INPUT:
#     1) features: a vector of ("COSMIC.SNV" and/or "COSMIC.DBS" and/or "COSMIC.INDEL")
#     2) operations: a list containing functions to apply to the output
# OUTPUT: a data table of features
# DEVEL: 2020-1-7
# TODO: only COSMIC.INDEL has been implemented currently
generateFeatureSet2 <- function(features=c("COSMIC.SNV","COSMIC.DBS","COSMIC.INDEL"), sep="_", operations = NULL){
  
  # Sanity check
  if (!is.vector(features)){stop("The argument 'features' must be a vector.")}
  if (!any(features %in% c("COSMIC.SNV","COSMIC.DBS","COSMIC.INDEL"))){
    stop("Unrecognizable input for the argument 'features'. Choose among COSMIC.SNV, COSMIC.DBS, COSMIC.INDEL")
  }
  
  #
  sep <- sep
  
  # HELPER FUNCTION: combineFeature
  # INPUT: M = a vector of major variable, m = a vector minor variable, sep = a delimiter
  # OUTPUT: a vector of combinations of M and m elements
  combineFeature <- function(M=NULL, m=NULL, sep="_"){
    paste0(rep(M, each=length(m)),
           sep,
           rep(m, times=length(M)))
  }
  # HELPER FUNCTION: addPlusTotheLastElement
  addPlusTotheLastElement <- function(vec=NULL){
    end <- length(vec)
    vec[end] <- paste0(vec[end],"+")
    return(vec)
  }
  # HELPER FUNCTION: combineFeature2
  combineFeature2 <- function(M=NULL, m=NULL, sep="_"){
    
    if(is.vector(M) & class(M)!="list" & is.vector(m) & class(m)!="list"){
      OUT <- combineFeature(M,m,sep)
    }
    if(is.vector(M) & class(M)!="list" & class(m)=="list"){
      m_len <- lengths(m)
      M_unlisted <- lapply(1:length(M), function(i){
        rep(M[i], each = m_len[i])
      }) %>% unlist
      OUT <- paste0(M_unlisted, sep, unlist(m))
    }
    if(class(M)=="list" & is.vector(m) & class(m)!="list"){
      M_len <- lengths(M)
      m_unlisted <- lapply(1:length(m), function(i){
        rep(m[i], each = M_len[i])
      }) %>% unlist
      OUT <- paste0(unlist(M), sep, m_unlisted)
    }
    if(class(M)=="list" & class(m)=="list"){
      OUT <- paste0(unlist(M), sep, unlist(m))
    }
    
    return(OUT)
  }
  
  # COSMIC.INDEL
  if (any(features %in% "COSMIC.INDEL")){
    # There are (type, subtype, subsubtype) to represent INDEL features
    # 1bp deletion
    type <- "d1"
    base <- c("c","t")
    Homopolymer_length <- addPlusTotheLastElement(1:6)
    sub_subsub <- combineFeature(base, Homopolymer_length, sep)
    f1.type_sub_subsub <- combineFeature(type, sub_subsub, sep)
    
    # 1bp insertion
    type <- "i1"
    base <- c("c","t")
    Homopolymer_length <- addPlusTotheLastElement(0:5)
    sub_subsub <- combineFeature(base, Homopolymer_length, sep)
    f2.type_sub_subsub <- combineFeature(type, sub_subsub, sep)
    
    # > 1bp deletions at repeats (Deletion length)
    type <- "d2"
    Deletion_length <- 2:5
    Deletion_length <- addPlusTotheLastElement(Deletion_length)
    Number_of_repeat_units <- addPlusTotheLastElement(1:6)
    sub_subsub <- combineFeature(Deletion_length, Number_of_repeat_units, sep)
    f3.type_sub_subsub <- combineFeature(type, sub_subsub, sep)
    
    # > 1bp insertions at repeats (Insertion length)
    type <- "i2"
    Insertion_length <- addPlusTotheLastElement(2:5)
    Number_of_repeat_units <- addPlusTotheLastElement(0:5)
    sub_subsub <- combineFeature(Insertion_length, Number_of_repeat_units, sep)
    f4.type_sub_subsub <- combineFeature(type, sub_subsub, sep)
    
    # Delections with microhomology (Deletion length)
    type <- "mh"
    Deletion_length <- addPlusTotheLastElement(2:5)
    Microhomology_length <- list(1, 1:2, 1:3, addPlusTotheLastElement(1:5))
    sub_subsub <- combineFeature2(Deletion_length, Microhomology_length, sep)
    f5.type_sub_subsub <- combineFeature(type, sub_subsub, sep)
    
    # Summing up
    feats <- c(f1.type_sub_subsub,
               f2.type_sub_subsub,
               f3.type_sub_subsub,
               f4.type_sub_subsub,
               f5.type_sub_subsub
    )
    OUT <- feats %>% strsplit(split=sep) %>% lapply(function(x){data.frame(type=x[1], subtype=x[2], subsubtype=x[3])}) %>% do.call(rbind,.) %>% data.table::as.data.table()
  }
  
  # Additional operations
  # if (! is.null(operations)) {
  #   if (is.list(operations)) {
  #     for (i in 1:length(out)) { x <- names(out)[i]; if (x %in% names(operations)) { out[[x]] <- operations[[x]](out[[x]]) } }
  #   }
  #   else {stop("Invalid input for 'operations'. It should be a list containing functions with names of feature sets to apply.")}
  # }
  
  return(OUT)
  
}

# FUNCTION: tailor_INDEL_data
tailor_INDEL_data <- function(DT=NULL){
  # DEPENDENCY: generateFeatureSet2
  # Transpose 
  DT <- data.table::transpose(DT, keep.names = "INDEL", make.names = "ID") %>% .[-1,]
  # Mapping features
  INDEL.feats <- generateFeatureSet2("COSMIC.INDEL")
  INDEL.feats.2D <- INDEL.feats %>% tidyr::unite(col="type", sep="_", type, subtype) %>% set_names(c("type","subtype"))
  DT$INDEL <- NULL
  DT <- cbind(INDEL.feats.2D, DT)
  
  return(DT)
} # used in generate_input_data()

## FUNCTION: plotMutationalSpectrum2 : 2019-10-30, 2019-11-25, 2020-1-7
# INPUT: df, color.palette = {"COSMIC.SNV", "COSMIC.SNV.192", "COSMIC.DBS", "COSMIC.INDEL"}
# OUTPUT: a plot
# NOTE: 2019-11-27, color.palette is now 'COSMIC.SNV' by default
plotMutationalSpectrum2 <- function(df = NULL, y.max = NULL, bar.width = 0.5,
                                    type.name = "type", subtype.name = "subtype", value.name = "count",
                                    color.palette = "COSMIC.SNV", newpage = TRUE,
                                    upperLabels.y = 0.05, upperLabels.height = 0.25,
                                    upperLabels.text.y = 0.35, upperLabels.text.fontsize = 12,
                                    xLabels.text.y = 0.5, xLabels.text.fontsize = 10,
                                    yLabels.text.x = 0.9, yLabels.text.fontsize = 10,
                                    yLabels.text.decimals = 1, yLabels.text.suffix = "",
                                    title.innerFrame.upperLeft = "", title.innerFrame.upperLeft.fontsize = 20,
                                    bar.edge.color = NA, background.alpha = 0.1,
                                    left.margin = 0.05, right.margin = 0.05){
  # Test set
  ## SNV
  ## DBS
  
  # Packages
  suppressMessages(library(grid))
  suppressMessages(library(magrittr))
  suppressMessages(library(data.table))
  # Color palette
  ## Presets
  palette.COSMIC.SNV.96 <- paste0("#",c(`C>A`="1EBFF0",`C>G`="050708",`C>T`="E62725",`T>A`="CBCACB",`T>C`="A1CF64",`T>G`="EDC8C5"))
  palette.COSMIC.SNV.192 <- paste0("#",c(`A>C`="B6CCFF",`A>G`="B3853C",`A>T`="808080",`G>A`="0000FF",`G>C`="000000",`G>T`="FFD000",
                                         `C>A`="1EBFF0",`C>G`="050708",`C>T`="E62725",`T>A`="CBCACB",`T>C`="A1CF64",`T>G`="EDC8C5"))
  palette.COSMIC.DBS <- paste0("#",c(AC="A6CEE3",AT="1F78B4",CC="B2DF8A",CG="33A02C",CT="FB9A99",GC="E31A1C",TA="FDBF6F",TC="FF7F00",TG="CAB2D6",TT="6A3D9A"))
  palette.COSMIC.INDEL <- paste0("#",c(`D1_C`="FCBF6F",
                                       `D1_T`="FD8103",
                                       `I1_C`="B2DB8D",
                                       `I1_T`="36A034",
                                       `D2_2`="FEC9B7",
                                       `D2_3`="FE886A",
                                       `D2_4`="F34433",
                                       `D2_5+`="BD181C",
                                       `I2_2`="D0E1F3",
                                       `I2_3`="96C4DE",
                                       `I2_4`="4798CD",
                                       `I2_5+`="1764AA",
                                       `MH_2`="DCE2F2",
                                       `MH_3`="B6B6D8",
                                       `MH_4`="8584BE",
                                       `MH_5+`="63409C")) # 2010-01-07
  
  if (is.null(color.palette)) {
    stop("Please provide input for 'color.palette' (currently, 'COSMIC.SNV', 'COSMIC.SNV.192', 'COSMIC.DBS' are available)")
  } else if (color.palette == "COSMIC.SNV") {
    color.palette <- palette.COSMIC.SNV.96
  } else if (color.palette == "COSMIC.SNV.192") {
    color.palette <- palette.COSMIC.SNV.192
  } else if (color.palette == "COSMIC.DBS") {
    color.palette <- palette.COSMIC.DBS
  } else if (color.palette == "COSMIC.INDEL"){
    color.palette <- palette.COSMIC.INDEL
  } else {
    stop("Invalid input for 'color.palette'")
  }
  
  # Reformatting input df
  #df <- tmp.h5.proc.df # FOR DEBUGGING
  #df <- df %>% as.data.table
  #df <- df[, c(type=type.name, subtype=subtype.name, count=value.name), with = FALSE]
  #df <- df[, c(type.name, subtype.name, value.name), with = FALSE]
  df <- df %>% as.data.frame
  df <- df[, c(type.name, subtype.name, value.name)]
  df[["type_subtype"]] <- paste0(df$type,":",df$subtype)
  #df[, type_subtype := paste0(type,":",subtype)]
  setnames(df, old=value.name, "count")
  
  # Plot
  if (newpage == TRUE){grid.newpage()} else {
    initial.vp <- current.viewport()
    if (initial.vp$name == "ROOT") {
      backToTheInitialVp <- parse(text="upViewport(0)")
    } else {
      backToTheInitialVp <- parse(text="seekViewport(initial.vp$name)")
    }
  } # 2019-11-05
  # Outer frame
  # x.outer <- 0.05; y.outer <- 0.05; w.outer <- 0.9; h.outer <- 0.9 # for devel.
  x.outer <- 0; y.outer <- 0; w.outer <- 1; h.outer <- 1
  #pushViewport(viewport(name = "vp.outerFrame", x = x.outer, y = y.outer, width = w.outer, height = h.outer, just = c("left","bottom"))) # level 1
  pushViewport(viewport(x = x.outer, y = y.outer, width = w.outer, height = h.outer, just = c("left","bottom"))) # level 1 # 2019-11-05
  vp.outerFrame <- current.viewport()$name # 2019-11-05
  # grid.rect(name = "rect.outerFrame") # for devel.
  
  # Inner frame
  # x.inner <- 0.1; y.inner <- 0.1; w.inner <- 0.8; h.inner <- 0.8
  # x.inner <- 0.1; y.inner <- 0.1; w.inner <- 0.8; h.inner <- 0.7
  # x.inner <- 0.05; y.inner <- 0.1; w.inner <- 0.9; h.inner <- 0.7
  x.inner <- left.margin; y.inner <- 0.1; w.inner <- 1-left.margin-right.margin; h.inner <- 0.7
  #pushViewport(viewport(name = "vp.innerFrame", x = x.inner, y = y.inner, width = w.inner, height = h.inner, just = c("left","bottom")))
  pushViewport(viewport(x = x.inner, y = y.inner, width = w.inner, height = h.inner, just = c("left","bottom"))) # 2019-11-05
  vp.innerFrame <- current.viewport()$name # 2019-11-05
  grid.rect(name = "rect.innerFrame", gp = gpar(col="gray",lwd=1))
  
  # Y-axis labels
  x.y_axis <- 0; y.y_axis <- 0; w.y_axis <- x.inner; h.y_axis <- 1
  upViewport()
  #pushViewport(viewport(name = "vp.y_axis", x = x.y_axis, y = y.y_axis, width = w.y_axis, height = h.y_axis, just = c("left","bottom")))
  pushViewport(viewport(x = x.y_axis, y = y.y_axis, width = w.y_axis, height = h.y_axis, just = c("left","bottom"))) # 2019-11-05
  vp.y_axis <- current.viewport()$name # 2019-11-05
  # grid.rect(name = "rect.y_axis") # for devel.
  
  # X-axis labels
  x.x_axis <- x.inner; y.x_axis <- 0; w.x_axis <- w.inner; h.x_axis <- y.inner
  upViewport()
  #pushViewport(viewport(name = "vp.x_axis", x = x.x_axis, y = y.x_axis, width = w.x_axis, height = h.x_axis, just = c("left","bottom")))
  pushViewport(viewport(x = x.x_axis, y = y.x_axis, width = w.x_axis, height = h.x_axis, just = c("left","bottom"))) # 2019-11-05
  vp.x_axis <- current.viewport()$name # 2019-11-05
  # grid.rect(name = "rect.x_axis") # for devel.
  
  # Inner drawings (loop)
  ## Some initial workups
  #df.type <- df$type %>% table %>% as.data.frame
  # 2020-1-7, ISSUE => table() rearranges the order of df$type, which is not desired and the original order should be kept.
  df$type <- factor(df$type, levels=unique(df$type), ordered=TRUE) # 2020-1-7, this resolves the issue
  df.type <- df$type %>% table %>% as.data.frame
  
  w.bar_field.scaleFactor <- sum(df.type$Freq)
  ### h.bar.scaleFactor
  if (is.null(y.max)) {
    y.max <- max(df[["count"]]) * 1/(3/4 + 1/4*1/10)
  }
  h.bar.scaleFactor <- 1/y.max # h.bar.scaleFactor scales each bar height into the [0,1] scale.
  df.count.pointer <- 1
  df.subtype.pointer <- 1
  x.bar.field.pointer <- x.inner
  x.xLabels.field.pointer <- 0
  
  ## Sanity checks
  if (bar.width > 1 | bar.width < 0) { stop("Wrong range input for bar.width") }
  if (is.null(color.palette)) { stop("Input for 'color.palette' is missing") }
  
  ## Drawing bars
  ### Bar field
  for (i in 1:nrow(df.type)) {
    #seekViewport("vp.outerFrame")
    seekViewport(vp.outerFrame) # 2019-11-05
    x.bar_field <- x.bar.field.pointer
    w.bar_field <- df.type$Freq[i]/w.bar_field.scaleFactor*w.inner
    y.bar_field <- y.inner
    h.bar_field <- h.inner
    #pushViewport(viewport(name = paste0("vp.barField.",df.type$.[i]), x = x.bar_field, y = y.bar_field, width = w.bar_field, height = h.bar_field, just = c("left","bottom")))
    pushViewport(viewport(x = x.bar_field, y = y.bar_field, width = w.bar_field, height = h.bar_field, just = c("left","bottom"))) # 2019-11-05
    vp.barField.name <- paste0("vp.barField.",df.type$.[i]) # 2019-11-05
    assign(vp.barField.name,current.viewport()$name) # 2019-11-05
    #grid.rect(name = paste0("rect.barField.",df.type$.[i]),
    grid.rect(name = paste0(vp.barField.name,".rect.barField.",df.type$.[i]),
              gp=gpar(col=NA,#color.palette[i],
                      fill=color.palette[i],
                      alpha=background.alpha))
    ### Bar drawings
    #### Now in vp.barField
    x.bar.pointer <- 1/2*1/df.type$Freq[i] - 1/2*bar.width/df.type$Freq[i]
    for (j in 1:df.type$Freq[i]) {
      #grid.rect(name = paste0("rect.bar.",df$type_subtype[df.count.pointer]),
      grid.rect(name = paste0(vp.barField.name,".rect.bar.",df$type_subtype[df.count.pointer]),
                just = c("left","bottom"),
                x = x.bar.pointer,
                y = 0,
                width = bar.width/df.type$Freq[i],
                height = df[["count"]][df.count.pointer] * h.bar.scaleFactor,
                gp=gpar(fill=color.palette[i],
                        col=bar.edge.color))
      df.count.pointer <- df.count.pointer + 1
      # Do not let x.bar.pointer be updated in the last loop
      if (j != df.type$Freq[i]) {
        x.bar.pointer <- x.bar.pointer + 1/df.type$Freq[i]
      }
    }
    ### X labels
    #seekViewport("vp.x_axis")
    seekViewport(vp.x_axis) # 2019-11-05
    x.xLabels.pointer <- 1/2*1/df.type$Freq[i]
    for (j in 1:df.type$Freq[i]){
      grid.text(label = df$subtype[df.subtype.pointer],
                #name = paste0("text.xLabel.",df$subtype[df.subtype.pointer]),
                name = paste0(vp.x_axis,".text.xLabel.",df$subtype[df.subtype.pointer]), # 2019-11-05
                just = c("center","center"),
                x = x.xLabels.field.pointer + x.xLabels.pointer*df.type$Freq[i]/w.bar_field.scaleFactor,
                y = xLabels.text.y,
                rot = 90,
                gp = gpar(fontsize = xLabels.text.fontsize, fontfamily = "mono") # fontframily = "mono" is Courier
      )
      df.subtype.pointer <- df.subtype.pointer + 1
      x.xLabels.pointer <- x.xLabels.pointer + 1/df.type$Freq[i]
    }
    ### Upper labels
    #seekViewport("vp.outerFrame")
    seekViewport(vp.outerFrame) # 2019-11-05
    if (upperLabels.y < 0 | upperLabels.y > 1) {stop("Invalid range for 'upperLabels.y'.")}
    if (upperLabels.height < 0 | upperLabels.height > 1) {stop("Invalid range for 'upperLabels.height'.")}
    
    x.upperLabels <- x.bar.field.pointer + w.bar_field*(1/2*1/df.type$Freq[i] - 1/2*bar.width/df.type$Freq[i])
    w.upperLabels <- w.bar_field*(x.bar.pointer + 1/2*bar.width/df.type$Freq[i])
    y.upperLabels <- y.inner + h.inner + (1 - (y.inner + h.inner))*upperLabels.y
    #grid.rect(name = paste0("rect.upperLabel.",df.type$.[i]),
    grid.rect(name = paste0(vp.outerFrame,".rect.upperLabel.",df.type$.[i]),
              just = c("left","bottom"),
              x = x.upperLabels,
              y = y.upperLabels,
              width = w.upperLabels,
              height = upperLabels.height*(1 - (y.inner + h.inner)),
              gp = gpar(fill=color.palette[i],col=NA)
    )
    ### Upper texts
    y.upperLabels.text <- y.inner + h.inner + (1 - (y.inner + h.inner))*upperLabels.text.y
    #grid.text(name = paste0("text.upperLabel.",df.type$.[i]),
    grid.text(name = paste0(vp.outerFrame,".text.upperLabel.",df.type$.[i]),
              label = df.type$.[i],
              just = c("center","bottom"),
              x = x.upperLabels + 0.5*w.upperLabels,
              y = y.upperLabels.text,
              gp = gpar(fontsize = upperLabels.text.fontsize)
    )
    ### Y labels
    #seekViewport("vp.y_axis")
    seekViewport(vp.y_axis) # 2019-11-05
    x.yLabels <- yLabels.text.x
    y.yLabels <- y.inner
    labels.yLabels <- seq(0,y.max,length.out = 5)
    h.bar_field.quartiles <- seq(0,h.inner,length.out = 5) # w.r.s.t. vp.y_axis
    for (j in 1:5){
      vp.y_axis
      #grid.text(name = paste0("text.yLabels.",j),
      grid.text(name = paste0(vp.y_axis,".text.yLabels.",j),
                label = paste0(round(labels.yLabels[j],yLabels.text.decimals),yLabels.text.suffix),
                just = c("right","center"),
                x = x.yLabels,
                y = y.inner + h.bar_field.quartiles[j],
                gp = gpar(fontsize = yLabels.text.fontsize, fontfamily = "mono")
      )
    }
    ### Y inward ticks and horizontal lines
    #seekViewport("vp.innerFrame")
    seekViewport(vp.innerFrame) # 2019-11-05
    h.bar_field.quartiles2 <- seq(0,1,length.out = 5) # w.r.s.t. vp.innerFrame
    for (j in 2:4){
      #### orizontal lines
      grid.segments(x0 = 0,
                    x1 = 1,
                    y0 = h.bar_field.quartiles2[j],
                    y1 = h.bar_field.quartiles2[j],
                    gp = gpar(col="gray", lwd = 0.75, alpha = 1/5)
      )
      #### 3 inward ticks
      grid.segments(x0 = 0,
                    x1 = 1/w.bar_field.scaleFactor,
                    y0 = h.bar_field.quartiles2[j],
                    y1 = h.bar_field.quartiles2[j],
                    gp = gpar(col="darkgray", lwd = 0.75, alpha = 2/5)
      )
    }
    
    ### Update field pointers
    x.bar.field.pointer <- x.bar.field.pointer + w.bar_field #df.type$Freq[i]/w.bar_field.scaleFactor
    x.xLabels.field.pointer <- x.xLabels.field.pointer + df.type$Freq[i]/w.bar_field.scaleFactor
  }
  
  ## Title at the upper-left corner of the innerFrame
  #seekViewport("vp.innerFrame")
  seekViewport(vp.innerFrame) # 2019-11-05
  grid.text(
    label = title.innerFrame.upperLeft,
    just = c("left","top"),
    x = 0.01,
    y = 0.95,
    gp = gpar(fontsize = title.innerFrame.upperLeft.fontsize,
              fontface = "bold")
  )
  
  ## Back to the initial viewport
  if (newpage != TRUE) { eval(backToTheInitialVp) }
  
  ## LEGACY CODE
  #
  # ggplot(data = df) +
  #   geom_bar(aes(x=type_subtype,y=count,fill=type), stat="identity", width = 0.5) +
  #   scale_fill_manual(values = df$color %>% unique) +
  #   theme_bw() +
  #   theme(panel.grid.minor = element_blank(),
  #         panel.grid.major = element_blank(),
  #         legend.position = "none",
  #         axis.title.y = element_blank(),
  #         axis.title.x = element_blank(),
  #         axis.ticks.x = element_blank(),
  #         axis.ticks.length=unit(-0.25, "cm")) +
  #   geom_hline(yintercept=c(0,1/4,1/2,3/4,1), color = "grey", size = 0.5, alpha = 0.5) +
  #   scale_y_continuous(expand = c(0, 0),limits = c(0,1))
  # barplot(height = df$count, col = df$color)
  
  # Useful resources:
  # 1. Guangchuang Yu, Convert plot to grob and ggplot object. https://cran.r-project.org/web/packages/ggplotify/vignettes/ggplotify.html. (2019).
  
}

## HELPER FUNCTION: plotSNV_pub: 2020-3-4
## INPUT:  df, ...
## OUTPUT: a plot
## NOTE: modified from plotMutationalSpectrum2()
plotSNV_pub <- function(df = NULL, y.max = NULL, bar.width = 0.5,
                        type.name = "type", subtype.name = "subtype", value.name = "count",
                        color.palette = "COSMIC.SNV", newpage = TRUE,
                        upperLabels.y = 0.05, upperLabels.height = 0.25,
                        upperLabels.text.y = 0.35, upperLabels.text.fontsize = 12,
                        xLabels.text.y = 0.5, xLabels.text.fontsize = 10,
                        yLabels.text.x = 0.9, yLabels.text.fontsize = 10,
                        yLabels.text.decimals = 1, yLabels.text.suffix = "",
                        yLabels.scaleBy = 1,
                        title.innerFrame.upperLeft = "", title.innerFrame.upperLeft.fontsize = 20,
                        bar.edge.color = NA, background.alpha = 0.1,
                        left.margin = 0.05, right.margin = 0.05){

    # Packages
  suppressMessages(library(grid))
  suppressMessages(library(magrittr))
  suppressMessages(library(data.table))
  # Color palette
  ## Presets
  palette.COSMIC.SNV.96 <- paste0("#",c(`C>A`="1EBFF0",`C>G`="050708",`C>T`="E62725",`T>A`="CBCACB",`T>C`="A1CF64",`T>G`="EDC8C5"))
  palette.COSMIC.SNV.192 <- paste0("#",c(`A>C`="B6CCFF",`A>G`="B3853C",`A>T`="808080",`G>A`="0000FF",`G>C`="000000",`G>T`="FFD000",
                                         `C>A`="1EBFF0",`C>G`="050708",`C>T`="E62725",`T>A`="CBCACB",`T>C`="A1CF64",`T>G`="EDC8C5"))
  if (is.null(color.palette)) {
    stop("Please provide input for 'color.palette' (currently, 'COSMIC.SNV', 'COSMIC.SNV.192', 'COSMIC.DBS' are available)")
  } else if (color.palette == "COSMIC.SNV") {
    color.palette <- palette.COSMIC.SNV.96
  } else if (color.palette == "COSMIC.SNV.192") {
    color.palette <- palette.COSMIC.SNV.192
  } else {
    stop("Invalid input for 'color.palette'")
  }
  
  # Reformatting input df
  df <- df %>% as.data.frame
  df <- df[, c(type.name, subtype.name, value.name)]
  df[["type_subtype"]] <- paste0(df$type,":",df$subtype)
  setnames(df, old=value.name, "count")
  
  # Plot
  if (newpage == TRUE){grid.newpage()} else {
    initial.vp <- current.viewport()
    if (initial.vp$name == "ROOT") {
      backToTheInitialVp <- parse(text="upViewport(0)")
    } else {
      backToTheInitialVp <- parse(text="seekViewport(initial.vp$name)")
    }
  } # 2019-11-05
  # Outer frame
  x.outer <- 0; y.outer <- 0; w.outer <- 1; h.outer <- 1
  pushViewport(viewport(x = x.outer, y = y.outer, width = w.outer, height = h.outer, just = c("left","bottom"))) # level 1 # 2019-11-05
  vp.outerFrame <- current.viewport()$name # 2019-11-05

  # Inner frame
  x.inner <- left.margin; y.inner <- 0.1; w.inner <- 1-left.margin-right.margin; h.inner <- 0.7
  pushViewport(viewport(x = x.inner, y = y.inner, width = w.inner, height = h.inner, just = c("left","bottom"))) # 2019-11-05
  vp.innerFrame <- current.viewport()$name # 2019-11-05
  grid.rect(name = "rect.innerFrame", gp = gpar(col="gray",lwd=1))
  
  # Y-axis labels
  x.y_axis <- 0; y.y_axis <- 0; w.y_axis <- x.inner; h.y_axis <- 1
  upViewport()
  pushViewport(viewport(x = x.y_axis, y = y.y_axis, width = w.y_axis, height = h.y_axis, just = c("left","bottom"))) # 2019-11-05
  vp.y_axis <- current.viewport()$name # 2019-11-05

  # X-axis labels
  x.x_axis <- x.inner; y.x_axis <- 0; w.x_axis <- w.inner; h.x_axis <- y.inner
  upViewport()
  pushViewport(viewport(x = x.x_axis, y = y.x_axis, width = w.x_axis, height = h.x_axis, just = c("left","bottom"))) # 2019-11-05
  vp.x_axis <- current.viewport()$name # 2019-11-05

  # Inner drawings (loop)
  ## Some initial workups
  # 2020-1-7, ISSUE => table() rearranges the order of df$type, which is not desired and the original order should be kept.
  df$type <- factor(df$type, levels=unique(df$type), ordered=TRUE) # 2020-1-7, this resolves the issue
  df.type <- df$type %>% table %>% as.data.frame
  
  w.bar_field.scaleFactor <- sum(df.type$Freq)
  ### h.bar.scaleFactor
  if (is.null(y.max)) {
    y.max <- max(df[["count"]]) * 1/(3/4 + 1/4*1/10)
  }
  h.bar.scaleFactor <- 1/y.max # h.bar.scaleFactor scales each bar height into the [0,1] scale.
  df.count.pointer <- 1
  df.subtype.pointer <- 1
  x.bar.field.pointer <- x.inner
  x.xLabels.field.pointer <- 0
  
  ## Sanity checks
  if (bar.width > 1 | bar.width < 0) { stop("Wrong range input for bar.width") }
  if (is.null(color.palette)) { stop("Input for 'color.palette' is missing") }
  
  ## Drawing bars
  ### Bar field
  for (i in 1:nrow(df.type)) {
    seekViewport(vp.outerFrame) # 2019-11-05
    x.bar_field <- x.bar.field.pointer
    w.bar_field <- df.type$Freq[i]/w.bar_field.scaleFactor*w.inner
    y.bar_field <- y.inner
    h.bar_field <- h.inner
    pushViewport(viewport(x = x.bar_field, y = y.bar_field, width = w.bar_field, height = h.bar_field, just = c("left","bottom"))) # 2019-11-05
    vp.barField.name <- paste0("vp.barField.",df.type$.[i]) # 2019-11-05
    assign(vp.barField.name,current.viewport()$name) # 2019-11-05
    grid.rect(name = paste0(vp.barField.name,".rect.barField.",df.type$.[i]),
              gp=gpar(col=NA,#color.palette[i],
                      fill=color.palette[i],
                      alpha=background.alpha))
    ### Bar drawings
    #### Now in vp.barField
    x.bar.pointer <- 1/2*1/df.type$Freq[i] - 1/2*bar.width/df.type$Freq[i]
    for (j in 1:df.type$Freq[i]) {
      grid.rect(name = paste0(vp.barField.name,".rect.bar.",df$type_subtype[df.count.pointer]),
                just = c("left","bottom"),
                x = x.bar.pointer,
                y = 0,
                width = bar.width/df.type$Freq[i],
                height = df[["count"]][df.count.pointer] * h.bar.scaleFactor,
                gp=gpar(fill=color.palette[i],
                        col=bar.edge.color))
      df.count.pointer <- df.count.pointer + 1
      # Do not let x.bar.pointer be updated in the last loop
      if (j != df.type$Freq[i]) {
        x.bar.pointer <- x.bar.pointer + 1/df.type$Freq[i]
      }
    }
    ### X labels
    seekViewport(vp.x_axis) # 2019-11-05
    x.xLabels.pointer <- 1/2*1/df.type$Freq[i]
    for (j in 1:df.type$Freq[i]){
      grid.text(label = df$subtype[df.subtype.pointer],
                name = paste0(vp.x_axis,".text.xLabel.",df$subtype[df.subtype.pointer]), # 2019-11-05
                just = c("center","center"),
                x = x.xLabels.field.pointer + x.xLabels.pointer*df.type$Freq[i]/w.bar_field.scaleFactor,
                y = xLabels.text.y,
                rot = 90,
                gp = gpar(fontsize = xLabels.text.fontsize, fontfamily = "mono") # fontframily = "mono" is Courier
      )
      df.subtype.pointer <- df.subtype.pointer + 1
      x.xLabels.pointer <- x.xLabels.pointer + 1/df.type$Freq[i]
    }
    ### Upper labels
    seekViewport(vp.outerFrame) # 2019-11-05
    if (upperLabels.y < 0 | upperLabels.y > 1) {stop("Invalid range for 'upperLabels.y'.")}
    if (upperLabels.height < 0 | upperLabels.height > 1) {stop("Invalid range for 'upperLabels.height'.")}
    
    x.upperLabels <- x.bar.field.pointer + w.bar_field*(1/2*1/df.type$Freq[i] - 1/2*bar.width/df.type$Freq[i])
    w.upperLabels <- w.bar_field*(x.bar.pointer + 1/2*bar.width/df.type$Freq[i])
    y.upperLabels <- y.inner + h.inner + (1 - (y.inner + h.inner))*upperLabels.y
    grid.rect(name = paste0(vp.outerFrame,".rect.upperLabel.",df.type$.[i]),
              just = c("left","bottom"),
              x = x.upperLabels,
              y = y.upperLabels,
              width = w.upperLabels,
              height = upperLabels.height*(1 - (y.inner + h.inner)),
              gp = gpar(fill=color.palette[i],col=NA)
    )
    ### Upper texts
    y.upperLabels.text <- y.inner + h.inner + (1 - (y.inner + h.inner))*upperLabels.text.y
    grid.text(name = paste0(vp.outerFrame,".text.upperLabel.",df.type$.[i]),
              label = df.type$.[i],
              just = c("center","bottom"),
              x = x.upperLabels + 0.5*w.upperLabels,
              y = y.upperLabels.text,
              gp = gpar(fontsize = upperLabels.text.fontsize)
    )
    
    ### Update field pointers
    x.bar.field.pointer <- x.bar.field.pointer + w.bar_field #df.type$Freq[i]/w.bar_field.scaleFactor
    x.xLabels.field.pointer <- x.xLabels.field.pointer + df.type$Freq[i]/w.bar_field.scaleFactor
  }
  
  ### Y labels
  seekViewport(vp.y_axis) # 2019-11-05
  x.yLabels <- yLabels.text.x
  y.yLabels <- y.inner
  labels.yLabels <- seq(0,y.max,length.out = 5)
  h.bar_field.quartiles <- seq(0,h.inner,length.out = 5) # w.r.s.t. vp.y_axis
  for (j in 1:5){
    vp.y_axis
    grid.text(name = paste0(vp.y_axis,".text.yLabels.",j),
              #label = paste0(round(labels.yLabels[j],yLabels.text.decimals),yLabels.text.suffix),
              label = paste0(round(labels.yLabels[j] * yLabels.scaleBy,yLabels.text.decimals),yLabels.text.suffix), # 2020-3-6
              just = c("right","center"),
              x = x.yLabels,
              y = y.inner + h.bar_field.quartiles[j],
              gp = gpar(fontsize = yLabels.text.fontsize, fontfamily = "mono")
    )
  }
  ### Y inward ticks and horizontal lines
  seekViewport(vp.innerFrame) # 2019-11-05
  h.bar_field.quartiles2 <- seq(0,1,length.out = 5) # w.r.s.t. vp.innerFrame
  for (j in 2:4){
    #### orizontal lines
    grid.segments(x0 = 0,
                  x1 = 1,
                  y0 = h.bar_field.quartiles2[j],
                  y1 = h.bar_field.quartiles2[j],
                  gp = gpar(col="gray", lwd = 0.75, alpha = 1/5)
    )
    #### 3 inward ticks
    grid.segments(x0 = 0,
                  x1 = 1/w.bar_field.scaleFactor,
                  y0 = h.bar_field.quartiles2[j],
                  y1 = h.bar_field.quartiles2[j],
                  gp = gpar(col="darkgray", lwd = 0.75, alpha = 2/5)
    )
  }
  
  ## Title at the upper-left corner of the innerFrame
  seekViewport(vp.innerFrame) # 2019-11-05
  grid.text(
    label = title.innerFrame.upperLeft,
    just = c("left","top"),
    x = 0.01,
    y = 0.95,
    gp = gpar(fontsize = title.innerFrame.upperLeft.fontsize,
              fontface = "bold")
  )
  
  ## Back to the initial viewport
  if (newpage != TRUE) { eval(backToTheInitialVp) }
  
  # Useful resources:
  # 1. Guangchuang Yu, Convert plot to grob and ggplot object. https://cran.r-project.org/web/packages/ggplotify/vignettes/ggplotify.html. (2019).
  
}

## HELPER FUNCTION: plotINDEL_pub: 2020-3-4
## INPUT: a data frame, ...
## OUTPUT: a plot
## DEPENDENCY: plotMutationalSpectrum2
## NOTE: A wrapper function for plotting multiple INDEL plots
plotINDEL_pub <- function(df = NULL, y.max = NULL, bar.width = 0.5,
                          type.name = "type", subtype.name = "subtype", value.name = "count", newpage = TRUE,
                          upperLabels.text.fontsize = 12,
                          upperLabels2.text.fontsize = 12,
                          xLabels.text.y = 0.5, xLabels.text.fontsize = 10, xLabels2.text.fontsize = 10,
                          yLabels.text.x = 0.9, yLabels.text.fontsize = 10,
                          yLabels.text.decimals = 1, yLabels.text.suffix = " %",
                          yLabels.scaleBy = 100,
                          title.innerFrame.upperLeft = "", title.innerFrame.upperLeft.fontsize = 20,
                          bar.edge.color = NA, background.alpha = 0.1,
                          top.margin = 0.15, bottom.margin = 0.1,
                          left.margin = 0.05, right.margin = 0.05
                          
                          ){
  
  # Packages
  suppressMessages(library(grid))
  suppressMessages(library(magrittr))
  suppressMessages(library(data.table))
  # Color palette
  ## Presets
  palette.COSMIC.INDEL <- paste0("#",c(`D1_C`="FCBF6F",
                                       `D1_T`="FD8103",
                                       `I1_C`="B2DB8D",
                                       `I1_T`="36A034",
                                       `D2_2`="FEC9B7",
                                       `D2_3`="FE886A",
                                       `D2_4`="F34433",
                                       `D2_5+`="BD181C",
                                       `I2_2`="D0E1F3",
                                       `I2_3`="96C4DE",
                                       `I2_4`="4798CD",
                                       `I2_5+`="1764AA",
                                       `MH_2`="DCE2F2",
                                       `MH_3`="B6B6D8",
                                       `MH_4`="8584BE",
                                       `MH_5+`="63409C")) # 2019-01-07
  color.palette <- palette.COSMIC.INDEL
  
  upper.lables <- list(`D1`=c("C","T"),
                       `I1`=c("C","T"),
                       `D2`=c("2","3","4","5+"),
                       `I2`=c("2","3","4","5+"),
                       `MH`=c("2","3","4","5+"))
  upper.lable_colors <- list(`D1`=c("black","white"),
                             `I1`=c("black","white"),
                             `D2`=c("black","black","black","white"),
                             `I2`=c("black","black","black","white"),
                             `MH`=c("black","black","black","white"))
  upper2.labels <- list(`D1`="1bp deletion",
                        `I1`="1bp insertion",
                        `D2`=c(">1bp deletions at repeats","(Deletion length)"),
                        `I2`=c(">1bp insertions at repeats","(Insertion length)"),
                        `MH`=c("Deletions with microhomology","(Deletion length)"))
  xLabels2.labels <- c(`D1`="Homopolymer length",
                       `I1`="Homopolymer length",
                       `D2`="Number of repeat units",
                       `I2`="Number of repeat units",
                       `MH`="Microhomology length")
  
  # Reformatting input df
  # df <- INDEL.sig.df; value.name <- "Signature_A"
  df <- df %>% as.data.frame
  df <- df[, c(type.name, subtype.name, value.name)]
  df[["type_subtype"]] <- paste0(df$type,":",df$subtype)
  df[["new_type"]] <- df$type %>% gsub("(.*)_.*","\\1",.) %>% toupper()
  df[["new_subtype"]] <- df$type %>% gsub(".*_(.*)","\\1",.) %>% toupper()
  df[["new_subsubtype"]] <- df$subtype
  setnames(df, old=value.name, "count")
  
  ## To remember current viewport
  if (newpage == TRUE){grid.newpage()} else {
    initial.vp <- current.viewport()
    if (initial.vp$name == "ROOT") {
      backToTheInitialVp <- parse(text="upViewport(0)")
    } else {
      backToTheInitialVp <- parse(text="seekViewport(initial.vp$name)")
    }
  } # 2019-11-05
  
  ## COORDINATES ###############################################################
  # Outer frame
  x.outer <- 0; y.outer <- 0; w.outer <- 1; h.outer <- 1
  # Inner frame
  x.inner <- left.margin; w.inner <- 1 - left.margin - right.margin
  y.inner <- bottom.margin; h.inner <- 1 - bottom.margin - top.margin
  #if (xLabels2_ON) {y.inner <- 0.2} else {y.inner <- 0.1}
  #if (upperLabels2_ON) {h.inner <- 1 - y.inner - 0.2} else {h.inner <- 1 - y.inner - 0.1}
  # Y-axis
  x.y_axis <- 0; y.y_axis <- 0; w.y_axis <- x.inner; h.y_axis <- 1
  # X-axis 1
  x.x_axis <- x.inner; y.x_axis <- y.inner * 0.5
  w.x_axis <- w.inner; h.x_axis <- y.inner * 0.5
  # X-axis 2
  x.x_axis2 <- x.inner; y.x_axis2 <- 0
  w.x_axis2 <- w.inner; h.x_axis2 <- y.x_axis
  # upper 1
  x.upper <- x.inner; y.upper <- y.inner + h.inner
  w.upper <- w.inner; h.upper <- (1 - y.upper) * (1/3) # 0.5
  # upper 2
  x.upper2 <- x.upper; w.upper2 <- w.upper
  y.upper2 <- y.upper + h.upper; h.upper2 <- (1 - y.upper) * (2/3)
  
  ## VIEWPORTS #################################################################
  # Outer frame
  vp.outerFrame <- viewport(x = x.outer, y = y.outer, width = w.outer, height = h.outer, just = c("left","bottom"))
  # Inner frame
  vp.innerFrame <- viewport(x = x.inner, y = y.inner, width = w.inner, height = h.inner, just = c("left","bottom"))
  # Y-axis
  vp.y_axis <- viewport(x = x.y_axis, y = y.y_axis, width = w.y_axis, height = h.y_axis, just = c("left","bottom"))
  # X-axis 1
  vp.x_axis <- viewport(x = x.x_axis, y = y.x_axis, width = w.x_axis, height = h.x_axis, just = c("left","bottom"))
  # X-axis 2
  vp.x_axis2 <- viewport(x = x.x_axis2, y = y.x_axis2, width = w.x_axis2, height = h.x_axis2, just = c("left","bottom"))
  # upper labels
  vp.upper <- viewport(x = x.upper, y = y.upper, width = w.upper, height = h.upper, just = c("left","bottom"))
  # upper labels 2
  vp.upper2 <- viewport(x = x.upper2, y = y.upper2, width = w.upper2, height = h.upper2, just = c("left","bottom"))
  
  ## CREATE VIEWPORTS ##########################################################
  pushViewport(vp.outerFrame)
  pushViewport(vp.innerFrame); upViewport()
  pushViewport(vp.y_axis); upViewport()
  pushViewport(vp.x_axis); upViewport()
  pushViewport(vp.x_axis2); upViewport()
  pushViewport(vp.upper); upViewport()
  pushViewport(vp.upper2); upViewport()
  
  ##############################################################################
  
  # GUIDELINES
  # grid.rect(gp = gpar(col="gray",lwd=1), vp = vp.innerFrame$name)
  # grid.rect(gp = gpar(col="gray",fill="dark grey",lwd=1), vp = vp.y_axis$name)
  # grid.rect(gp = gpar(col="gray",fill="grey",lwd=1), vp = vp.x_axis$name)
  # grid.rect(gp = gpar(col="gray",fill="light grey",lwd=1), vp = vp.x_axis2$name)
  # grid.rect(gp = gpar(col="gray",fill="grey",lwd=1), vp = vp.upper$name)
  # grid.rect(gp = gpar(col="gray",fill="light grey",lwd=1), vp = vp.upper2$name)
  
  # FRAMES
  grid.rect(name = "rect.innerFrame", gp = gpar(col="gray",lwd=1), vp = vp.innerFrame$name)
  
  ## INNER DRAWINGS ############################################################
  draw_drawings <- function() {
    ## Some initial workups
    # 2020-1-7, ISSUE => table() rearranges the order of df$type, which is not desired and the original order should be kept.
    df$type <- factor(df$type, levels=unique(df$type), ordered=TRUE) # 2020-1-7, this resolves the issue
    df.type <- df$type %>% table %>% as.data.frame
    
    df$new_type <- factor(df$new_type, levels=unique(df$new_type), ordered=TRUE) # 2020-1-7, this resolves the issue
    df.new_type <- df$new_type %>% table %>% as.data.frame
    
    # scale factors
    w.bar_field.scaleFactor <- sum(df.type$Freq)
    if (is.null(y.max)) {
      y.max <- max(df[["count"]]) * 1/(3/4 + 1/4 * 1/10)
    }
    h.bar.scaleFactor <- 1/y.max # h.bar.scaleFactor scales each bar height into the [0,1] scale.
    
    ## Sanity checks
    if (bar.width > 1 | bar.width < 0) { stop("Wrong range input for bar.width") }
    if (is.null(color.palette)) { stop("Input for 'color.palette' is missing") }
    
    ## DRAWING
    ### 1. BAR FIELDS
    # Set pointers
    x.bar.field.pointer <- 0 # <- x.inner # bar field pointer is local (w.r.s.t innerFrame)
    df.count.pointer <- 1
    for (i in 1:nrow(df.type)) {
      
      x.bar_field <- x.bar.field.pointer
      y.bar_field <- 0
      w.bar_field <- (df.type$Freq[i] / w.bar_field.scaleFactor) # * w.inner
      h.bar_field <- 1
      
      grid.rect(vp=vp.innerFrame,
                x=x.bar_field, y=y.bar_field, width=w.bar_field, height=h.bar_field, just=c("left","bottom"),
                gp=gpar(col=NA, fill=color.palette[i], alpha=background.alpha))
      
      ### Update field pointers
      x.bar.field.pointer <- x.bar.field.pointer + w.bar_field
      
    }
    
    ### 2. BARS
    # Reset the pointers
    x.bar.field.pointer <- 0 
    df.count.pointer <- 1
    seekViewport(vp.innerFrame$name)
    for (i in 1:nrow(df.type)) {
      
      x.bar_field <- x.bar.field.pointer
      y.bar_field <- 0
      w.bar_field <- (df.type$Freq[i] / w.bar_field.scaleFactor) # * w.inner
      h.bar_field <- 1
      
      x.bar.pointer <- 1/2 * 1/df.type$Freq[i] - 1/2 * bar.width/df.type$Freq[i]
      
      tmp.vp <-viewport(x=x.bar_field, y=y.bar_field, width=w.bar_field, height=h.bar_field, just=c("left","bottom"))
      pushViewport(tmp.vp)
      for (j in 1:df.type$Freq[i]) {
        grid.rect(x = x.bar.pointer, y = 0, width = bar.width/df.type$Freq[i], height = df[["count"]][df.count.pointer] * h.bar.scaleFactor, just = c("left","bottom"),
                  gp=gpar(fill=color.palette[i], col=bar.edge.color))
        df.count.pointer <- df.count.pointer + 1
        # Do not let x.bar.pointer be updated in the last loop
        if (j != df.type$Freq[i]) {
          x.bar.pointer <- x.bar.pointer + 1/df.type$Freq[i]
        }
      }
      popViewport()
      
      # Increment pointer
      x.bar.field.pointer <- x.bar.field.pointer + w.bar_field
    }
    
    ### 3. X-AXIS 1
    # Reset the pointers
    x.bar.field.pointer <- 0
    df.subtype.pointer <- 1
    seekViewport(vp.x_axis$name)
    for (i in 1:nrow(df.type)) {
      
      x.bar_field <- x.bar.field.pointer
      y.bar_field <- 0
      w.bar_field <- (df.type$Freq[i] / w.bar_field.scaleFactor) # * w.inner
      h.bar_field <- 1
      
      x.xLabels.pointer <- 1/2 * 1/df.type$Freq[i]
      
      tmp.vp <-viewport(x=x.bar_field, y=y.bar_field, width=w.bar_field, height=h.bar_field, just=c("left","bottom"))
      pushViewport(tmp.vp)
      for (j in 1:df.type$Freq[i]){
        grid.text(label = df$subtype[df.subtype.pointer],
                  just = c("center","center"),
                  x = x.xLabels.pointer,
                  y = xLabels.text.y,
                  gp = gpar(fontsize = xLabels.text.fontsize, fontfamily = "mono") # fontframily = "mono" is Courier
        )
        df.subtype.pointer <- df.subtype.pointer + 1
        x.xLabels.pointer <- x.xLabels.pointer + 1/df.type$Freq[i]
      }
      popViewport()
      
      # Increment pointer
      x.bar.field.pointer <- x.bar.field.pointer + w.bar_field
    }
    
    ### 4. UPPER 1
    df.subtype <- upper.lables %>% unlist(use.names = FALSE)
    # Reset the pointers
    x.bar.field.pointer <- 0
    df.subtype.pointer <- 1
    seekViewport(vp.upper$name)
    for (i in 1:nrow(df.type)) {
      
      x.bar_field <- x.bar.field.pointer
      y.bar_field <- 0
      w.bar_field <- (df.type$Freq[i] / w.bar_field.scaleFactor) # * w.inner
      h.bar_field <- 1
      
      x.bar_start <- 1/2 * 1/df.type$Freq[i] - 1/2 * bar.width/df.type$Freq[i]
      x.bar_end <- x.bar_start + (df.type$Freq[i] - 1) / df.type$Freq[i] + bar.width/df.type$Freq[i]
      
      tmp.vp <-viewport(x=x.bar_field, y=y.bar_field, width=w.bar_field, height=h.bar_field, just=c("left","bottom"))
      # solid
      grid.rect(vp=tmp.vp,
                x=x.bar_start, y=0.1, width=x.bar_end - x.bar_start, height=0.8, just=c("left","bottom"),
                gp=gpar(fill=color.palette[i], col=bar.edge.color))
      # text
      grid.text(label=df.subtype[i], vp=tmp.vp,
                x=0.5, y=0.5, just=c("center","center"),
                gp=gpar(col=upper.lable_colors %>% unlist %>% .[[i]],
                        fontsize=upperLabels.text.fontsize))#, font=2)) # font=2 := bold

      # Increment pointer
      x.bar.field.pointer <- x.bar.field.pointer + w.bar_field
      
    }
    
    ### 5. X-LABEL 2
    # Reset the pointers
    x.type.field.pointer <- 0
    seekViewport(vp.x_axis2$name)
    for (i in 1:length(xLabels2.labels)) {
      
      x.type_field <- x.type.field.pointer
      y.type_field <- 0
      w.type_field <- (df.new_type$Freq[i] / sum(df.new_type$Freq))
      h.type_field <- 1
      
      tmp.vp <-viewport(x=x.type_field, y=y.type_field, width=w.type_field, height=h.type_field, just=c("left","bottom"))
      grid.text(label = xLabels2.labels[[i]], vp = tmp.vp,
                x=0.5, y=0.5, just=c("center","center"),
                gp=gpar(fontsize=xLabels2.text.fontsize))
      # Increment pointer
      x.type.field.pointer <- x.type.field.pointer + w.type_field
    }
    
    ### 6. UPPER 2
    # Reset the pointers
    x.type.field.pointer <- 0
    seekViewport(vp.upper2$name)
    for (i in 1:length(xLabels2.labels)) {
      
      x.type_field <- x.type.field.pointer
      y.type_field <- 0
      w.type_field <- (df.new_type$Freq[i] / sum(df.new_type$Freq))
      h.type_field <- 1
      
      tmp.vp <-viewport(x=x.type_field, y=y.type_field, width=w.type_field, height=h.type_field, just=c("left","bottom"))
      grid.text(label = upper2.labels[[i]] %>% paste0(collapse="\n"), vp = tmp.vp,
                x=0.5, y=0.5, just=c("center","center"),
                gp=gpar(fontsize=upperLabels2.text.fontsize))
      # Increment pointer
      x.type.field.pointer <- x.type.field.pointer + w.type_field
    }
    
    ### 7. Y labels
    seekViewport(vp.y_axis$name)
    x.yLabels <- yLabels.text.x
    y.yLabels <- y.inner
    labels.yLabels <- seq(0,y.max,length.out = 5)
    h.bar_field.quartiles <- seq(0,h.inner,length.out = 5) # w.r.s.t. vp.y_axis
    for (j in 1:5){
      vp.y_axis
      grid.text(#name = paste0(vp.y_axis,".text.yLabels.",j),
        label = paste0(round(labels.yLabels[j] * yLabels.scaleBy, yLabels.text.decimals),yLabels.text.suffix),
        just = c("right","center"),
        x = x.yLabels,
        y = y.inner + h.bar_field.quartiles[j],
        gp = gpar(fontsize = yLabels.text.fontsize, fontfamily = "mono")
      )
    }
    
    ### 8. Y inward ticks and horizontal lines
    seekViewport(vp.innerFrame$name)
    h.bar_field.quartiles2 <- seq(0,1,length.out = 5) # w.r.s.t. vp.innerFrame
    for (j in 2:4){
      #### Horizontal lines
      grid.segments(x0 = 0,
                    x1 = 1,
                    y0 = h.bar_field.quartiles2[j],
                    y1 = h.bar_field.quartiles2[j],
                    gp = gpar(col="gray", lwd = 0.75, alpha = 1/5)
      )
      #### 3 inward ticks
      grid.segments(x0 = 0,
                    x1 = 1/w.bar_field.scaleFactor,
                    y0 = h.bar_field.quartiles2[j],
                    y1 = h.bar_field.quartiles2[j],
                    gp = gpar(col="darkgray", lwd = 0.75, alpha = 2/5)
      )
    }
    
    ### 9. Title at the upper-left corner of the innerFrame
    seekViewport(vp.innerFrame$name)
    grid.text(
      label = title.innerFrame.upperLeft,
      just = c("left","top"),
      x = 0.01,
      y = 0.95,
      gp = gpar(fontsize = title.innerFrame.upperLeft.fontsize,
                fontface = "bold")
    )
    
  }
  draw_drawings()
  
  ## Back to the initial viewport
  if (newpage != TRUE) { eval(backToTheInitialVp) }

  # Useful resources:
  # 1. Guangchuang Yu, Convert plot to grob and ggplot object. https://cran.r-project.org/web/packages/ggplotify/vignettes/ggplotify.html. (2019).
  
}

#### HELPER FUNCTION: plotExposures_pub: 2020-3-6
#### INPUT: a data frame (New_ID, Signature_A, ..., dose, total_count)
#### OUTPUT: a plot
#### NOTE: variable names are fixed
plotExposures_pub <- function(df = NULL, newpage = TRUE,
                              left.margin = 0.1, right.margin = 0.2,
                              top.margin = 0.5, bottom.margin = 0.05,
                              color.palette.exposures = NULL, # the number of colors should be no less than the number of signatures
                              color.palette.doses = NULL, # the number of colors should be no less than the number of dose cases
                              upper1_upper2_ratio = c(3,1),
                              upper1.y_axis.lim = NULL,
                              upper2.text.fontsize = 9,
                              upper2.bar.thinkness = 0.1,
                              y_axis.title.top = "Total INDELs",
                              y_axis.title.bottom = "Proportion (%)",
                              y_axis.labels.offset = 0.1,
                              y_axis.top_label.offset = 0.5,
                              y_axis.bottom_label.offset = 0.5,
                              yLabels.text.fontsize = 10,
                              yLabels.label.text.fontsize = 10,
                              x.field_gap = 0.01,
                              y.field_gap = 0.01,
                              legend.vgap = 0.2,
                              legend.fontsize = 10,
                              op.signature_to_sort_by_and_overlay = "Signature_D"
                              ){
  
  suppressMessages(library("RColorBrewer"))
  # TEST
  #df <- INDEL.exposure_table.df

  # SORT
  if (!is.null(op.signature_to_sort_by_and_overlay)){
    column.abs_count <- paste0(op.signature_to_sort_by_and_overlay,".abs_count")
    df[[column.abs_count]] <- df[[op.signature_to_sort_by_and_overlay]] * df$total_count
    df <- df %>% arrange_at(c("dose", column.abs_count, "total_count"))  
  }
  
  
  # GET INFO
  sigNames <- df %>% names %>% .[!(. %in% c("New_ID","dose","total_count"))]
  #sigNames <- sigNames %>% grep("Signature_[[:alpha:]]+$",.,value=TRUE)
  sigNames <- sigNames[!(sigNames %>% grepl(".abs_count$",.))]
  
  doses <- df$dose %>% table %>% as.data.frame
  
  # PRESETS
  doseLables <- c(`0`="0 Gy",
                  `1`="1 Gy",
                  `2`="2 Gy",
                  `4`="4 Gy",
                  `8`="8 Gy",
                  `20`="20 Gy",
                  `50`="50 Gy")
  
  bar.width <- 1
  bar.edge.color <- NA
  bar.edge.size <- NULL

  # COLOR PALETTE
  if (is.null(color.palette.doses)) {
    palette.dose <- RColorBrewer::brewer.pal(n=9, name="BuPu")
  } else {
    palette.dose <- color.palette.doses
  }
  if (is.null(color.palette.exposures)) {
    palette.exposures <- RColorBrewer::brewer.pal(n = length(sigNames), name = "Set2") # Set1 has 9 colors; Set2 has 8 colors; Set3 has 12 colors  
  } else {
    palette.exposures <- color.palette.exposures
  }
  
  
  ## To remember current viewport
  if (newpage == TRUE){grid.newpage()} else {
    initial.vp <- current.viewport()
    if (initial.vp$name == "ROOT") {
      backToTheInitialVp <- parse(text="upViewport(0)")
    } else {
      backToTheInitialVp <- parse(text="seekViewport(initial.vp$name)")
    }
  }
  
  ## COORDINATES ###############################################################
  # Outer frame
  x.outer <- 0; y.outer <- 0; w.outer <- 1; h.outer <- 1
  # Inner frame
  x.inner <- left.margin; w.inner <- 1 - left.margin - right.margin
  y.inner <- bottom.margin; h.inner <- 1 - bottom.margin - top.margin
  # Y-axis
  x.y_axis <- 0; y.y_axis <- 0; w.y_axis <- x.inner; h.y_axis <- 1
  # Legend
  x.lgd_field <- x.inner + w.inner; y.lgd_field <- 0; w.lgd_field <- right.margin; h.lgd_field <- 1
  # upper 1
  x.upper <- x.inner; y.upper <- y.inner + h.inner + y.field_gap
  w.upper <- w.inner; h.upper <- (1 - y.upper) * upper1_upper2_ratio[1] / sum(upper1_upper2_ratio) # * 0.5 # (2/3)
  # upper 2
  x.upper2 <- x.upper; w.upper2 <- w.upper
  y.upper2 <- y.upper + h.upper + y.field_gap / 2; h.upper2 <- 1 - y.upper2 # (1 - y.upper) * 0.5 # (1/3)
  
  ## VIEWPORTS #################################################################
  # Outer frame
  vp.outerFrame <- viewport(x = x.outer, y = y.outer, width = w.outer, height = h.outer, just = c("left","bottom"))
  # Inner frame
  vp.innerFrame <- viewport(x = x.inner, y = y.inner, width = w.inner, height = h.inner, just = c("left","bottom"))
  # Y-axis
  vp.y_axis <- viewport(x = x.y_axis, y = y.y_axis, width = w.y_axis, height = h.y_axis, just = c("left","bottom"))
  # Legend
  vp.legend <- viewport(x = x.lgd_field, y = y.lgd_field, width = w.lgd_field, height = h.lgd_field, just = c("left","bottom"))
  # upper labels
  vp.upper <- viewport(x = x.upper, y = y.upper, width = w.upper, height = h.upper, just = c("left","bottom"))
  # upper labels 2
  vp.upper2 <- viewport(x = x.upper2, y = y.upper2, width = w.upper2, height = h.upper2, just = c("left","bottom"))
  
  ## CREATE VIEWPORTS ##########################################################
  pushViewport(vp.outerFrame)
  pushViewport(vp.innerFrame); upViewport()
  pushViewport(vp.y_axis); upViewport()
  pushViewport(vp.legend); upViewport()
  pushViewport(vp.upper); upViewport()
  pushViewport(vp.upper2); upViewport()
  
  ##############################################################################
  
  # GUIDELINES
  # grid.rect(gp = gpar(col="gray",lwd=1), vp = vp.innerFrame$name)
  # grid.rect(gp = gpar(col="gray",fill="dark grey",lwd=1), vp = vp.y_axis$name)
  # grid.rect(gp = gpar(col="gray",fill="light grey",lwd=1), vp = vp.legend$name)
  # grid.rect(gp = gpar(col="gray",fill="grey",lwd=1), vp = vp.upper$name)
  # grid.rect(gp = gpar(col="gray",fill="light grey",lwd=1), vp = vp.upper2$name)
  
  ## DRAWINGS ##################################################################
  
  draw_drawings <- function(){
    # Some initial workups
    df$dose <- factor(df$dose, levels=unique(df$dose), ordered=TRUE)
    df.dose <- df$dose %>% table %>% as.data.frame
    
    # some rulers
    x.field.step <- (1 - x.field_gap * (nrow(df.dose) - 1)) / sum(df.dose$Freq) # w.r.s.t. innerFrame
    x.field.length.df <- df.dose$Freq * x.field.step
    # w.bar_field.step_N <- 1 - x.field_gap * nrow(df.dose) sum(df.dose$Freq) + nrow(df.dose) - 1
    if (is.null(upper1.y_axis.lim)){
      y.max.scaleFactor <- 1/max(df$total_count)
    } else {
      y.max.scaleFactor <- 1/upper1.y_axis.lim
    }
    
    # field gaps
    # y.field_gap <- 0.01
    # x.field_gap <- 1/(w.bar_field.step_N)
    
    # DRAWING
    ### 1. BARS
    # Reset the pointers
    x.bar.field.pointer <- 0
    df.pointer <- 1
    seekViewport(vp.innerFrame$name)
    # grid.rect()
    for (i in 1:nrow(df.dose)) {
      
      x.bar_field <- x.bar.field.pointer
      y.bar_field <- 0
      w.bar_field <- x.field.length.df[i]
      h.bar_field <- 1
      
      x.bar.pointer <- 0
      y.bar.pointer <- 0
      
      tmp.vp <-viewport(x=x.bar_field, y=y.bar_field, width=w.bar_field, height=h.bar_field, just=c("left","bottom"))
      pushViewport(tmp.vp)
      for (j in 1:df.dose$Freq[i]) {
        for (k in 1:length(sigNames)){
          grid.rect(x = x.bar.pointer, y = y.bar.pointer, width = 1/df.dose$Freq[i], height = df[df.pointer,][[sigNames[k]]], just = c("left","bottom"),
                    gp=gpar(fill=palette.exposures[k], col=bar.edge.color))
          y.bar.pointer <- y.bar.pointer + df[df.pointer,][[sigNames[k]]]
        }
        y.bar.pointer <- 0
        df.pointer <- df.pointer + 1
        x.bar.pointer <- x.bar.pointer + 1/df.dose$Freq[i]
      }
      popViewport()
      
      # Increment pointer
      x.bar.field.pointer <- x.bar.field.pointer + w.bar_field + x.field_gap
    }
    
    ### 2. UPPER 1
    # Reset the pointers
    x.bar.field.pointer <- 0
    y.bar.field.pointer <- vp.upper$y[[1]]
    df.pointer <- 1
    seekViewport(vp.upper$name)
    #grid.rect()
    for (i in 1:nrow(df.dose)) {
      
      x.bar_field <- x.bar.field.pointer
      y.bar_field <- 0
      w.bar_field <- x.field.length.df[i]
      h.bar_field <- 1
      
      x.bar.pointer <- 0

      tmp.vp <-viewport(x=x.bar_field, y=y.bar_field, width=w.bar_field, height=h.bar_field, just=c("left","bottom"))
      pushViewport(tmp.vp)
      for (j in 1:df.dose$Freq[i]) {
        # Total count
        grid.rect(x = x.bar.pointer, y = 0, width = 1/df.dose$Freq[i], height = df[df.pointer,"total_count"] * y.max.scaleFactor, just = c("left","bottom"),
                  gp=gpar(fill="grey30", col=bar.edge.color))
        
        # Overlaying count by signature X
        if (!is.null(op.signature_to_sort_by_and_overlay)) {
          grid.rect(x = x.bar.pointer, y = 0, width = 1/df.dose$Freq[i], height = df[df.pointer,column.abs_count] * y.max.scaleFactor, just = c("left","bottom"),
                    gp=gpar(fill=palette.exposures[4], col=bar.edge.color))  
        }
        
        df.pointer <- df.pointer + 1
        x.bar.pointer <- x.bar.pointer + 1/df.dose$Freq[i]
      }
      popViewport()
      
      # Increment pointer
      x.bar.field.pointer <- x.bar.field.pointer + w.bar_field + x.field_gap
    }
    
    
    ### 3. UPPER 2
    # Reset the pointers
    x.bar.field.pointer <- 0
    y.bar.field.pointer <- vp.upper2$y[[1]]
    seekViewport(vp.upper2$name)
    # grid.rect()
    for (i in 1:nrow(df.dose)) {
      
      x.bar_field <- x.bar.field.pointer
      y.bar_field <- 0
      w.bar_field <- x.field.length.df[i]
      h.bar_field <- 1
      
      tmp.vp <- viewport(x=x.bar_field, y=y.bar_field, width=w.bar_field, height=h.bar_field, just=c("left","bottom"))
      # Horizontal bar
      grid.rect(vp = tmp.vp, x = 0, y = 0, width = 1, height = upper2.bar.thinkness, just=c("left","bottom"),
                gp=gpar(fill=palette.dose[i], col=bar.edge.color))
      # Dose labels
      grid.text(vp = tmp.vp,
                label = doseLables[[df.dose$.[i]]],
                x=0.5, y=0.5, just=c("center","center"),
                gp=gpar(fontsize=upper2.text.fontsize))
      
      # Increment pointer
      x.bar.field.pointer <- x.bar.field.pointer + w.bar_field + x.field_gap
    }
    
    
    ### 4. Y axis ticks and labels
    seekViewport(vp.y_axis$name)
    #grid.rect()
    x.yLabels <- 1 - y_axis.labels.offset
    y.yLables_bottom.vec <- seq(y.inner, y.inner + h.inner, length.out=5)
    ##### Bottom one
    labels.yLabels <- seq(0, 100, length.out=5)
    for (i in 1:length(y.yLables_bottom.vec)) {
      # Ticks
      grid.segments(x0 = 0.95,
                    x1 = 1,
                    y0 = y.yLables_bottom.vec[i],
                    y1 = y.yLables_bottom.vec[i],
                    gp = gpar(col="black", lwd = 0.75))
      # Text
      grid.text(
        label = labels.yLabels[i],
        just = c("right","center"),
        x = x.yLabels,
        y = y.yLables_bottom.vec[i],
        gp = gpar(fontsize = yLabels.text.fontsize) #, fontfamily = "mono")
      )
    }
    ##### Top one
    if (is.null(upper1.y_axis.lim)) {upper1.y_lim <- max(df$total_count)} else {upper1.y_lim <- upper1.y_axis.lim}
    labels.yLabels2 <- seq(0,upper1.y_lim,length.out = 3) %>% round
    y.yLables_top.vec <- seq(y.upper, y.upper + h.upper, length.out=3)
    for (i in 1:length(y.yLables_top.vec)) {
      # Axis
      grid.segments(x0 = 1,
                    x1 = 1,
                    y0 = y.upper,
                    y1 = y.upper + h.upper,
                    gp = gpar(col="black", lwd = 0.75))
      # Ticks
      grid.segments(x0 = 0.95,
                    x1 = 1,
                    y0 = y.yLables_top.vec[i],
                    y1 = y.yLables_top.vec[i],
                    gp = gpar(col="black", lwd = 0.75))
      # Text
      grid.text(
        label = labels.yLabels2[i],
        just = c("right","center"),
        x = x.yLabels,
        y = y.yLables_top.vec[i],
        gp = gpar(fontsize = yLabels.text.fontsize) #, fontfamily = "mono")
      )
    }
    
    ### 5. Y axis titles
    x.yLabels_top <- 1 - y_axis.top_label.offset
    x.yLabels_bot <- 1 - y_axis.bottom_label.offset
    y.yLables_bottom.label <- (y.inner + h.inner)/2
    grid.text(label = y_axis.title.bottom,
              just = c("center","center"),
              x = x.yLabels_bot,
              y = y.yLables_bottom.label,
              rot = 90,
              gp = gpar(fontsize = yLabels.label.text.fontsize) #, fontfamily = "mono")
              )
      
    y.yLables_top.label <- h.upper/2 + y.upper
    grid.text(#label = "Total\nINDELs",
              label = y_axis.title.top,
              just = c("center","center"),
              x = x.yLabels_top,
              y = y.yLables_top.label,
              rot = 90,
              gp = gpar(fontsize = yLabels.label.text.fontsize) #, fontfamily = "mono")
              )
    
    
    
    ### 6. Legend
    seekViewport(vp.legend$name)
    #grid.rect()
    #x.lgd <- 0.5; y.lgd <- 0.5; w.lgd <- 0.8; h.lgd <- 0.5
    #vp.legend.box <- viewport(x=x.lgd, y=y.lgd, width=w.lgd, height=h.lgd, just=c("center","center")) # w.r.s.t. vp.legend
    #grid.rect(vp=vp.legend.box)
    grid.legend(sigNames, pch=15,
                # hgap = 0.2,
                vgap = legend.vgap,
                gp=gpar(col=palette.exposures, fill=palette.exposures, fontsize=legend.fontsize))
  }
  
  draw_drawings()
  
  ## Back to the initial viewport
  if (newpage != TRUE) { eval(backToTheInitialVp) }
  
}

## HELPER FUNCTION: plotAll_pub: 2020-3-6
## INPUT: queryResult, newpage, ylim, plot.title, k
## OUTPUT: a plot
## DEPENDENCY: plotSNVSpectra(), plotExposures()
## NOTE: a wrapper function that plots both signatures and exposures
plotAll_pub <- function(SNV_grobList=NULL,
                        # queryResult = NULL, 
                        newpage = TRUE, ylim = NULL, plot.title = NULL, title.fontsize = 15, k = NULL,
                        signaturePlot.height.px = 250, plot.height.px = NULL, exposure.isRelative = FALSE,
                        bar.edge.color = "black", bar.edge.size = 0.1, bar.width = 1, legend.position = "right",
                        axis.text.x.fontsize = 6, x.bar_legend.border = 0.8, y.cut = NULL, #y.orig_prop.border = 1/3,
                        orig.rel_heights = 1, prop.rel_heights = 1, orig.top.rel_heights = .3, orig.bottom.rel_heights = 1,
                        sig.background.alpha = 0.1,
                        sig.x.axis.fontsize = 7, sig.y.axis.fontsize = 7, sig.upperLabels.text.fontsize = 12,
                        sig.xLabels.text.y = 0.5, sig.yLabels.text.x = 0.9,
                        sig.plot.x = 0, sig.plot.width = 0.7,
                        ggplot_options = NULL){
  
  suppressMessages(library(cowplot))
  
  # Pre-processing :: absolute counts and relative counts
  # tmp.queryResult <- queryResult
  tmp.n.signatures <- tmp.queryResult$exposures %>% nrow
  
  tmp.n.signatures <- 
  
  if (exposure.isRelative == TRUE){
    tmp.queryResult.exposures.relative <- tmp.queryResult$exposures
    tmp.queryResult.exposures.absolute <- cbind(tmp.queryResult$exposures[,1],tmp.queryResult$exposures[,-1] * matrix(rep(colSums(tmp.queryResult$input_data.df[,-c(1,2)]), each = tmp.n.signatures), nrow = tmp.n.signatures))
  } else if (exposure.isRelative == FALSE){
    tmp.queryResult.exposures.absolute <- tmp.queryResult$exposures
    tmp.queryResult.exposures.relative <- cbind(tmp.queryResult$exposures[,1], tmp.queryResult$exposures[,-1] / matrix(rep(colSums(tmp.queryResult$exposures[,-1]), each = tmp.n.signatures),nrow = tmp.n.signatures))
  }
  
  # Get order for sorting
  tmp.order <- order(c(Inf,colSums(tmp.queryResult.exposures.absolute[,-1])), decreasing = TRUE)
  
  # Plotting
  if(!is.null(newpage)){grid.newpage()}
  
  #
  if(!is.null(plot.title)){
    viewport(x = 0, y = 0.95, width = 1, height = 0.05, just = c("left","bottom"))
    vp.title <- viewport(x = 0, y = 0.95, width = 1, height = 0.05, just = c("left","bottom"))
    grid.text(x = 0.05, y = 0.5, plot.title, gp = gpar(fontsize = title.fontsize, fontface = "bold"), just = c("left","center"), vp=vp.title)
  }
  
  if(is.null(plot.height.px)){plot.height.px <- 1600 + signaturePlot.height.px * k}
  
  tmp.sigPlot.h <- signaturePlot.height.px * k / plot.height.px
  tmp.expPlot.h <- (1 - tmp.sigPlot.h) / 2
  
  ## Create viewports
  tmp.x <- sig.plot.x
  tmp.y <- 2*tmp.expPlot.h
  tmp.w <- sig.plot.width
  tmp.h <- tmp.sigPlot.h
  
  vp.signatures_field <- viewport(x=tmp.x, y=tmp.y, width=tmp.w, height=tmp.h, just=c("left","bottom"))
  vp.exposures_field <- viewport(x=0, y=0, width=1, height=1 - tmp.h, just=c("left","bottom"))
  
  ## GO TO vp.main
  vp.main <- viewport(x = 0, y = 0, width = 1, height = 0.95, just = c("left","bottom"))
  pushViewport(vp.main)
  
  ## PLOT SNV SPECTRA
  pushViewport(vp.signatures_field)
  plotINDELspectra(df = tmp.queryResult$signatures, newpage = FALSE, background.alpha = sig.background.alpha,
                   upperLabels.text.fontsize = sig.upperLabels.text.fontsize,
                   xLabels.text.fontsize = sig.x.axis.fontsize,
                   yLabels.text.fontsize = sig.y.axis.fontsize,
                   xLabels.text.y = sig.xLabels.text.y,
                   yLabels.text.x = sig.yLabels.text.x)
  popViewport()
  
  ## PLOT EXPOSURES
  if(is.null(y.cut)){
    ggplot_options.p_exp_orig <- list(theme(axis.text.x = element_blank(),
                                            axis.title.x = element_blank(),
                                            axis.ticks.x = element_blank(),
                                            axis.title.y = element_blank(),
                                            legend.position = "none"))
    
    ggplot_options.p_exp_prop <- list(theme(axis.title.x = element_blank(),
                                            axis.title.y = element_blank(),
                                            axis.text.x = element_text(size = axis.text.x.fontsize),
                                            legend.position = "none"))
    
    p.exp_prop <- plotExposures(df = tmp.queryResult.exposures.relative[,tmp.order], newpage = FALSE,
                                bar.edge.color = bar.edge.color, bar.edge.size = bar.edge.size, bar.width = bar.width,
                                ggplot_options = ggplot_options.p_exp_prop)
    
    p.exp_orig <- plotExposures(df = tmp.queryResult.exposures.absolute[,tmp.order], newpage = FALSE,
                                bar.edge.color = bar.edge.color, bar.edge.size = bar.edge.size, bar.width = bar.width,
                                ggplot_options = ggplot_options.p_exp_orig)
    
    # Reduce margins
    p.exp_orig <- p.exp_orig + theme(plot.margin = unit(c(20,20,0,20), units = "pt")) # unit(c(top, right, bottom, left),...)
    p.exp_prop <- p.exp_prop + theme(plot.margin = unit(c(0,20,0,20), units = "pt"))
    
    # ylim
    if(!is.null(ylim)){p.exp_orig <- p.exp_orig + coord_cartesian(ylim=ylim)}
    
    # Store the drawing of the exposure plots and legend
    p_raw <- plot_grid(p.exp_orig, p.exp_prop, ncol=1, align="v", rel_heigths = c(orig.rel_heights, prop.rel_heights))
    tmp.legend <- get_legend(p.exp_orig + labs(fill = "Signature") + theme(legend.position = "right")) #, legend.title = element_text(face = "bold")))
    
  }
  # if y.cut is set, do split the towering bars
  if(!is.null(y.cut)){
    
    ggplot_options.p_exp_prop <- list(theme(axis.title.x = element_blank(),
                                            axis.title.y = element_blank(),
                                            axis.text.x = element_text(size = axis.text.x.fontsize),
                                            legend.position = "none"))
    
    ggplot_options.p_exp_orig.top <- list(theme(axis.text.x = element_blank(),
                                                axis.title.x = element_blank(),
                                                axis.ticks.x = element_blank(),
                                                axis.title.y = element_blank(),
                                                legend.position = "none"))
    
    ggplot_options.p_exp_orig.bottom <- list(theme(axis.text.x = element_blank(),
                                                   axis.title.x = element_blank(),
                                                   axis.ticks.x = element_blank(),
                                                   axis.title.y = element_blank(),
                                                   legend.position = "none"))
    
    p.exp_prop <- plotExposures(df = tmp.queryResult.exposures.relative[,tmp.order], newpage = FALSE,
                                bar.edge.color = bar.edge.color, bar.edge.size = bar.edge.size, bar.width = bar.width,
                                ggplot_options = ggplot_options.p_exp_prop)
    
    p.exp_orig.top <- plotExposures(df = tmp.queryResult.exposures.absolute[,tmp.order], newpage = FALSE,
                                    bar.edge.color = bar.edge.color, bar.edge.size = bar.edge.size, bar.width = bar.width,
                                    ggplot_options = ggplot_options.p_exp_orig.top)
    
    p.exp_orig.bottom <- plotExposures(df = tmp.queryResult.exposures.absolute[,tmp.order], newpage = FALSE,
                                       bar.edge.color = bar.edge.color, bar.edge.size = bar.edge.size, bar.width = bar.width,
                                       ggplot_options = ggplot_options.p_exp_orig.bottom)
    
    # Reduce margins
    p.exp_prop <- p.exp_prop + theme(plot.margin = unit(c(0,30,20,20), units = "pt")) # unit(c(top, right, bottom, left),...)
    p.exp_orig.top <- p.exp_orig.top + theme(plot.margin = unit(c(20,30,5,20), units = "pt")) # unit(c(top, right, bottom, left),...)
    p.exp_orig.bottom <- p.exp_orig.bottom + theme(plot.margin = unit(c(0,30,15,20), units = "pt")) # unit(c(top, right, bottom, left),...)
    
    p.exp_prop <- p.exp_prop + coord_cartesian(expand = FALSE)
    # y.cut
    p.exp_orig.top <- p.exp_orig.top + coord_cartesian(ylim=c(y.cut, colSums(tmp.queryResult.exposures.absolute[,-1]) %>% max %>% signif(digits=2)), expand = FALSE)
    p.exp_orig.bottom <- p.exp_orig.bottom + coord_cartesian(ylim=c(0, y.cut), expand = FALSE)
    
    # Store the drawing of the exposure plots and legend
    p_raw <- plot_grid(p.exp_orig.top, p.exp_orig.bottom, p.exp_prop, ncol=1, align="v", rel_heights = c(orig.top.rel_heights,
                                                                                                         orig.bottom.rel_heights,
                                                                                                         prop.rel_heights))
    tmp.legend <- get_legend(p.exp_orig.bottom + labs(fill = "Signature") + theme(legend.position = "right")) #, legend.title = element_text(face = "bold")))
    
  }
  # NOTE: Getting legend (ref.:https://stackoverflow.com/questions/13649473/add-a-common-legend-for-combined-ggplots)
  #plot_grid(tmp.legend)
  #p_raw <- cowplot::plot_grid(p.exp_orig, p.exp_prop, ncol=1, align="v", labels = c("A","B")) # with labels
  p <- plot_grid(p_raw, tmp.legend, ncol = 2, rel_widths = c(1, .2))
  #print(p, newpage=FALSE, vp = vp.exposures_barplot)
  print(p, newpage=FALSE, vp = vp.exposures_field)
  #popViewport() # from vp.exposures_field
  popViewport() # From vp.main
  
}



# EXTERNAL
# Generate a plot of color names which R knows about.
#++++++++++++++++++++++++++++++++++++++++++++
# cl : a vector of colors to plots
# bg: background of the plot
# rot: text rotation angle
#usage=showCols(bg="gray33")
showCols <- function(cl=colors(), bg = "grey", cex = 0.75, rot = 30) {
  m <- ceiling(sqrt(n <-length(cl)))
  length(cl) <- m*m; cm <- matrix(cl, m)
  require("grid")
  grid.newpage(); vp <- viewport(w = .92, h = .92)
  grid.rect(gp=gpar(fill=bg))
  grid.text(cm, x = col(cm)/m, y = rev(row(cm))/m, rot = rot,
            vp=vp, gp=gpar(cex = cex, col = cm))
}
