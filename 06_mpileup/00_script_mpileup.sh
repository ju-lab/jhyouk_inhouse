$1=sampleID

outDir=$(dirname $1)
log=$outDir/$1.mpileup.log

echo $1 > $log

echo "start mpileup" >> $log
(samtools mpileup -B -Q 20 -q 20 -f /home/users/jhyouk/99_reference/mouse/mm10/GRCm38.fa /home/users/team_projects/Radiation_signature/02_bam/$1.s.md.ir.br.bam -o $1.mpileup) &>> $log || { c=$?;echo "Error";exit $c; }

echo "100kb binning" >> $log
(python /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/05_get_coverage.py $1.mpileup) &>> $log || { c=$?;echo "Error";exit $c; }

echo "calculate stats" >> $log
(python /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/06_calculate_stats.py $1.mpileup.100kbcov) &>> $log || { c=$?;echo "Error";exit $c; }

(mv $1.mpileup.100kbcov ../07_sequenza) &>> $log || { c=$?;echo "Error";exit $c; }
(mv $1.mpileup.100kbcov.covstat ../07_sequenza) &>> $log || { c=$?;echo "Error";exit $c; }

ehco "done" >> $log
