#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza/qsub_sdout/21_2_run_seqz_segment_clear_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/07_sequenza
sh 21_bash_seqz_segment_clear.sh S1-0Gy-1
sh 21_bash_seqz_segment_clear.sh S1-0Gy-2
sh 21_bash_seqz_segment_clear.sh S1-1Gy-1
sh 21_bash_seqz_segment_clear.sh S1-1Gy-2
sh 21_bash_seqz_segment_clear.sh S1-2Gy-1
sh 21_bash_seqz_segment_clear.sh S1-2Gy-2
sh 21_bash_seqz_segment_clear.sh S1-4Gy-1
sh 21_bash_seqz_segment_clear.sh S1-4Gy-2
sh 21_bash_seqz_segment_clear.sh S1-8Gy-1
sh 21_bash_seqz_segment_clear.sh N1-S1
sh 21_bash_seqz_segment_clear.sh dirams_8Gy