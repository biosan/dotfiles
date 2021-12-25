
# One config to rule them all 💍👨‍💻🔥

This repo contains my dotfiles, all the config files, scripts, and instructions to setup a new Mac.

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

1. Install Nix (a reboot could be necessary)
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
1. Clone this repo inside `~/.config/nixpkgs` (must remove default nixpkgs before cloning)
    ```
    rm -r ~/.config/nixpkgs
    git clone https://github.com/biosan/dotfiles ~/.config/nixpkgs
    ```
1. Setup home-manager configuration (install and configure programs)
    *NOTE: Takes a loooong time*
    ```
    home-manager switch
    ```

1. Install Homebrew
    ```
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ```
1. Install apps from Homebrew
    > NOTEs:
    >   - Takes a **loooong** time
    >   - **Will ask for password a lot of times...**
    ```
    brew bundle --verbose --file ~/.config/nixpkgs/config/macos/Brewfile
    ```
1. Setup some macOS-specific configuration
    ```
    sh ~/.config/nixpkgs/config/macos/settings.sh
    ```


### Post installation steps

1. Change dotfiles remote from HTTPS to SSH
    ```
    cd ~/.config/nixpkgs
    git remote set-url origin git@github.com:biosan/dotfiles.git
    ```


#### Other macOS stuff

1. Install profile files for mail, DNS, VPN, etc.
1. Login into
    - BitWarden
    - Firefox Sync
    - Todoist
    - OmniFocus
    - VSCode
    - JetBrains Toolbox
1. Enable Night Shift
1. [Download](https://store.serif.com/en-gb/account/downloads/) (login needed), install and register Affinity Photo
1. Stuff to start at login:
    - Amethyst
    - Karabiner
1. Setup Firefox:
    - Login into Pocket
    - Set history cleaner to 7 days
    - Add container tabs for Google, Work, and AdA
    - Enable compact style
    - Move every add-on icon to Overflow Menu except except for BitWarden
        *NOTE: Firefox "native" icons stays at default position (this stuff is synced)*
1. Enable Time Machine automatic backups (encrypted disk!) and enable *"Show Time Machine in menu bar"* option
1. Add *"U.S. International - PC"* to keyboard layouts and enable *"Show Input menu in menu bar"* option
1. Setup [Amethyst](https://github.com/ianyh/Amethyst)
   - Enable *Window Margins* and set it to 5px
   - Set *Screen Padding* to 5px (top, left, bottom, right)
   - Enable *Swap windows using mouse* and *Resize windows using mouse* (mouse tab)
1. Right-click on desktop and enable "Stacks"



## ToDo

### General

- [ ] Homebrew token in private `.envrc` file
- [ ] Auto install profiles for mail, dns, vpn, etc. with `profiles -I -F "<PATH>"`
- [ ] Enable *Night Shift*
- [ ] Enable snap-to-grid for icons on the desktop and in other icon views
- [ ] Configure Dozer
- [ ] Configure Amethyst
- [ ] Configure Karabiner

### Things to setup declaratevely with Nix/Home-Manager

- [ ] macOS configuration/settings/profiles (using [nix-darwin](https://github.com/LnL7/nix-darwin)) (maybe it's not worth it for something to do only when a I get a new Mac...)
- [ ] Switch to [flakes](https://nixos.wiki/wiki/Flakes) to improve reproducibility and UX
- [ ] Complete system-in-a-container (even a VM will be fine) with full NixOS (ISO, cloud image, docker container)
- [ ] Handle secrets the right way
