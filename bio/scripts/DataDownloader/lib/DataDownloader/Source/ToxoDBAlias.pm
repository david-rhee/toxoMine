package DataDownloader::Source::ToxoDBAlias;

use Moose;
extends 'DataDownloader::Source::ABC';

use constant {
    TITLE  => 'ToxoDBAlias',
    DESCRIPTION => "Toxoplasma gondii gene id aliases from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/alias',
    SOURCES => [{
        FILE   => 'ToxoDB-10.0_TgondiiME49_GeneAliases.txt',
        SERVER => 'http://toxodb.org/common/downloads/release-10.0/TgondiiME49/txt/',
    }],
};

1;