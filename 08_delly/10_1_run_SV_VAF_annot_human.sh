sampleName=$1

python 10_SV_VAF_annot_v2.py $1.delly.somatic.vcf.BPinfo4.filter1.rearrange /home/users/team_projects/Radiation_signature/04_bam_human_sample/$1.s.md.ir.br.bam &> $1.10_SV.out
