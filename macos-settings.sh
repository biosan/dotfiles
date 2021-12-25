#!/usr/bin/env sh

#######################################################
## This is a configuration script.                   ##
## Make attention! It can mess your macOS installion ##
#######################################################


############### System settings ###############

echo "Configuring macOS settings."
echo "(press any key to continue, Ctrl-C to abort)"
read TEMP

if ! command -v m &> /dev/null
then
    echo "`m-cli` could not be found"
    exit
fi

#############
## Generic ##
#############

### Network ###

# Turn Firewall on
m firewall enable


############
## Finder ##
############

# Show all filename extensions
m finder showextensions YES

# Show path bar
m finder showpath YES


##########
## Dock ##
##########

# Hide the Dock
m dock autohide YES

# Change dock position to left
m dock position LEFT

# Remove all items from Dock
m dock prune


#############
## THE END ##
#############

echo "Configuration finished"
echo "Please restart your Mac"
