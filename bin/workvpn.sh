#!/bin/bash

#
# Create an account 'Work_VPN' in macOS keychain before using this script!
#


VPN="Work_VPN"

get_passwd() {
    security 2>&1 > /dev/null find-generic-password -ga $VPN \
        | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

echo "Using VPN service: ${VPN}"

if scutil --nc status "${VPN}" | grep -q Connected; then
    echo "VPN service is running already. Stopping now..."
    scutil --nc stop "${VPN}"
    echo "VPN service stopped."
else
    echo "Starting VPN service..."
    scutil --nc start "${VPN}"
    echo "Fetching VPN credentials from keychain account ${VPN}..."
    sleep 2.7
    osascript -e "tell application \"System Events\" to keystroke \"$(get_passwd)\""
    osascript -e "tell application \"System Events\" to keystroke return"
    sleep 2
fi

exit
