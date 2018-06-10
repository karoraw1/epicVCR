SERC_ld = "/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/SERC_051717_Shotgun_Metagenomes/QCd/QC_Renamed_Seqs"
SERC_lns = ["SERC_Zymo_Pos_Control"]
CB_ld = "/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/CB33_Summer17_NexteraXT/QCd/QC_Renamed_Seqs"
CB_lns = ["CB_Zymo_Cellular_Ctrl", "CB_Zymo_DNA_Ctrl"]
ref_names = ["Bacillus_subtilis", "Cryptococcus_neoformans", "Enterococcus_faecalis", "Escherichia_coli", "Lactobacillus_fermentum", "Listeria_monocytogenes", "Pseudomonas_aeruginosa", "Saccharomyces_cerevisiae", "Salmonella_enterica", "Staphylococcus_aureus"]

sample_sheet_f = "/home-3/karoraw1@jhu.edu/scratch/Processed_data_group/Zymo_Refs/sample_sheet.tsv"

lib_info = [(SERC_ld, SERC_lns[0]), (CB_ld, CB_lns[0]), (CB_ld, CB_lns[1])]

with open(sample_sheet_f, "w") as fh:
    for ld, ln in lib_info:
        for rn in ref_names:
            fh.write("{}\t{}\t{}\n".format(ld, ln, rn))

