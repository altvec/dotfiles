#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Pass client name"
    exit 1
fi

client_name=$1

echo "Building certificate for ${client_name}..."
docker-compose run --rm openvpn easyrsa build-client-full $client_name nopass

echo "Exporting certificate..."
docker-compose run --rm openvpn ovpn_getclient $client_name > $client_name_cert.ovpn

echo "Done."

