import os, sys, re, string, commands

######################
# Requirement
# parseToxoDBGFF.py 
######################################
#read each line and only write TGME49_chr, TGGT1_chr or TGVEG_chr

baseDirectory = '%s'%sys.argv[1]
inputType = '%s'%sys.argv[2]
inputFile = '%s'%sys.argv[3]

infile = open(baseDirectory + '/' + inputFile)
raw = infile.readlines()
infile.close()

outputFile = os.path.join(baseDirectory + '/' + inputFile + '.parsed')
outfile = open(outputFile,'w')
outfile.write('##gff-version	3\n')
outfile.write('##feature-ontology      so.obo\n')
outfile.write('##attribute-ontology    gff3_attributes.obo\n')
for row in range(0,len(raw)):
	p = re.search(r"ToxoDB	chromosome", string.strip(raw[row]))
	if not p :
		# for ME49
		m = re.match(r"TGME49_chr", string.strip(raw[row]))
		if m :
		    outfile.write(raw[row])
		# for GT1
		n = re.match(r"TGGT1_chr", string.strip(raw[row]))
		if n :
		    outfile.write(raw[row])
		# for VEG
		o = re.match(r"TGVEG_chr", string.strip(raw[row]))
		if o :
		    outfile.write(raw[row])
outfile.close()

programCall = 'mkdir ' + baseDirectory + '/' + inputType
commands.getstatusoutput(programCall)

programCall = 'mv ' + baseDirectory + '/' + inputFile + ' ' + baseDirectory + '/' + inputType + '/' + inputFile + '.old'
commands.getstatusoutput(programCall)

programCall = 'mv ' + outputFile + ' ' + baseDirectory + '/' + inputType + '/' + inputFile
commands.getstatusoutput(programCall)