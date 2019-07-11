library("sequenza")
library("copynumber")
args<-commandArgs(trailingOnly=TRUE)
#args[1]=input
#args[2]=id
#args[3]=cellularity
#args[4]=ploidy
#args[5]=reference (hg19 or mm10)
#args[6]=gender (XX or XY)
options("scipen"=100, "digits"=4)

#source("winsorize_mm10.R")
#source("aspcf_mm10.R")
#source("find.breaks_mm10.R")
#source("numericChrom.R")
#source("sequenza.extract.mm10.R")
#source("sequenza.extract.mm10.R")
print("start sequenza.extract")
bp_table <- read.table("4-8_chromothripsis.txt", header = T)
this_data<-sequenza.extract(file=args[1],assembly = args[5], breaks = bp_table)
#if (args[5] == 'mm10'){
#  chnum = 1:21
#} else {
#  chnum = 1:24
#}
if (args[6] == 'XX'){
  print("start fitting...")
  this_data.example<-sequenza.fit(this_data,female = TRUE)
  print("fitting done. start sequenza.results")
  sequenza.results(sequenza.extract=this_data,cp.table=this_data.example, sample.id=args[2], out.dir=args[2], cellularity=as.numeric(args[3]), ploidy=as.numeric(args[4]), female = TRUE)
} else{
  print("start fitting...")
  this_data.example<-sequenza.fit(this_data,female = FALSE)
  print("fitting done. start sequenza.results")
  sequenza.results(sequenza.extract=this_data,cp.table=this_data.example, sample.id=args[2], out.dir=args[2], cellularity=as.numeric(args[3]), ploidy=as.numeric(args[4]), female = TRUE)
}
print("Done!")
