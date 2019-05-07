sampleID=$1
germlineID=$2

sh /home/users/jhyouk/81_filter_test_LADC/11_universe_filter/000_universal_annotation_filter_invivo_temp.sh $1 snp mm10 /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam /home/users/team_projects/Radiation_signature/02_bam/$2.s.md.ir.br.bam ../31_1_PanelOfNormal_SPark/mm10_b6_4_190226.4s.q0Q0.chr1.mpileup.snv.edit.gz
