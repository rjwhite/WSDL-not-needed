#!/usr/bin/env perl

use strict;
use warnings;
use SOAP::Transport::HTTP;
use version; our $VERSION = qv('1.0.0');

# dynamically load any modules requested from this directory
my $module_dir = '/usr/local/SOAP-WS' ;

SOAP::Transport::HTTP::CGI
    ->dispatch_to( $module_dir )
    ->handle;

1;
