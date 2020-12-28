
# One config to rule them all 💍👨‍💻🔥

This repo contains my dotfiles, all the config files, scripts, and instructions to setup a new machine.

Most of the settings and programs are managed with [home-manager](https://github.com/nix-community/home-manager).

[Nix](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager) makes everything stable and easy to reproduce.

> **macOS**
>
> My daily machine is a Mac, and this requires some special attention to some settings that could not be managed with Nix and home-manager directly.


## Installation

```sh
sh <(curl -L https://raw.githubusercontent.com/biosan/dotfiles/master/bootstrap.sh)
```

> **NOTE:**
> 
> The script will install my Macbook configuration by default.
> To modify it download it first then edit the first lines, then execute it.

This script will:

1. Install Nix
1. Install home-manager
1. Clone this repo inside `~/.config/nixpkgs`
1. Setup home-manager configuration (install and configure programs)
1. If on macOS:
    1. Install Homebrew
    1. Install apps from Homebrew
    1. Setup some macOS-specific configuration


### Post installation steps

1. Clone `pass` repository using SSH


#### macOS

1. Install profile files for mail, DNS, VPN, etc.
1. Login into
    - BitWarden
    - Firefox Sync
    - Dropbox
    - Todoist
    - OmniFocus
1. Enable Night Shift
1. Verify Alfred license
1. Organize menu bar items with Dozer



## ToDo

### General

- [ ] `pass` repo initial setup
- [ ] Homebrew token in private `.envrc` file
- [ ] Auto install profiles for mail, dns, vpn, etc. with `profiles -I -F "<PATH>"`
- [ ] Enable *Night Shift*
- [ ] Trust GPG keys
- [ ] Enable snap-to-grid for icons on the desktop and in other icon views
- [ ] Configure Dozer
- [ ] Configure Amethyst

### Things to setup declaratevely with Nix/Home-Manager

- [ ] Import and trust GPG keys
- [ ] Clone `pass` repo
- [ ] macOS configuration/settings/profiles (using [nix-darwin](https://github.com/LnL7/nix-darwin))
- [ ] Maybe use [flakes](https://nixos.wiki/wiki/Flakes) to improve reproducibility
- [ ] Complete system-in-a-container (even a VM will be fine) with full NixOS

