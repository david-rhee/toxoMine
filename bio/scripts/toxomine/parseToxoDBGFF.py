import os, sys, re, string, commands

######################
# Requirement
# parseToxoDBGFF.py 
######################################
#read each line and only write TGME49_chr

inputFile = '%s'%sys.argv[1]
infile = open(inputFile)
raw = infile.readlines()
infile.close()

outputFile = os.path.join(inputFile + '.parsed')
outfile = open(outputFile,'w')
outfile.write('##gff-version	3\n')
outfile.write('##feature-ontology      so.obo\n')
outfile.write('##attribute-ontology    gff3_attributes.obo\n')
for row in range(0,len(raw)):
	m = re.match(r"TGME49_chr", string.strip(raw[row]))
	if m :
            outfile.write(raw[row])
outfile.close()

programCall = 'mv ' + inputFile + ' ' + inputFile + '.old'
commands.getstatusoutput(programCall)
programCall = 'mv ' + outputFile + ' ' + inputFile
commands.getstatusoutput(programCall)