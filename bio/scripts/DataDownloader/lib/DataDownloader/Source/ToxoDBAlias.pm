package DataDownloader::Source::ToxoDBAlias;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase 10.0 of three different Toxoplasma gondii strain's gene alias
# Strains --- ME49, VEG and GT1
# http://toxodb.org/common/downloads/Current_Release/

use constant {
    TITLE  => 'ToxoDBAlias',
    DESCRIPTION => "Toxoplasma gondii gene id aliases from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/alias',
    SOURCES => [{
        FILE   => 'ToxoDB-10.0_TgondiiME49_GeneAliases.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiME49/txt/',
    },
    {
        FILE   => 'ToxoDB-10.0_TgondiiGT1_GeneAliases.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiGT1/txt/',
    },
    {
        FILE   => 'ToxoDB-10.0_TgondiiVEG_GeneAliases.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiVEG/txt/',
    }],
};

1;