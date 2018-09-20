import socket
import sys
import os
import re

server_address = './uds_socket'

# Make sure the socket does not already exist
try:
    os.unlink(server_address)
except OSError:
    if os.path.exists(server_address):
        raise

# Create a UDS socket
sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

# Bind the socket to the port
print >>sys.stderr, 'starting up on %s' % server_address
sock.bind(server_address)

# Listen for incoming connections
sock.listen(1)

def parse_ssh(cmd):
    #store for parsed values
    hash = {}

    #remove single character flags
    flags = '|'.join(list("46AaCfGgKkMNnqsTtVvXxYy"))
    cmd = re.sub(r"\s+-[%(flags)s]*[%(flags)s][%(flags)s]*" % locals(),'',cmd)
    
    #remove options
    opts = '|'.join(list("bBcDEeFIiJLlmOoQRSWw"))
    cmd = re.sub(r"\s+-[%s]\s+.*?(?=\s|$)" % opts,'',cmd)


    #extract port number if used m.group(1)
    def rep_port(m,hash=hash):
        hash['port'] = m.group(1)
        return ''
    cmd = re.sub(r"\s+-p\s+(.*?)(?=\s|$)", rep_port ,cmd)

    #drop ssh command
    cmd = re.sub(r'ssh\s+','',cmd)

    #take only host and username part not any command passed to ssh
    host = cmd.split(' ',1)[0]

    
    print host



    return hash

while True:
    print >>sys.stderr,  parse_ssh("ssh -i ~/.ssh/id_rsa -4CfGTy -p 232 scott@host.com")
    # Wait for a connection
    print >>sys.stderr, 'waiting for a connection'
    connection, client_address = sock.accept()
    try:
        print >>sys.stderr, 'connection from', client_address

        # Receive the data in small chunks and retransmit it
        while True:
            data = connection.recv(16)
            if data:
                size = int(data.strip())
                if size > 200:
                    connection.sendall("BIG")
                else:
                    connection.sendall("SMALL")
            else:
                print >>sys.stderr, 'no more data from', client_address
                break
            
    finally:
        # Clean up the connection
        connection.close()