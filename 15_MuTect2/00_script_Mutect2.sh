somatic=$1
germline=$2

/home/users/jhyouk/tools/gatk-4.0.11.0/gatk --java-options "-Xmx16G" Mutect2 -R /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa -I /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam -I /home/users/team_projects/Radiation_signature/02_bam/$2.s.md.ir.br.bam -tumor $1 -normal $2 -O $1.Mutect2.vcf &> $1.Mutect2.out
