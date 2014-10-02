package DataDownloader::Source::ToxoDBGFF;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase VERSION of three different Toxoplasma gondii strain's genome annotations
# Strains --- ME49, VEG and GT1
# http://toxodb.org/common/downloads/Current_Release/

use constant {
    VERSION => '11.0',    
};

use constant {
    TITLE  => 'ToxoDBGFF',
    DESCRIPTION => "Toxoplasma gondii genome annotation from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/gff',
    SOURCES => [{
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiME49.gff',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiME49/gff/data',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiGT1.gff',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiGT1/gff/data',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiVEG.gff',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiVEG/gff/data',
    }],
};

1;