#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/05_2_run_filter_MH_MP_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
sh 05_1_script_filter_MH_MP.sh /home/users/jhyouk/06_mm10_SNUH_radiation/03_bam breast_mother breast_germline