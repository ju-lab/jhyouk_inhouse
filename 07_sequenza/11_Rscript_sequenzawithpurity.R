args<-commandArgs(trailingOnly=TRUE)
#args[1]=input
#args[2]=id
#args[3]=cellularity
#args[4]=ploidy
library("sequenza")
print(args[2])
options("scipen"=100, "digits"=4)
this_data<-sequenza.extract(file=args[1])
print("start fitting...")
this_data.example<-sequenza.fit(this_data)
sequenza.results(sequenza.extract=this_data,cp.table=this_data.example, sample.id=args[2], out.dir=args[2], cellularity=as.numeric(args[3]), ploidy=as.numeric(args[4]))
print("Done!")
