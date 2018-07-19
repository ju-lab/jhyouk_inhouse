sampleName=$1

set -e
#python 05_get_coverage.py ../06_mpileup/$1.mpileup &> $1.05.coverage.out
python 06_calculate_stats.py $1.mpileup.100kbcov &> $1.06.cal.out
