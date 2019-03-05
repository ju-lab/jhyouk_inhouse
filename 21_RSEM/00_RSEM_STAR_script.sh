sampleName=$1
thr=4

#STAR --genomeDir /home/users/jhyouk/99_reference/mouse/STAR_mm10 --readFilesIn /home/users/team_projects/Radiation_signature/11_fastq_RNA/$1_1.trimmed.fastq.gz /home/users/team_projects/Radiation_signature/11_fastq_RNA/$1_2.trimmed.fastq.gz --outSAMtype BAM SortedByCoordinate --outSAMstrandField intronMotif --twopassMode Basic --quantMode TranscriptomeSAM --outFileNamePrefix $1_ --runThreadN $thr --readFilesCommand zcat &> $1.out &&
#mv $1.out $1.success.out &&
rsem-calculate-expression --paired-end --alignments --no-bam-output -p $thr $1_Aligned.toTranscriptome.out.bam /home/users/jhyouk/99_reference/mouse/RSEM_mm10/mm10_ensembl $1_rsem &> $1.rsem.out &&
mv $1.rsem.out $1.success.rsem.out
