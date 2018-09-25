# Dotfiles

This is my dotfiles repo.
All the stuff that you will find inside is pretty standard for developers and for every *NIX command line enthusiast.


## Installation

### Step 1

Run this command:

```
curl https://raw.githubusercontent.com/biosan/dotfiles/master/_bootstrap | bash
```

It will install XCode Command Line Tools, [Homebrew](https://homebrew.sh), [mas](https://github.com/mas-cli/mas), and then clone this repository into `~/.dotfiles`


### Step 2

Edit your preferences in `~/.dotfiles/_macos/vars.sh`


### Step 3

Run this command to stow your dotfiles, install your core and extra apps and to apply your settings

```
~/.dotfiles/configure
```

### Step 4

Complete all the other steps inside [MANUAL_SETTINGS.md](./MANUAL_SETTINGS.md) to complete the setup of your machine


### Done!
