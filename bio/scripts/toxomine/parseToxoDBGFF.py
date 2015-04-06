import os, sys, re, string, commands
import pprint
from BCBio.GFF import GFFExaminer
from BCBio import GFF

####################################################################################################################################
# Parses out chromosome, contigs and supercontigs separately
# Requirement
# parseToxoDBGFF.py 
def me49 (raw):
    outputFile = os.path.join(baseDirectory + '/' + inputType, 'chromosome/' + inputFile)
    outfile = open(outputFile,'w')
    outfile.write('##gff-version	3\n')
    outfile.write('##feature-ontology      so.obo\n')
    outfile.write('##attribute-ontology    gff3_attributes.obo\n')
    for row in range(0,len(raw)):
        # For ME49 chromosome
        m = re.match(r"TGME49_chr", string.strip(raw[row]))
        if m :
            a = re.search(r"(ToxoDB)\t(chromosome)", string.strip(raw[row]))
            if not a :
                outfile.write(raw[row])
    outfile.close()

    outputFile = os.path.join(baseDirectory + '/' + inputType, 'contig/' + inputFile)
    outfile = open(outputFile,'w')
    outfile.write('##gff-version	3\n')
    outfile.write('##feature-ontology      so.obo\n')
    outfile.write('##attribute-ontology    gff3_attributes.obo\n') 
    for row in range(0,len(raw)):
        # For ME49 contig
        m = re.match(r"ABPA", string.strip(raw[row]))
        if m :
            outfile.write(raw[row])
    outfile.close()

    outputFile = os.path.join(baseDirectory + '/' + inputType, 'supercontig/' + inputFile)
    outfile = open(outputFile,'w')
    outfile.write('##gff-version	3\n')
    outfile.write('##feature-ontology      so.obo\n')
    outfile.write('##attribute-ontology    gff3_attributes.obo\n') 
    for row in range(0,len(raw)):
        # For ME49 super contig
        m = re.match(r"tgme49_asmbl", string.strip(raw[row]))
        if m :
            a = re.search(r"(ToxoDB)\t(supercontig)", string.strip(raw[row]))
            if not a :
                b = re.search(r"(ToxoDB)\t(apicoplast_chromosome)", string.strip(raw[row]))
                if not b :
                    outfile.write(raw[row])
    outfile.close()

def gt1 (raw):
    outputFile = os.path.join(baseDirectory + '/' + inputType, 'chromosome/' + inputFile)
    outfile = open(outputFile,'w')
    outfile.write('##gff-version	3\n')
    outfile.write('##feature-ontology      so.obo\n')
    outfile.write('##attribute-ontology    gff3_attributes.obo\n')
    for row in range(0,len(raw)):
        # For ME49 chromosome
        m = re.match(r"TGGT1_chr", string.strip(raw[row]))
        if m :
            a = re.search(r"(ToxoDB)\t(chromosome)", string.strip(raw[row]))
            if not a :
                outfile.write(raw[row])
    outfile.close()

    outputFile = os.path.join(baseDirectory + '/' + inputType, 'contig/' + inputFile)
    outfile = open(outputFile,'w')
    outfile.write('##gff-version	3\n')
    outfile.write('##feature-ontology      so.obo\n')
    outfile.write('##attribute-ontology    gff3_attributes.obo\n') 
    for row in range(0,len(raw)):
        # For ME49 contig
        m = re.match(r"AAQM", string.strip(raw[row]))
        if m :
            a = re.search(r"(ToxoDB)\t(contig)", string.strip(raw[row]))
            if not a :
                b = re.search(r"(ToxoDB)\t(apicoplast_chromosome)", string.strip(raw[row]))
                if not b :
                    outfile.write(raw[row])
    outfile.close()

def veg (raw):
    outputFile = os.path.join(baseDirectory + '/' + inputType, 'chromosome/' + inputFile)
    outfile = open(outputFile,'w')
    outfile.write('##gff-version	3\n')
    outfile.write('##feature-ontology      so.obo\n')
    outfile.write('##attribute-ontology    gff3_attributes.obo\n')
    for row in range(0,len(raw)):
        # For VEG chromosome
        m = re.match(r"TGVEG_chr", string.strip(raw[row]))
        if m :
            a = re.search(r"(ToxoDB)\t(chromosome)", string.strip(raw[row]))
            if not a :
                outfile.write(raw[row])
    outfile.close()

    outputFile = os.path.join(baseDirectory + '/' + inputType, 'supercontig/' + inputFile)
    outfile = open(outputFile,'w')
    outfile.write('##gff-version	3\n')
    outfile.write('##feature-ontology      so.obo\n')
    outfile.write('##attribute-ontology    gff3_attributes.obo\n') 
    for row in range(0,len(raw)):
        # For VEG supercontig
        m = re.match(r"KI5", string.strip(raw[row]))
        if m :
            a = re.search(r"(ToxoDB)\t(supercontig)", string.strip(raw[row]))
            if not a :
                b = re.search(r"(ToxoDB)\t(apicoplast_chromosome)", string.strip(raw[row]))
                if not b :
                    outfile.write(raw[row])
    outfile.close()

