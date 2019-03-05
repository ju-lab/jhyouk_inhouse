$1=sampleID

samtools mpileup -B -Q 20 -q 20 -f /home/users/jhyouk/99_reference/human/hg38/Homo_sapiens_assembly38.fasta /home/users/team_projects/Radiation_signature/04_bam_human_sample/$1.s.md.ir.br.bam -o $1.mpileup &> $1.mpileup.out
