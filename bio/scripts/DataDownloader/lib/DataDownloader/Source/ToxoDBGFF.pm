package DataDownloader::Source::ToxoDBGFF;

use Moose;
extends 'DataDownloader::Source::ABC';

use constant {
    TITLE  => 'ToxoDBFasta',
    DESCRIPTION => "Toxoplasma gondii genome annotation from ToxoDB",
    SOURCE_LINK => "http://toxodb.org",
    SOURCE_DIR => 'toxodb/gff',
    SOURCES => [{
        FILE   => 'ToxoDB-9.0_TgondiiME49.gff',
        SERVER => 'http://toxodb.org/common/downloads/release-9.0/TgondiiME49/gff/data',
    }],
};

1;