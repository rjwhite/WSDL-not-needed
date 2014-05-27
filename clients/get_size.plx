#!/usr/bin/env perl

# Get the file mode and size, in bytes, of a filename via SOAP call

use warnings;
use strict;
use SOAP::Lite ;

my $filename    = $ARGV[0] || '/etc/motd';
my $ip_address  = '192.168.8.32' ;
my $port_number = '8080' ;
my $service     = 'TestWS' ;    # module name
my $endpoint    = 'SoapWS' ;    # see Apache config
my $method      = 'fetchdata' ; # method in service

my $response = SOAP::Lite
    ->uri( "http://${ip_address}:${port_number}/${service}" )
    ->proxy( "http://${ip_address}:${port_number}/${endpoint}" )
    ->$method( "$filename" );

if ( $response->fault ) {
    print {*STDERR} "You got a error dude!:\n" .
        "\tFault code:\t" . $response->faultcode . "\n" .
        "\tFault string:\t" . $response->faultstring . "\n";
    exit 1;
}

my @results = $response->paramsall();
my $mode = $results[0];
my $mode_octal = sprintf( "%o", $mode ) ;
my $size = $results[1];
print "$filename is mode ${mode_octal} and ${size} bytes\n";

exit 0;
