import os
import pandas as pd

ref_dir = "../data/cyanophage_genomes"
count_dir = "../data/cyanophage_genomes/Counts"
feature_files = [os.path.join(ref_dir, i) for i in os.listdir(ref_dir) if i.endswith("genes")]
stubs = [os.path.basename(i).split(".")[0] for i in feature_files]
gff_files = [os.path.join(ref_dir, i+".1.gff") for i in stubs]
count_files = [os.path.join(count_dir, i+".1.mod.cnt") for i in stubs]
out_files = [os.path.join(ref_dir, i+".1.gene.cov") for i in stubs]

for cnt, ff, gff, of_ in zip(count_files, feature_files, gff_files, out_files):
    df = pd.read_csv(ff, sep="\t", header=None, usecols=[1,2])
    g_df = pd.read_csv(gff, sep="\t", header=None, usecols=[3,4,8])
    cvg_df = pd.read_csv(cnt, sep="\t", header=None, usecols=[1,2])
    df_out = df.copy()
    df_out.columns = ["start", "end"]
    
    for new_col in ["gene_length", "avg_cvg", "cvd_bases"]:
        df_out[new_col] = [0]*df_out.shape[0]
    
    for ff_f in df.index:
        mapped_seg = cvg_df[(cvg_df[1] > df.ix[ff_f, 1]) & (cvg_df[1] < df.ix[ff_f, 2])][2]
        if mapped_seg.shape[0] == 0:
            df_out.drop(ff_f, axis=0, inplace=True)
        else:
            df_out.ix[ff_f, "gene_length"] = df.ix[ff_f, 2] - df.ix[ff_f, 1]
            df_out.ix[ff_f, "avg_cvg"] = mapped_seg.sum() / float(df_out.ix[ff_f, "gene_length"])
            df_out.ix[ff_f, "cvd_bases"] = (mapped_seg > 0).sum()
    
    for ff_found in df_out.index:
        start_to_match = df_out.start[ff_found]
        matches = g_df[g_df[3] == start_to_match]
        if matches.shape[0] == 1:
            product = matches[8].values[0]
        else:
            cds_matches = matches[matches[8].str.contains("product")][8]
            if cds_matches.shape[0] == 0:
                cds_matches = matches[matches[8].str.contains("gene")][8]
            product = cds_matches.values[0]
        df_out.ix[ff_found, "products"] = product
    
    df_out.to_csv(of_, sep="\t", index=False)
    print "{} detected genes written out to {}".format(df_out.shape[0], of_)


