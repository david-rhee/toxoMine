import os, sys, string, re, commands

######################
# Requirement
# parseUniprot.py 
######################################
######################################
#read each line until <name type="ORF" is read
#continue to read the same line and replace matching ME49 or VEG or GT
#and replace the <name type="ORF" with type='ME49" or "VEG" or "GT"
#def replaceGeneNameUniprot(inputFile, outputFile) :
#    infile = open(inputFile)
#    raw = infile.readlines()
#    infile.close()
#
#    outfile = open(outputFile,'w')
#
#    for row in range(0,len(raw)) :
#        m = re.search(r'<name type="ORF"', string.strip(raw[row]))
#        if m :
#            n = re.search(r'>(TGME49_[0-9]*)<', string.strip(raw[row]))
#            if n :
#                outfile.write(re.sub(r'ORF', 'TGME49', string.strip(raw[row])))
#                outfile.write("\n")
#            else :
#                o = re.search(r'>(TGVEG_[0-9]*)<', string.strip(raw[row]))
#                if o :
#                    outfile.write(re.sub(r'ORF', 'TGVEG', string.strip(raw[row])))
#                    outfile.write("\n")
#                else :
#                    p = re.search(r'>(TGGT1_[0-9]*)<', string.strip(raw[row]))
#                    if p :
#                        outfile.write(re.sub(r'ORF', 'TGGT1', string.strip(raw[row])))
#                        outfile.write("\n")
#                    else :
#                        outfile.write(raw[row])
#        else :
#            z = re.search(r'<dbReference type="EuPathDB"', string.strip(raw[row]))
#            if z :
#                outfile.write(re.sub(r'id="ToxoDB:', 'id="', string.strip(raw[row])))
#                outfile.write("\n")
#            else :
#                outfile.write(raw[row])
#
#    outfile.close()
#    programCall = 'mv ' + inputFile + ' ' + inputFile + '.old'
#    commands.getstatusoutput(programCall)
#    programCall = 'mv ' + outputFile + ' ' + inputFile
#    commands.getstatusoutput(programCall)
#
#inputFile = '%s'%sys.argv[1]
#outputFile = os.path.join(inputFile + '.parsed')
#replaceGeneNameUniprot(inputFile, outputFile)
#
#inputFile = '%s'%sys.argv[2]
#outputFile = os.path.join(inputFile + '.parsed')
#replaceGeneNameUniprot(inputFile, outputFile)


#replace
def replaceGeneNameUniprot(inputFile, outputFile) :
    infile = open(inputFile)
    raw = infile.readlines()
    infile.close()

    outfile = open(outputFile,'w')

    for row in range(0,len(raw)) :
        z = re.search(r'<dbReference type="EuPathDB"', string.strip(raw[row]))
        if z :
            outfile.write(re.sub(r'id="ToxoDB:', 'id="', string.strip(raw[row])))
            outfile.write("\n")
        else :
            outfile.write(raw[row])

    outfile.close()
    programCall = 'mv ' + inputFile + ' ' + inputFile + '.old'
    commands.getstatusoutput(programCall)
    programCall = 'mv ' + outputFile + ' ' + inputFile
    commands.getstatusoutput(programCall)

inputFile = '%s'%sys.argv[1]
outputFile = os.path.join(inputFile + '.parsed')
replaceGeneNameUniprot(inputFile, outputFile)

inputFile = '%s'%sys.argv[2]
outputFile = os.path.join(inputFile + '.parsed')
replaceGeneNameUniprot(inputFile, outputFile)