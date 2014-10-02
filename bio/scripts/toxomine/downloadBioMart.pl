#!/usr/bin/perl

# This perl API representation is only available for configuration versions >=  0.5 
use strict;
use BioMart::Initializer;
use BioMart::Query;
use BioMart::QueryRunner;

my $confFile;

# vars from the command line
my ( $system, $option ) = @ARGV;

if ($system eq 'MBP') {
    $confFile = '/Users/drhee1/perl5/biomart-perl/conf/biomart_ensembl_mart_75_registry.xml';
} elsif ($system eq 'HPC') {
    $confFile = '/home/toxouser/perl5/biomart-perl/conf/biomart_ensembl_mart_75_registry.xml';
} elsif ($system eq 'Rhea') {
    $confFile = '/home/david/perl5/biomart-perl/conf/biomart_ensembl_mart_75_registry.xml';
}

#
# NB: change action to 'clean' if you wish to start a fresh configuration  
# and to 'cached' if you want to skip configuration step on subsequent runs from the same registry
#
my $action='cached';
my $initializer = BioMart::Initializer->new('registryFile'=>$confFile, 'action'=>$action);
my $registry = $initializer->getRegistry;

if ($option eq 'FlyBase') {
    fly_base();
} elsif ($option eq 'Human') {
    human();
} elsif ($option eq 'MGI' ) {
    mgi();
} elsif ($option eq 'RGD') {
    rgd();
} else {
    print 'No or wrong option.'
}

############################## FlyBase ##########################
sub fly_base {
    my $query = BioMart::Query->new('registry'=>$registry,'virtualSchemaName'=>'default');
    $query->setDataset("dmelanogaster_gene_ensembl");
    $query->addAttribute("flybase_gene_id");
    $query->addAttribute("ensembl_gene_id");
    $query->addAttribute("ensembl_peptide_id");
    $query->formatter("TSV");
    
    open (BIOMART_OUT, ">/data1/toxomine/biomart/FlyBase.txt") or die "Can't open file for write\n";
    my $query_runner = BioMart::QueryRunner->new();
    $query_runner->execute($query);
    $query_runner->printResults(\*BIOMART_OUT);
    close BIOMART_OUT;
}

############################## Human ##########################
sub human {
    my $query = BioMart::Query->new('registry'=>$registry,'virtualSchemaName'=>'default');
    $query->setDataset("hsapiens_gene_ensembl");
    $query->addAttribute("ensembl_gene_id");
    $query->addAttribute("ensembl_peptide_id");
    $query->formatter("TSV");
    
    open (BIOMART_OUT, ">/data1/toxomine/biomart/HSAP.txt") or die "Can't open file for write\n";
    my $query_runner = BioMart::QueryRunner->new();
    $query_runner->execute($query);
    $query_runner->printResults(\*BIOMART_OUT);
    close BIOMART_OUT;
}

############################## Mouse ##########################
sub mgi {
    my $query = BioMart::Query->new('registry'=>$registry,'virtualSchemaName'=>'default');
    $query->setDataset("mmusculus_gene_ensembl");
    $query->addAttribute("mgi_id");
    $query->addAttribute("ensembl_gene_id");
    $query->addAttribute("ensembl_peptide_id");
    $query->formatter("TSV");
    
    open (BIOMART_OUT, ">/data1/toxomine/biomart/MGI.txt") or die "Can't open file for write\n";
    my $query_runner = BioMart::QueryRunner->new();
    $query_runner->execute($query);
    $query_runner->printResults(\*BIOMART_OUT);
    close BIOMART_OUT;
}
#####################################################################

############################## Rat ##########################
sub rgd {
    my $query = BioMart::Query->new('registry'=>$registry,'virtualSchemaName'=>'default');
    $query->setDataset("rnorvegicus_gene_ensembl");
    $query->addAttribute("rgd");
    $query->addAttribute("ensembl_gene_id");
    $query->addAttribute("ensembl_peptide_id");
    $query->formatter("TSV");
    
    open (BIOMART_OUT, ">/data1/toxomine/biomart/RGD.txt") or die "Can't open file for write\n";
    my $query_runner = BioMart::QueryRunner->new();
    $query_runner->execute($query);
    $query_runner->printResults(\*BIOMART_OUT);
    close BIOMART_OUT;
    
    open(BIOMART_IN, "/data1/toxomine/biomart/RGD.txt") or die("Could not open file.");
    my @results=<BIOMART_IN>;
    close BIOMART_IN;
    
    open (BIOMART_OUT, ">/data1/toxomine/biomart/RGD.txt") or die "Can't open file for write\n";
    foreach my $line (@results)  {
        print BIOMART_OUT "RGD:";
        print BIOMART_OUT $line;
    }
    close BIOMART_OUT;
}
#####################################################################
