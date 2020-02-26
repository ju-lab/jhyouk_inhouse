#!/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -o /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly/qsub_sdout/08_1_run_filter1_1.sh.sdout
cd /home/users/jhyouk/06_mm10_SNUH_radiation/08_delly
python 08_NA_filter.py S1-0Gy-1.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-0Gy-2.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-1Gy-1.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-1Gy-2.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-2Gy-1.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-2Gy-2.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-4Gy-1.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-4Gy-2.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py S1-8Gy-1.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py N1-S1.delly.somatic.vcf.BPinfo4
python 08_NA_filter.py dirams_8Gy.delly.somatic.vcf.BPinfo4