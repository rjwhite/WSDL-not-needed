#!/usr/bin/env php
<?php
    $IP             = "192.168.8.32" ;
    $port           = "8080" ;
    $URL            = "/SoapWS" ;
    $service        = "TestWS" ;
    $filename       = "/etc/motd" ;

    try {
        $client = new SoapClient(
            null,
            array( 'location'   => "http://$IP:$port/$URL",
                   'uri'        => "http://$IP:$port/$service"
                )
            );
        $response = $client->fetchdata( $filename ) ;
    }
    catch( Exception $e )
    {
        echo $e->getMessage(), "\n" ;
        exit(1);
    }

    $mode = $response[ "Mode" ] ;
    $octal_mode = sprintf( "%o", $mode ) ;
    $size = $response[ "Size" ] ;
    echo $filename, " is mode ", $octal_mode, " and ", $size, " bytes\n"
?>
