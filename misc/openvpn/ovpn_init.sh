#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Pass public IP address"
    exit 1
fi

PUBLIC_IP=$1

# init configuration for the OpenVPN
docker-compose run --rm openvpn ovpn_genconfig -u udp://$PUBLIC_IP

echo "Initialyzing PKI. Type any pass phrase and name for your certificate."
docker-compose run --rm openvpn ovpn_initpki

echo "Starting OpenVPN server process..."
docker-compose up -d openvpn
