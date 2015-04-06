package DataDownloader::Source::ToxoDBTxt;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase VERSION of three different Toxoplasma gondii strain's txt files
# Strains --- ME49, VEG and GT1
# http://toxodb.org/common/downloads/Current_Release/

use constant {
    VERSION => '11.0',    
};

use constant {
    TITLE  => 'ToxoDBTxt',
    DESCRIPTION => "Toxoplasma gondii txt files from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/txt',
    SOURCES => [{
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiME49Gene.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiME49/txt',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiGT1Gene.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiGT1/txt',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiVEGGene.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiVEG/txt',
    }],
};

1;