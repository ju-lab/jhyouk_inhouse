library("sequenza")
args <- commandArgs(trailingOnly=TRUE)
### args1 = input file
### args2 = sample id
print(args[1])
this_data<-sequenza.extract(file=args[1])
print("start fitting...")
this_data.example<-sequenza.fit(this_data)
sequenza.results(sequenza.extract=this_data,cp.table=this_data.example, sample.id=args[2], out.dir=args[2])
print("Done!")
