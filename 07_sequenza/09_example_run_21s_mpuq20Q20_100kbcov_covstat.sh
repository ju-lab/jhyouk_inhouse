samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG01N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG01N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG01N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG01N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG01T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG01T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG01T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG01T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG02N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG02N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG02N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG02N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG02T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG02T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG02T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG02T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG03N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG03N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG03N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG03N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG03T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG03T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG03T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG03T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG05N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG05N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG05N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG05N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG05T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG05T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG05T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG05T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG07N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG07N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG07N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG07N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG07T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG07T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG07T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG07T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG08N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG08N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG08N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG08N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG08T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG08T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG08T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG08T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG09N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG09N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG09N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG09N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG09T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG09T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG09T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG09T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG10N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG10N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG10N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG10N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG10T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG10T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG10T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG10T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG11N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG11N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG11N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG11N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG11T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG11T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG11T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG11T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG12N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG12N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG12N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG12N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG12T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG12T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG12T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG12T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG13N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG13N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG13N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG13N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG13T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG13T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG13T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG13T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG14N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG14N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG14N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG14N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG14T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG14T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG14T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG14T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG15N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG15N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG15N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG15N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG15T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG15T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG15T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG15T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG16N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG16N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG16N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG16N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG16T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG16T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG16T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG16T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG17N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG17N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG17N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG17N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG17T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG17T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG17T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG17T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG18N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG18N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG18N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG18N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG18T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG18T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG18T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG18T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG20N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG20N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG20N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG20N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG20T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG20T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG20T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG20T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG21N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG21N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG21N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG21N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG21T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG21T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG21T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG21T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG22N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG22N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG22N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG22N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG22T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG22T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG22T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG22T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG23N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG23N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG23N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG23N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG23T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG23T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG23T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG23T_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG24N.merged.s.md.ir.br.md.rg.md.bam |gzip > WG24N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG24N_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG24N_q20Q20.mpileup.100kbcov
samtools mpileup -B -q 20 -Q 20 -f /home/users/data/01_reference/human_g1k_v37/human_g1k_v37.fasta WG24T.merged.s.md.ir.br.md.rg.md.bam |gzip > WG24T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/01_get_coverage.py WG24T_q20Q20.mpileup.gz
python /home/users/sypark/03_Tools/Smoothened_CN/02_calculate_stats.py WG24T_q20Q20.mpileup.100kbcov
