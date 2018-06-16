import pandas as pd
import os, sys
import numpy as np

# get any file that ends in "*cov2.txt"

dir_, match_str = sys.argv[-1], sys.argv[-2]
files_ = [os.path.join(dir_, i) for i in os.listdir(dir_) if match_str in i ]
print "{} files detected".format(len(files_))

cov_lst = []
for idx, f_ in enumerate(files_):
    col_ = os.path.basename(f_).split(match_str)[0]
    df_ = pd.read_csv(f_, sep="\t", header=None)
    df_.columns = ["acc", "coverage", "bases_in", "genome_size", "pct"]
    df_["intermezzo"] = df_.ix[:, ["coverage", "bases_in", "genome_size"]].apply(tuple, axis=1)
    cov_fxn = lambda x: (x[0]*x[1])/float(x[2])
    df_[col_] = df_.intermezzo.apply(cov_fxn)
    cov_srs = df_.groupby("acc")[col_].agg(np.sum)
    cov_lst.append(cov_srs)
    print "\tProcessed {} with {} recs".format(col_, cov_srs.shape[0])

cov_df = pd.concat(cov_lst, axis=1, keys=[i.name for i in cov_lst], sort=True, verify_integrity=True)
cov_df.fillna(0.0, inplace=True)

read_counts = {"SERC_517_10":9205219, "SERC_517_11":6231528, 
               "SERC_517_12":11040193, "SERC_517_13":10624630, 
               "SERC_517_3":17642729, "SERC_517_4":13726512, 
               "SERC_517_5":8490889, "SERC_517_6":13663106, 
               "SERC_517_7":12027351, "SERC_517_8":11103784, 
               "SERC_517_9":4106160, "SERC_Zymo_Pos_Control":9458841}

rc_df = pd.DataFrame(read_counts, index=["read_count"]).T
rc_df['norm_scaler'] = rc_df / rc_df.mean()

to_norm = list(cov_df.columns); to_norm.remove("genome_size");
norm_cov_df = cov_df.copy()
for a_col in to_norm:
    norm_cov_df[a_col] = cov_df[a_col]*rc_df.ix[a_col, "norm_scaler"]

writer = pd.ExcelWriter(os.path.join(dir_, 'viral_refseq_coverage.xlsx'), engine='xlsxwriter')

col_order = ["SERC_517_3", "SERC_517_4",
             "SERC_517_5", "SERC_517_6",
             "SERC_517_7", "SERC_517_8",
             "SERC_517_9", "SERC_517_10",
             "SERC_517_11","SERC_517_12",
             "SERC_517_13","SERC_Zymo_Pos_Control"]

# Convert the dataframe to an XlsxWriter Excel object.
norm_cov_df.ix[:, col_order].to_excel(writer, sheet_name='Normalized_Coverage')
cov_df.ix[:, col_order].to_excel(writer, sheet_name='Raw_Coverage')
rc_df.ix[col_order,:].to_excel(writer, sheet_name='Read_Count')
# Close the Pandas Excel writer and output the Excel file.
writer.save()