"""
home_dir=/home-3/karoraw1@jhu.edu/scratch/Processed_data_group
csv_1=$home_dir/CB33_Summer17_NexteraXT/CB33_Summer17_NexteraXT.csv
data_1=$home_dir/CB33_Summer17_NexteraXT/Raw_Unzipped
python rename_files.py $data_1 $csv_1

csv_2=$home_dir/SERC_051717_Shotgun_Metagenomes/SERC_051717_Shotgun_Metagenomes.csv
data_2=$home_dir/SERC_051717_Shotgun_Metagenomes/Raw_Unzipped
python rename_files.py $data_2 $csv_2
"""

import pandas as pd
import os, sys

args = sys.argv
sample_sheet = args[-1]
data_drive = args[-2]

assert os.path.isfile(sample_sheet) and os.path.isdir(data_drive)

df = pd.read_csv(sample_sheet)
df["F"] = df["File_Name"]+"_1.fastq"
df["R"] = df["File_Name"]+"_2.fastq"
make_path = lambda x: os.path.join(data_drive, x)
df["R_path"] = df.R.apply(make_path)
df["F_path"] = df.F.apply(make_path)
sanityCheck = df.R_path.apply(os.path.isfile).sum() + df.F_path.apply(os.path.isfile).sum()
assert sanityCheck == df.shape[0]*2
df["F_new"] = df["SM_Tag"]+"_1.fastq"
df["R_new"] = df["SM_Tag"]+"_2.fastq"

for idx in df.index:
    in_f = df.ix[idx, 'F_path']
    out_f = os.path.join(data_drive, df.ix[idx, 'F_new'])
    print "Renaming {} as {}".format(df.ix[idx, 'F'], df.ix[idx, 'F_new'])
    print "\tBefore: {}\n\tAfter: {}".format(in_f, out_f)
    os.rename(in_f, out_f)

    in_r = df.ix[idx, 'R_path']
    out_r = os.path.join(data_drive, df.ix[idx, 'R_new'])
    print "Renaming {} as {}".format(df.ix[idx, 'R'], df.ix[idx, 'R_new'])
    print "\tBefore: {}\n\tAfter: {}".format(in_r, out_r)
    os.rename(in_r, out_r)



