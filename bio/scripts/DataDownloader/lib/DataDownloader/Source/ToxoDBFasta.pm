package DataDownloader::Source::ToxoDBFasta;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase VERSION of three different Toxoplasma gondii strain's FASTA sequence
# Strains --- ME49, VEG and GT1
# http://toxodb.org/common/downloads/Current_Release/

use constant {
    VERSION => '11.0',    
};

use constant {
    TITLE  => 'ToxoDBFasta',
    DESCRIPTION => "Toxoplasma gondii sequence from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/fasta',
    SOURCES => [{
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiME49_Genome.fasta',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiME49/fasta/data',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiGT1_Genome.fasta',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiGT1/fasta/data',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiVEG_Genome.fasta',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiVEG/fasta/data',
    }],
};

1;