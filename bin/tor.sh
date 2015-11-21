#!/bin/bash

# See `networksetup -listallnetworkservices` for a list of available connections
INTERFACE=Wi-Fi

networksetup -setsocksfirewallproxy $INTERFACE 127.0.0.1 9050 off
networksetup -setsocksfirewallproxystate $INTERFACE on
tor
networksetup -setsocksfirewallproxystate $INTERFACE off
