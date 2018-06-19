import pandas as pd
fn = "../data/normalized_coverages.txt"
fn2 = "../data/pct_covered.txt"
cov_df = pd.read_csv(fn, sep="\t", index_col=0)
pct_df = pd.read_csv(fn2, sep="\t", index_col=0)

cyanos = ["NC_006820.1", "NC_031935.1", "NC_025461.1", "NC_013085.1", "NC_031944.1", "NC_025464.1", "NC_031242.1", "NC_025456.1", "NC_031235.1"]
cyano_df = cov_df.ix[cyanos, :]
exp_cols = cov_df.columns[1:-2]



fp_df = cov_df[cov_df.SERC_Zymo_Pos_Control > 4.044303]
fp_pcts = pct_df.ix[fp_df.index, :]

for idx in [0.28]:
    print (fp_pcts.SERC_Zymo_Pos_Control > idx).sum()

for exp_col in exp_cols:
	pp_df = cov_df[cov_df[exp_col] > 4.044303]
	pp_pcts = pct_df.ix[pp_df.index, :]
    print (pp_pcts[exp_col] > 0.279).sum()
