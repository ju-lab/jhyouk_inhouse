somatic=$1
germline=$2

/home/users/jhyouk/tools/gatk-4.0.11.0/gatk --java-options "-Xmx16G" Mutect2 -R /home/users/jhyouk/99_reference/human/GRCh37/human_g1k_v37.fasta -I /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37/$1.s.md.ir.br.bam -I /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37/$2.s.md.ir.br.bam -tumor $1 -normal $2 -O $1.Mutect2.vcf &> $1.Mutect2.out
