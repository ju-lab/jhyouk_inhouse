sampleID=$1
germlineID=$2
PON=$3

sh /home/users/jhyouk/81_filter_test_LADC/11_universe_filter/000_universal_annotation_filter_invivo.sh $1 indel mm10 /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/$2.s.md.ir.br.bam ../31_1_PanelOfNormal_SPark/$PON
