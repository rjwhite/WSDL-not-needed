#!/usr/bin/env python

from SOAPpy import SOAPProxy
import SOAPpy.Types ;
import sys

ip          = '192.168.8.32'
port        = '8080'
service     = 'TestWS'      # module name
endpoint    = 'SoapWS'      # see Apache config
method      = 'fetchdata'
filename    = '/etc/motd'

url_prefix = 'http://' + ip + ':' + port + '/'
url        = url_prefix + endpoint
urn        = url_prefix + service
action     = urn + '#' + method

server = SOAPProxy( url, namespace=urn, soapaction=action )
try:
    result = server.fetchdata( filename )
except SOAPpy.Types.faultType, e:
    print e
    sys.exit(1)
except:
    print "Unexpected error:", sys.exc_info()[0]
    sys.exit(2)

print "{0} is mode {1:o} and {2:d} bytes".format(
    filename, result[0], result[1] ) 

sys.exit(0)
