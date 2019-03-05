$1=sampleID

samtools mpileup -B -Q 20 -q 20 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam -o $1.mpileup &> $1.mpileup.out
