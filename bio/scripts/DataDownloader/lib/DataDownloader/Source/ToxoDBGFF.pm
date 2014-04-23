package DataDownloader::Source::ToxoDBGFF;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase 10.0 of three different Toxoplasma gondii strain's genome annotations
# Strains --- ME49, VEG and GT1
# http://toxodb.org/common/downloads/Current_Release/

use constant {
    TITLE  => 'ToxoDBGFF',
    DESCRIPTION => "Toxoplasma gondii genome annotation from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/gff',
    SOURCES => [{
        FILE   => 'ToxoDB-10.0_TgondiiME49.gff',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiME49/gff/data',
    },
    {
        FILE   => 'ToxoDB-10.0_TgondiiGT1.gff',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiGT1/gff/data',
    },
    {
        FILE   => 'ToxoDB-10.0_TgondiiVEG.gff',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiVEG/gff/data',
    }],
};

1;