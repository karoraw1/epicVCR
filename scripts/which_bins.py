# There are 110 unique reference viruses
# The hits are dispersed over many bins 
# The contigs aligned for a given virus are split over multiple bins usually
# A maximum of 8% of a bin is composed of regions that align to a virus, but most are much much smaller
# 


import pandas as pd
import os
import numpy as np

bin_dir = "../data/Bins/maxbin2_bins"
bin_files = [os.path.join(bin_dir, i ) for i in os.listdir(bin_dir)]
a_bin = bin_files[0]

def pull_names(a_bin):
    with open(a_bin, "r") as fh:
        headers = [i[1:] for i in fh.read().split("\n") if i.startswith(">")]
    with open(a_bin, "r") as fh:
        records = [len("".join(j.split("\n")[1:])) for j in fh.read().split(">") if j != ""]
    print "{} has {} recs and {} kb total length".format(os.path.basename(a_bin), len(headers), sum(records)/1000.0)
    return (headers, sum(records))

bin_data = {i:pull_names(i) for i in bin_files}
contig_lookup = {}

for b_n, b_d in bin_data.items():
    bin_name = os.path.basename(b_n)
    headers, bin_length = b_d
    for h in headers:
        if not contig_lookup.has_key(h):
            contig_lookup[h] = (bin_name, bin_length)
        else:
            print "Conflict"

coords_fn = "../data/virus_to_contig_alignment_filter_coords.txt"
coords_df = pd.read_csv(coords_fn, sep="\t", skiprows=3)
contigs_matched = coords_df.ix[:, '[NAME Q]'].unique()

colNames = ["RefStart", "RefEnd", "QStart", "QEnd", "RefAlndLen", "QAlndLen", "PctIdentity", "TotRefLen", "TotQLen", "PctRefCovd", "PctQCovd",
            "NameRef", "NameQ"]
coords_df.columns = colNames

is_contig_binned = lambda x: contig_lookup.has_key(x)

coords_df["is_binned"] = coords_df["NameQ"].apply(is_contig_binned)
coords_df["bin_membership"] = ["Unbinned"]*coords_df.shape[0]
coords_df["bin_size"] = np.zeros((coords_df.shape[0], 1))

for a_contig in contigs_matched:
    matches = coords_df[coords_df.ix[:, "NameQ"] == a_contig].index
    if contig_lookup.has_key(a_contig):
        coords_df.ix[matches, "bin_membership"] = contig_lookup[a_contig][0]
        coords_df.ix[matches, "bin_size"] = contig_lookup[a_contig][1]
    else:
        assert coords_df.ix[matches, ["is_binned"]].sum()[0] == 0


viruses_matched = coords_df.ix[:, 'NameRef'].unique()

for vm in viruses_matched:
    vm_df = coords_df[coords_df.NameRef == vm]
    vm_contigs = vm_df.NameQ.unique().shape[0]
    vm_bins = vm_df.bin_membership.unique().shape[0]
    print "for {}, {} contigs from {} bins were matched".format(vm, vm_contigs, vm_bins)

cyanos = ["NC_006820.1", "NC_031935.1", "NC_025461.1", "NC_013085.1", "NC_031944.1", "NC_025464.1", "NC_031242.1", "NC_025456.1", "NC_031235.1"]
for vm in cyanos:
    vm_df = coords_df[coords_df.NameRef == vm]
    vm_contigs = vm_df.NameQ.unique().shape[0]
    vm_bins = vm_df.bin_membership.unique().shape[0]
    print "for {}, {} contigs from {} bins were matched".format(vm, vm_contigs, vm_bins)

cyano_df = coords_df[coords_df.NameRef.isin(cyanos)].sort_values(by=["NameRef", "RefStart"])
names, counts = np.unique(cyano_df.bin_membership.values, return_counts=True)

for idx in range(len(names)):
    if names[idx] != "Unbinned":
        this_bs = coords_df[coords_df.bin_membership == names[idx]].bin_size.unique()[0]
        frac_alnd = coords_df[coords_df.bin_membership == names[idx]].QAlndLen.sum()
        print "{}: {} contigs, {} bp, {:%} pct of {}".format(names[idx], counts[idx], frac_alnd, frac_alnd/this_bs, this_bs)
        








