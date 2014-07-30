package DataDownloader::Source::ToxoDBFasta;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase 10.0 of three different Toxoplasma gondii strain's FASTA sequence
# Strains --- ME49, VEG and GT1
# http://toxodb.org/common/downloads/Current_Release/

use constant {
    TITLE  => 'ToxoDBFasta',
    DESCRIPTION => "Toxoplasma gondii sequence from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/fasta',
    SOURCES => [{
        FILE   => 'ToxoDB-10.0_TgondiiME49_Genome.fasta',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiME49/fasta/data',
    },
    {
        FILE   => 'ToxoDB-10.0_TgondiiGT1_Genome.fasta',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiGT1/fasta/data',
    },
    {
        FILE   => 'ToxoDB-10.0_TgondiiVEG_Genome.fasta',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiVEG/fasta/data',
    }],
};

1;