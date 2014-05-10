package TestWS ;

use strict ;
use warnings ;
use Exporter;

BEGIN {
    use Exporter ;
    our ( @ISA, @EXPORT );

    @ISA = qw( Exporter );
    @EXPORT = qw( TestWS );
}

sub fetchdata {
    my $either      = shift ;   # instance or class
    my $filename    = shift ;

    die SOAP::Fault
        ->faultstring( "No such file: $filename" )
        ->faultcode( "Err-01" ) if ( ! -f $filename ) ;

    # get the mode and size of the file in bytes
    my $mode        = (stat($filename))[2] ;
    my $size        = (stat($filename))[7] ;

    # create SOAP data structures with XML tag to use
    my $mode_data = SOAP::Data
        ->name( "Mode" )
        ->value( $mode ) ;

    my $size_data = SOAP::Data
        ->name( "Size" )
        ->value( $size ) ;

    return( $mode_data, $size_data  );
}

1;
