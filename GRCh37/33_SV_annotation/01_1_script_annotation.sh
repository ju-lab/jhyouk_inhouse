sampleID=$1
germlineID=$2

sh 01_Delly_annotation.sh $1 10 /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37/$1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/05_bam_human_sample_GRCh37/$2.s.md.ir.br.bam /home/users/jhyouk/09_uveal_melanoma/13_SV_annotation/PON.delly.txt Delly_annotation_scripts hg19
