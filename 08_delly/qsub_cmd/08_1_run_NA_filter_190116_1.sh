#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/08_1_run_NA_filter_190116_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
python 08_NA_filter.py C3SO3