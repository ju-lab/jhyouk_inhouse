sampleName=$1

Rscript /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/11_Rscript_sequenzawithpurity.R $sampleName.comp.seqz.rmGLMTJH.gz $sampleName-withpurity 1 2 &> $sampleName.purity.Rscript.out
