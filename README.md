
# One config to rule them all 💍👨‍💻🔥

This repo contains my dotfiles, all the config files, scripts, and instructions to setup a new machine.

Most of the settings and programs are managed with [home-manager](https://github.com/nix-community/home-manager).

[Nix](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager) makes everything stable and easy to reproduce.

> **macOS**
>
> My daily machine is a Mac, and this requires some special attention to some settings that could not be managed with Nix and home-manager directly.


## Installation on macOS

1. Install XCode CLI tools
    ```
    xcode-select --install
    ```

1. Install Nix
    ```
    sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
    ```
1. Add home-manager and unstable channels
    ```
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
    nix-channel --update
    export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
    ```
1. Install home-manager
    ```
    nix-shell '<home-manager>' -A install
    ```
1. Clone this repo inside `~/.config/nixpkgs`
    ```
    git clone https://github.com/biosan/dotfiles ~/.config/nixpkgs
    ```
1. Setup home-manager configuration (install and configure programs)
    ```
    home-manager switch
    ```

1. Install Homebrew
    ```
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ```
1. Install apps from Homebrew
    ```
    brew bundle --file ~/.config/nixpkgs/config/macos
    ```
1. Setup some macOS-specific configuration
    ```
    sh "~/.config/nixpkgs/config/macos/settings.sh"
    ```


### Post installation steps

1. Import GPG public keys
    ```
    curl https://keybase.io/biosan/key.asc | gpg --import
    ```
1. Insert YubiKey and import GPG secret key stubs
    ```
    gpg --card-status
    ```
1. Change dotfiles remote from HTTPS to SSH
    ```
    cd ~/.config/nixpkgs
    git remote set-url origin git@github.com:biosan/dotfiles.git
    ```
1. Clone `pass` repository using SSH
    ```
    git clone <REPO_URL> ${PASSWORD_STORE_DIR}
    ```


#### Other macOS stuff

1. Install profile files for mail, DNS, VPN, etc.
1. Login into
    - BitWarden
    - Firefox Sync
    - Dropbox
    - Todoist
    - OmniFocus
1. Enable Night Shift
1. Insert Alfred license
1. Organize menu bar items with Dozer



## ToDo

### General

- [ ] `pass` repo initial setup
- [ ] Homebrew token in private `.envrc` file
- [ ] Auto install profiles for mail, dns, vpn, etc. with `profiles -I -F "<PATH>"`
- [ ] Enable *Night Shift*
- [ ] Import and trust GPG keys
- [ ] Enable snap-to-grid for icons on the desktop and in other icon views
- [ ] Configure Dozer
- [ ] Configure Amethyst

### Things to setup declaratevely with Nix/Home-Manager

- [ ] macOS configuration/settings/profiles (using [nix-darwin](https://github.com/LnL7/nix-darwin))
- [ ] Switch to [flakes](https://nixos.wiki/wiki/Flakes) to improve reproducibility and UX
- [ ] Complete system-in-a-container (even a VM will be fine) with full NixOS (ISO, cloud image, docker container)
- [ ] Import and trust GPG keys
- [ ] Clone `pass` repo

