package DataDownloader::Source::OrthoMCLDB;

use Moose;
extends 'DataDownloader::Source::ABC';

# Relase 5.0 of OrthoMCLDB

use constant {
    TITLE  => 'OrthoMCLDB',
    DESCRIPTION => "OrthoMCLDB Homologues",
    SOURCE_LINK => "http://orthomcl.org/common/downloads",
    SOURCE_DIR => 'orthomcldb',
    SOURCES => [{
        FILE   => 'groups_OrthoMCL-5.txt.gz',
        SERVER => 'http://orthomcl.org/common/downloads/release-5',
        EXTRACT => 1,
    }],
};

1;