#!/usr/bin/env sh

HOSTNAME="biosanMBPr"
GPG_KEY_FINGERPRINT=""
PASS_GIT_URL=""
ALFRED_PREF_FOLDER=""

#######################################################
## This is a configuration script.                   ##
## Make attention! It can mess your macOS installion ##
#######################################################


############### System settings ###############

echo "Configuring macOS settings, built-in app, CLI tools, and other Apps"
echo "(press any key to continue, Ctrl-C to abort)"
read TEMP


#############
## Generic ##
#############

# Set hostname
m hostname "$HOSTNAME"

# Disable boot sound effects
#nvram SystemAudioVolume=" "

## Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner: Show application windows
defaults write com.apple.dock wvous-tl-corner -int 3
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner: Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner: Put display to sleep
defaults write com.apple.dock wvous-bl-corner -int 10
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner: start screen saver
defaults write com.apple.dock wvous-br-corner -int 12
defaults write com.apple.dock wvous-br-modifier -int 0

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

### Network ###

# Turn Firewall on
m firewall enable


##############
## Menu Bar ##
##############

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Show full clock
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM  HH:mm:ss'
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# MenuBar items
defaults write com.apple.menuextra.textinput ModeNameVisible -bool false


############
## Finder ##
############

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSavePrint -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSavePrint2 -bool true

# Show all filename extensions
m finder showextensions YES

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show path bar
m finder showpath YES

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false


##########
## Dock ##
##########

# Hide the Dock
m dock autohide YES

# Set the icon size of Dock items to 42 pixels
defaults write com.apple.dock tilesize -int 42

# Change dock position to left
m dock position LEFT


###################
## Built-in Apps ##
###################

### Activity Monitor ###
# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5
# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

### Safari ###
# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true


###############
## CLI Tools ##
###############

### GPG ###
# Import my GPG public key from Keybase
# NOTE: old "less secure" method: gpg --recv-keys "$GPG_KEY_FINGERPRINT"
curl https://keybase.io/biosan/key.asc | gpg --import
# Import my GPG key stubs from the smartcard
echo "Importing private key stubs from the smartcard"
echo "Insert the smartcard. Press any key to continue... (Ctrl-C to cancel)"
read TMP
gpg --card-status
# Set your key as ultemately trusted
#gpg --import-ownertrust <(echo "$GPG_KEY_FINGERPRINT:6:")
export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh # Temporary export to clone Pass repo

### Pass ###
# Clone my password store repository
echo "Setting up your password store repository"
if [ -d ~/.password-store ]; then
    echo "A .password-store folder is already inside your home directory"
else
    echo "Cloning repository using SSH"
    echo "Insert the smartcard. Press any key to continue... (Ctrl-C to cancel)"
    read TMP
    git clone "$PASS_GIT_URL" ~/.password-store
fi


##########
## Apps ##
##########

### Karabiner/Karabiner-Elements
# Restart Karabiner-Elements to load new configuration file
launchctl kickstart -k "gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server"

### Dropbox
# Link notes stored in Dropbox to my home folder
ln -sf ~/Dropbox/Notes ~/Notes
ln -sf ~/Dropbox/Uni ~/Uni

### Alfred2
# Set Alfred sync folder
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "$ALFRED_PREF_FOLDER"


#############
## THE END ##
#############

echo "Configuration finished"
echo "Please restart your Mac"

