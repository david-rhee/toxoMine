import os, sys, re, string, commands
from datetime import datetime
from datetime import date

####################################################################################################################################
# Parses Gene information

def GO(raw, row, outfile, gene_id, taxon_id):
    #move down one row
    row+=1
    for row_here in range(row+1,len(raw)):
	a = re.match(r"(\n|\r)", raw[row_here])
	if a:
	    break;
	else:
	    tmpString = string.strip(raw[row_here])
	    go_id, ontology, go_term_name, source, ec, lec = tmpString.split('\t')
        if ontology != '':
            #outfile.write(source + '\t') # DB required
            outfile.write('ToxoDB\t') # DB required
            outfile.write(gene_id + '\t') # DB ID required
            outfile.write(gene_id + '\t') # DB symbol required
            outfile.write('\t') # Qualifier optional
            outfile.write(go_id + '\t') # GO ID required
            outfile.write('ToxoDB:' + gene_id + '\t') # DB:reference required
            outfile.write(ec + '\t') # Evidence Code required
            outfile.write('\t') # With  or From optional
            if ontology == 'Biological Process':
                outfile.write('P\t') # Aspect required
            elif ontology == 'Molecular Function':
                outfile.write('F\t') # Aspect required
            elif ontology == 'Cellular Component':
                outfile.write('C\t') # Aspect required
            outfile.write('\t') # DB name optional
            outfile.write('\t') # DB synonym optional
            outfile.write('gene\t') # DB type required
            outfile.write('taxon:' + taxon_id + '\t') # taxon required
            d = datetime.now()
            outfile.write(d.strftime("%Y%m%d") + '\t') # date required
            outfile.write(source + '\t') # assigned by required
            outfile.write('\t') # annotation extension optional
            outfile.write('\n') # gene product id optional

def each_gene(raw, row, outfile, gene_id, taxon_id):
    exit_row = row
    for row_here in range(row+1,len(raw)):
	a = re.match(r"TABLE: GO Terms", string.strip(raw[row_here]))
	if a:
	    GO(raw, row_here, outfile, gene_id, taxon_id)
	b = re.match(r"(Gene ID:) (\S*)", string.strip(raw[row_here]))
	if b :
	    exit_row = row_here
	    break;
    return exit_row

baseDirectory = '%s'%sys.argv[1]
inputType = '%s'%sys.argv[2]
taxonID = '%s'%sys.argv[3]
inputFile = '%s'%sys.argv[4]
outputFileName = '%s'%sys.argv[5]

programCall = 'mkdir ' + baseDirectory + '/' + inputType
commands.getstatusoutput(programCall)

infile = open(baseDirectory + '/' + inputFile)
raw = infile.readlines()
infile.close()

outputFile = os.path.join(baseDirectory + '/' + inputType, outputFileName)
outfile = open(outputFile,'w')
outfile.write('!gaf-version: 2.0\n')
for row in range(0,len(raw)):
    a = re.match(r"(Gene ID:) (\S*)", string.strip(raw[row]))
    if a :
	#print a.group(2)
	row = each_gene(raw, row, outfile, a.group(2), taxonID)
outfile.close()