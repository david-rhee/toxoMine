package DataDownloader::Source::ToxoDBFasta;

use Moose;
extends 'DataDownloader::Source::ABC';

use constant {
    TITLE  => 'ToxoDBFasta',
    DESCRIPTION => "Toxoplasma gondii sequence from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/fasta',
    SOURCES => [{
        FILE   => 'ToxoDB-9.0_TgondiiME49_Genome.fasta',
        SERVER => 'http://toxodb.org/common/downloads/release-9.0/TgondiiME49/fasta/data',
    }],
};

1;