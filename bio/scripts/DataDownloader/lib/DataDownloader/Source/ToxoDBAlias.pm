package DataDownloader::Source::ToxoDBAlias;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase VERSION of three different Toxoplasma gondii strain's gene alias
# Strains --- ME49, VEG and GT1
# http://toxodb.org/common/downloads/Current_Release/

use constant {
    VERSION => '11.0',    
};

use constant {
    TITLE  => 'ToxoDBAlias',
    DESCRIPTION => "Toxoplasma gondii gene id aliases from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/alias',
    SOURCES => [{
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiME49_GeneAliases.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiME49/txt/',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiGT1_GeneAliases.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiGT1/txt/',
    },
    {
        FILE   => 'ToxoDB-'.VERSION.'_TgondiiVEG_GeneAliases.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-'.VERSION.'/TgondiiVEG/txt/',
    }],
};

1;