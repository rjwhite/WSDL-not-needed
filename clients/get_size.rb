#!/usr/bin/ruby -w

require 'soap/rpc/driver'

filename   = ARGV[0] || '/etc/motd'
NAMESPACE  = 'TestWS'
URL        = 'http://192.168.8.32:8080/SoapWS'

begin
    driver = SOAP::RPC::Driver.new(URL, NAMESPACE)

    # Add remote sevice methods
    driver.add_method('fetchdata', 'Filename' )

    # Call remote service methods
    values = driver.fetchdata( filename )
    mode = sprintf( "%o", values[0] )   # in octal

    puts "#{filename} is mode #{mode} and #{values[1]} bytes"
    
rescue => err
    puts err.message
end
