#!/bin/bash
#PBS -l nodes=1:ppn=4
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/62_callableLoci/qsub_sdout/00_callableLoci_2.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/62_callableLoci
--summary callableloci-summary.txt \