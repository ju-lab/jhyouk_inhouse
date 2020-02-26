#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/09_1_run_col_rearrange_190116_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
python 09_col_rearrange_order.py C3SO3