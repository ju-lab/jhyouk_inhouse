suppressMessages(library("optparse"))
suppressMessages(library("sequenza"))
suppressMessages(library("devtools"))
install_github("aroneklund/copynumber")
library("copynumber")

option_list = list(
  make_option(c("--seqz_file"), type="character", default=NULL,
              help="seqz.gz file name", metavar="character"),
  make_option(c("-o", "--output_dir"), type="character", default=".", 
              help="output folder path [default= %default]", metavar="character"), 
  make_option(c("-s", "--sample_name"), type="character", default=".", 
              help="sample name", metavar="character"),
  make_option(c("-g", "--gender"), type="character", default = "XX",
              help="gender", metavar="chracter" )
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


if (is.null(opt$seqz_file) | is.null(opt$sample_name)){
  print_help(opt_parser)
  stop("--seqz_file and --sample_name are required.\n", call.=FALSE)
}

gender <- opt$gender

# Import Sequenza Datat
source("sequenza.extract.hg38.R") 
data = sequenza.extract.hg38(file=opt$seqz_file) # default assembly: hg38

# Start fitting
if (gender == "XX"){ 
	data_fit = sequenza.fit(data)
}	else {
	data_fit = sequenza.fit(data, female = FALSE)
}


# Save result
if (gender == "XX"){
	sequenza.results(sequenza.extract=data,cp.table=data_fit, sample.id=opt$sample_name, out.dir=opt$output_dir)
}	else {
	sequenza.results(sequenza.extract=data,cp.table=data_fit, sample.id=opt$sample_name, out.dir=opt$output_dir, female = FALSE)
}
print('Done')

