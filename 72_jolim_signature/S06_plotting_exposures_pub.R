################################################################################
# 
# A SET OF HELPER FUNCTIONS
# 
# Written by Joonoh Lim (Ju lab; joonoh.lim@kaist.ac.kr)  
#
# First created on 2020-3-12
################################################################################
library(data.table)
source("/home/users/jolim/Projects/S06_JH_Youk/code/R_project/S06_helper_functions2.R")
INDEL.exposure_table.input <- fread("/home/users/jolim/Projects/S06_JH_Youk/code/test_data/INDEL.mouse_clonal.exposure_table.df.tsv")
plotExposures_pub(df=INDEL.exposure_table.input,
                  left.margin=0.15, right.margin=0.15, yLabels.text.fontsize = 8,
                  upper1.y_axis.lim = 600,
                  y_axis.top_label.offset = 0.5,
                  op.signature_to_sort_by_and_overlay = "Sig-D",
                  color.palette.doses = NULL,
                  color.palette.exposures = NULL)
