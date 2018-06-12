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

bp_df = pd.concat(bp_covs, axis=1, keys=colnames)
pct_df = pd.concat(pct_cov, axis=1, keys=colnames)

writer = pd.ExcelWriter('../data/viral_refseq_coverage.xlsx', engine='xlsxwriter')

# Convert the dataframe to an XlsxWriter Excel object.
pct_df.to_excel(writer, sheet_name='Pct_Genome_Covered')
bp_df.to_excel(writer, sheet_name='Bases_Covered')
# Close the Pandas Excel writer and output the Excel file.
writer.save()
