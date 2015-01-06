#!/usr/bin/env bash

# A lot of these things have been taken from the variuos places on the web, most
# from here: https://github.com/mathiasbynens/dotfiles/blob/master/.osx and
# https://bitbucket.org/sjl/dotfiles/raw/603bb1ae9da27c6e08ab115df1cb5d8f6a1442c3/osx.sh

# Set the colors
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

# Reset text attributes to normal without clearing the screen
alias Reset="tput srg0"

# Color-echo
# arg $1 = message; arg $2 = color
cecho() {
    echo "$2$1"
    Reset # Reset colors
    return
}

# Set continue to false by default
CONTINUE=false

echo ""
cecho "***********************************" $red
cecho "* READ THIS SCRIPT BEFORE RUNNING *" $red
cecho "***********************************" $red
echo ""

echo ""
cecho "Have you read through the script you're about to run and " $red
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
case $response in
    [yY]) CONTINUE=true
        break
        ;;
    *) break
        ;;
esac

if ! $CONTINUE; then
    cecho "Please read through the script, it only takes a few minutes" $red
    exit
fi

# Here we go...
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# General UX/UI settings

echo ""
echo "Would you like to set your computer name? (y/n)"
read -r response
case $response in
    [yY])
        echo "What would you like it to be?"
        read COMPUTER_NAME
        sudo scutil --set ComputerName $COMPUTER_NAME
        sudo scutil --set HostName $COMPUTER_NAME
        sudo scutil --set LocalHostName $COMPUTER_NAME
        sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
        break
        ;;
    *) break
        ;;
esac

echo ""
echo "Hide the TimeMachine, Volume, User, and bluetooth icons? (y/n)"
read -r response
case $response in
    [yY])
        for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
            defaults write "$(domain)" dontAutoload -array \
                "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
                "/System/Library/CoreServices/Menu Extras/Volume.menu" \
                "/System/Library/CoreServices/Menu Extras/User.menu"
        done

        defaults write com.apple.systemuiserver menuExtras -array \
            "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
            "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
            "/System/Library/CoreServices/Menu Extras/Battery.menu" \
            "/System/Library/CoreServices/Menu Extras/Clock.menu"
        break
        ;;
    *) break
        ;;
easc


echo "Disable notifications center"
sudo defaults write /System/Library/LaunchAgents/com.apple.notificationcenterui
KeepAlive -bool False

echo "Kill affected apps"
killall NotificationCenter

echo "Disable dashboard"
defaults write com.apple.dashboard mcx-disabled -boolean true
killall Dock

echo "You need to log out and log back to see changes."