######################################
baseDirectory = '%s'%sys.argv[1]
inputType = '%s'%sys.argv[2]
inputFile = '%s'%sys.argv[3]

programCall = 'mkdir -p ' + baseDirectory + '/' + inputType + '/chromosome'
commands.getstatusoutput(programCall)
programCall = 'mkdir -p ' + baseDirectory + '/' + inputType + '/supercontig'
commands.getstatusoutput(programCall)
programCall = 'mkdir -p ' + baseDirectory + '/' + inputType + '/contig'
commands.getstatusoutput(programCall)

infile = open(baseDirectory + '/' + inputFile)
raw = infile.readlines()
infile.close()

if inputType == 'ME49':
    me49(raw)
if inputType == 'GT1':
    gt1(raw)
if inputType == 'VEG':
    veg(raw)









#####################################################################################################################################
## Examiner
#baseDirectory = '%s'%sys.argv[1]
#inputType = '%s'%sys.argv[2]
#inputFile = '%s'%sys.argv[3]
#
#examiner = GFFExaminer()
#in_handle = open(baseDirectory + '/' + inputFile)
#pprint.pprint(examiner.available_limits(in_handle))
#in_handle.close()








#####################################################################################################################################
## Uses GFF parser but can not get rid of annotation feature and have to output each feature
## This can be used after updating InterMine to 1.5 from 1.1
########################
### Requirement
### parseToxoDBGFF.py
### Uses GFF parser
########################################
##baseDirectory = '%s'%sys.argv[1]
##inputType = '%s'%sys.argv[2]
##inputFile = '%s'%sys.argv[3]
##
##programCall = 'mkdir ' + baseDirectory + '/' + inputType
##commands.getstatusoutput(programCall)
##
##in_handle = open(baseDirectory + '/' + inputFile)
##
##for seq_record in GFF.parse(in_handle):
##    # For ME49
##    m = re.match(r"TGME49_chr", seq_record.id)
##    if m :
##	newFile = os.path.join(baseDirectory + '/' + inputType, seq_record.id + '.gff')
##	outfile = open(newFile,'w')
##	GFF.write([seq_record], outfile)
##	outfile.close()
##
##    n = re.match(r"ABPA", seq_record.id)
##    if n :
##	newFile = os.path.join(baseDirectory + '/' + inputType, seq_record.id + '.gff')
##	outfile = open(newFile,'w')
##	GFF.write([seq_record], outfile)
##	outfile.close()
##	
##    o = re.match(r"tgme49_asmbl", seq_record.id)
##    if o :
##	newFile = os.path.join(baseDirectory + '/' + inputType, seq_record.id + '.gff')
##	outfile = open(newFile,'w')
##	GFF.write([seq_record], outfile)
##	outfile.close()	
##
##in_handle.close()








#####################################################################################################################################
## OLD
###read each line and only write TGME49_chr, TGGT1_chr or TGVEG_chr
##baseDirectory = '%s'%sys.argv[1]
##inputType = '%s'%sys.argv[2]
##inputFile = '%s'%sys.argv[3]
##
##infile = open(baseDirectory + '/' + inputFile)
##raw = infile.readlines()
##infile.close()
##
##outputFile = os.path.join(baseDirectory + '/' + inputFile + '.parsed')
##outfile = open(outputFile,'w')
##outfile.write('##gff-version	3\n')
##outfile.write('##feature-ontology      so.obo\n')
##outfile.write('##attribute-ontology    gff3_attributes.obo\n')
##for row in range(0,len(raw)):
##	p = re.search(r"ToxoDB	chromosome", string.strip(raw[row]))
##	if not p :
##		# for ME49
##		m = re.match(r"TGME49_chr", string.strip(raw[row]))
##		if m :
##		    outfile.write(raw[row])
##		# for GT1
##		n = re.match(r"TGGT1_chr", string.strip(raw[row]))
##		if n :
##		    outfile.write(raw[row])
##		# for VEG
##		o = re.match(r"TGVEG_chr", string.strip(raw[row]))
##		if o :
##		    outfile.write(raw[row])
##outfile.close()
##
##programCall = 'mkdir ' + baseDirectory + '/' + inputType
##commands.getstatusoutput(programCall)
##
##programCall = 'mv ' + baseDirectory + '/' + inputFile + ' ' + baseDirectory + '/' + inputType + '/' + inputFile + '.old'
##commands.getstatusoutput(programCall)
##
##programCall = 'mv ' + outputFile + ' ' + baseDirectory + '/' + inputType + '/' + inputFile
##commands.getstatusoutput(programCall)