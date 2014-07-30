import os, sys, re
from Bio import SeqIO

######################
# Requirement
# parseToxoDBfasta.py file name

filePath = "/data1/toxomine/toxodb/fasta/current"
for seq_record in SeqIO.parse('%s'%sys.argv[1], "fasta"):
    # for ME49
    m = re.match(r"TGME49_chr", seq_record.id)
    if m :
	newFile = os.path.join(filePath, seq_record.id + '.fasta')
	SeqIO.write(seq_record, newFile, "fasta")
    # for GT1
    n = re.match(r"TGGT1_chr", seq_record.id)
    if n :
	newFile = os.path.join(filePath, seq_record.id + '.fasta')
	SeqIO.write(seq_record, newFile, "fasta")
    # for VEG
    o = re.match(r"TGVEG_chr", seq_record.id)
    if o :
	newFile = os.path.join(filePath, seq_record.id + '.fasta')
	SeqIO.write(seq_record, newFile, "fasta")