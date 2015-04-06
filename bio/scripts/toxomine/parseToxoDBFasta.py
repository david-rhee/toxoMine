import os, sys, re, commands
from Bio import SeqIO

######################
# Requirement
# parseToxoDBfasta.py
######################################
baseDirectory = '%s'%sys.argv[1]
inputType = '%s'%sys.argv[2]
inputFile = '%s'%sys.argv[3]

programCall = 'mkdir ' + baseDirectory + '/' + inputType
commands.getstatusoutput(programCall)

for seq_record in SeqIO.parse(baseDirectory + '/' + inputFile, "fasta"):
    # for Supercontig
    o = re.search(r"SO=supercontig", seq_record.description)
    if o :
        newFile = os.path.join(baseDirectory + '/' + inputType, seq_record.id + '.fasta')
        SeqIO.write(seq_record, newFile, "fasta")

    # for Contig
    p = re.search(r"SO=contig", seq_record.description)
    if p :
        newFile = os.path.join(baseDirectory + '/' + inputType, seq_record.id + '.fasta')
        SeqIO.write(seq_record, newFile, "fasta")

    # for Chromosome
    q = re.search(r"SO=chromosome", seq_record.description)
    if q :
        newFile = os.path.join(baseDirectory + '/' + inputType, seq_record.id + '.fasta')
        SeqIO.write(seq_record, newFile, "fasta")

#### OLD
#filePath = "/data1/toxomine/toxodb/fasta/current"
#for seq_record in SeqIO.parse('%s'%sys.argv[1], "fasta"):
#    # for ME49
#    m = re.match(r"TGME49_chr", seq_record.id)
#    if m :
#	newFile = os.path.join(filePath, seq_record.id + '.fasta')
#	SeqIO.write(seq_record, newFile, "fasta")
#
#    # for GT1
#    n = re.match(r"TGGT1_chr", seq_record.id)
#    if n :
#	newFile = os.path.join(filePath, seq_record.id + '.fasta')
#	SeqIO.write(seq_record, newFile, "fasta")
#
#    # for VEG
#    o = re.match(r"TGVEG_chr", seq_record.id)
#    if o :
#	newFile = os.path.join(filePath, seq_record.id + '.fasta')
#	SeqIO.write(seq_record, newFile, "fasta")