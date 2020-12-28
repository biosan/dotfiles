#!/usr/bin/env sh

###
### Variables
###

DOTFILES_REPO="https://github.com/biosan/dotfiles"
DOTFILES_PATH="${HOME}/.config/nixpkgs"
#
# Select Nix/Home-Manager modules to "install"
# Complete list:
#  - common  --  basic stuff, CLI utilis for a basic server machine
#  - coding  --  programming runtimes, compilers, package managers & tools (for Python, JS/TS, Rust, Go & Java)
#  - gui     --  cross-platform GUI apps (alacritty, etc.)
#  - linux   --  Linux spefic apps and configs
#  - macos   --  macOS spefic apps and configs
#
# Pre-configured machines setups
#SERVER="common"
#DOCKER="common coding"
#DESKTOP="common coding gui linux"
#MACBOOK="common coding gui macos"
#
# Actual modules to be installed
#NIX_SETUP="${MACBOOK}"


#
#
#  /$$     /$$                                     /$$                 /$$ /$$
# |  $$   /$$/                                    | $$                | $$| $$
#  \  $$ /$$/   /$$$$$$  /$$   /$$        /$$$$$$$| $$$$$$$   /$$$$$$ | $$| $$
#   \  $$$$/   /$$__  $$| $$  | $$       /$$_____/| $$__  $$ |____  $$| $$| $$
#    \  $$/   | $$  \ $$| $$  | $$      |  $$$$$$ | $$  \ $$  /$$$$$$$| $$| $$
#     | $$    | $$  | $$| $$  | $$       \____  $$| $$  | $$ /$$__  $$| $$| $$
#     | $$    |  $$$$$$/|  $$$$$$/       /$$$$$$$/| $$  | $$|  $$$$$$$| $$| $$
#     |__/     \______/  \______/       |_______/ |__/  |__/ \_______/|__/|__/
#
#
#
#                        /$$
#                       | $$
#  /$$$$$$$   /$$$$$$  /$$$$$$          /$$$$$$   /$$$$$$   /$$$$$$$  /$$$$$$$
# | $$__  $$ /$$__  $$|_  $$_/         /$$__  $$ |____  $$ /$$_____/ /$$_____/
# | $$  \ $$| $$  \ $$  | $$          | $$  \ $$  /$$$$$$$|  $$$$$$ |  $$$$$$
# | $$  | $$| $$  | $$  | $$ /$$      | $$  | $$ /$$__  $$ \____  $$ \____  $$
# | $$  | $$|  $$$$$$/  |  $$$$/      | $$$$$$$/|  $$$$$$$ /$$$$$$$/ /$$$$$$$/
# |__/  |__/ \______/    \___/        | $$____/  \_______/|_______/ |_______/
#                                     | $$
#                                     | $$
#                                     |__/
#
#
#                                   ....
#                                 .'' .'''
# .                             .'   :
# \\                          .:    :
#  \\                        _:    :       ..----.._
#   \\                    .:::.....:::.. .'         ''.
#    \\                 .'  #-. .-######'     #        '.
#     \\                 '.##'/ ' ################       :
#      \\                  #####################         :
#       \\               ..##.-.#### .''''###'.._        :
#        \\             :--:########:            '.    .' :
#         \\..__...--.. :--:#######.'   '.         '.     :
#         :     :  : : '':'-:'':'::        .         '.  .'
#         '---'''..: :    ':    '..'''.      '.        :'
#            \\  :: : :     '      ''''''.     '.      .:
#             \\ ::  : :     '            '.      '      :
#              \\::   : :           ....' ..:       '     '.
#               \\::  : :    .....####\\ .~~.:.             :
#                \\':.:.:.:'#########.===. ~ |.'-.   . '''.. :
#                 \\    .'  ########## \ \ _.' '. '-.       '''.
#                 :\\  :     ########   \ \      '.  '-.        :
#                :  \\'    '   #### :    \ \      :.    '-.      :
#               :  .'\\   :'  :     :     \ \       :      '-.    :
#              : .'  .\\  '  :      :     :\ \       :        '.   :
#              ::   :  \\'  :.      :     : \ \      :          '. :
#              ::. :    \\  : :      :    ;  \ \     :           '.:
#               : ':    '\\ :  :     :     :  \:\     :        ..'
#                  :    ' \\ :        :     ;  \|      :   .'''
#                  '.   '  \\:                         :.''
#                   .:..... \\:       :            ..''
#                  '._____|'.\\......'''''''.:..'''
#
#

###
### Check if OS is macOS
###

if [[ "$(uname)" == "Darwin" ]]; then
    IS_MAC='yes';
else
    IS_MAC='';
fi



# Print current step function
print_step() {
    GREEN='\033[0;32m'
    RESET='\033[0m' # No Color
    printf "\n${GREEN}>>> ${1}${RESET}\n\n"
}



###
### Nix common stuff
###

### Install Nix
print_step "Install Nix"
if [ IS_MAC ] then;
    # NOTE: Maybe use an encrypted volume on macOS...
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
else
    sh <(curl -L https://nixos.org/nix/install)
fi

### Add unstable channell
print_step "Add unstable channel"
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update

### Install home-manager
print_step "Install home-manager"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install

### Clone dotfiles repo
print_step "Clone dotfiles repo"
rm -r "${DOTFILES_PATH}"
git clone "${DOTFILES_REPO}" "${DOTFILES_PATH}"

### Install home-manager config
print_step "Install home-manager config"
home-manager switch



###
### macOS specific stuff
###

if [ IS_MAC ]; then
    ### Install Homebrew
    print_step "Hey this is a Mac... let's install Homebrew"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";

    ### Install stuff from Homebrew
    print_step "Install apps from Homebrew"
    brew bundle --file "${DOTFILES_PATH}/config";

    ### Configure macOS
    print_step "Configure your Mac"
    sh ".${DOTFILES_PATH}/config/configure.macos.sh";
fi

################
### Restart! ###
################

print_step "Everything is setted up, now restart and enjoy your new machine!"

