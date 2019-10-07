.libPaths("/home/users/jhyouk/R/x86_64-redhat-linux-gnu-library/3.5")
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

print("start sequenza.extract")
this_data<-sequenza.extract(file=args[1],assembly = args[5])

if (args[6] == 'XX'){
  print("start fitting...")
  this_data.example<-sequenza.fit(this_data,female = TRUE)
  print("fitting done. start sequenza.results")
  sequenza.results(sequenza.extract=this_data,cp.table=this_data.example, sample.id=args[2], out.dir=args[2], female = TRUE)
} else{
  print("start fitting...")
  this_data.example<-sequenza.fit(this_data,female = FALSE)
  print("fitting done. start sequenza.results")
  sequenza.results(sequenza.extract=this_data,cp.table=this_data.example, sample.id=args[2], out.dir=args[2], female = TRUE)
}
print("Done!")
