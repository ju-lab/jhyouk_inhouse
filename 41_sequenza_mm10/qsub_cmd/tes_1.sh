#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/41_sequenza_mm10/qsub_sdout/tes_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/41_sequenza_mm10
sh 01_flow_sequenza_mm10.sh /home/users/jhyouk/06_mm10_SNUH_radiation/06_mpileup Liver_2Gy2_SO4 Liver_2Gy_2_G 1 2 mm10 XY