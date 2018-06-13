import pandas as pd
import os, sys

# get any file that ends in "*cov2.txt"

dir_ = sys.argv[-1]
files_ = [os.path.join(dir_, i) for i in os.listdir(dir_) if i.endswith("cov2.txt")]

print "{} files detected".format(len(files_))

bp_covs, pct_cov, colnames = [], [], []
for f_ in files_:
    col_ = os.path.basename(f_).split("_cov2.txt")[0]
    df_ = pd.read_csv(f_, sep="\t", header=None, index_col=0)
    df_.columns = ["coverage", "bases_in", "total_bases", "pct"]
    df_pos = df_[df_.coverage == 1]
    bp_covs.append(df_pos.bases_in.copy())
    pct_cov.append(df_pos.pct.copy())
    colnames.append(col_)

bp_df = pd.concat(bp_covs, axis=1, keys=colnames, sort=True)
pct_df = pd.concat(pct_cov, axis=1, keys=colnames, sort=True)
read_counts = {"SERC_517_10":9205219, "SERC_517_11":6231528, 
               "SERC_517_12":11040193, "SERC_517_13":10624630, 
               "SERC_517_3":17642729, "SERC_517_4":13726512, 
               "SERC_517_5":8490889, "SERC_517_6":13663106, 
               "SERC_517_7":12027351, "SERC_517_8":11103784, 
               "SERC_517_9":4106160, "SERC_Zymo_Pos_Control":9458841}
rc_df = pd.DataFrame(read_counts, index=["read_count"])
writer = pd.ExcelWriter('../data/viral_refseq_coverage.xlsx', engine='xlsxwriter')

col_order = ["SERC_517_3", "SERC_517_4",
             "SERC_517_5", "SERC_517_6",
             "SERC_517_7", "SERC_517_8",
             "SERC_517_9", "SERC_517_10",
             "SERC_517_11","SERC_517_12",
             "SERC_517_13","SERC_Zymo_Pos_Control"]

# Convert the dataframe to an XlsxWriter Excel object.
pct_df.ix[:, col_order].to_excel(writer, sheet_name='Pct_Genome_Covered')
bp_df.ix[:, col_order].to_excel(writer, sheet_name='Bases_Covered')
rc_df.ix[:, col_order].to_excel(writer, sheet_name='Read_Count')
# Close the Pandas Excel writer and output the Excel file.
writer.save()
