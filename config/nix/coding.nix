{ config, lib, pkgs, nixpkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz))
    #(import ./overlays/jetbrains.nix)
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/.go";
    PATH = "$HOME/bin:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.dotfiles/deps/npm/node_modules/.bin:$HOME/.nix-profile/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin:/Applications/Wireshark.app/Contents/MacOS";
    #JAVA_HOME = "${pkgs.jdk11.home}";
  };

  home.packages = with pkgs; [
    # Programming languages
    go
    jdk11
    pythonFull
    python38Full
    ruby
    # NOTE:
    #   - Use rustup to manage multiple Rust version (for now)
    #   - Use `pkgs.latest.rustChannels.nightly.rust` to install the nightly
    #   - Use `pkgs.latest.rustChannels.stable.rust` to install the stable
    rustup

    # Package managers
    dep
    maven
    python3Packages.poetry
    python38Packages.poetry
    yarn

    # Programming tools
    awscli
    buildkit
    cmake
    gdb
    # gitAndTools.gitui # TODO: Temp disabled, installs a shitload of stuff...
    kubectl
    kubectx
    kubetail
    tokei
    nodePackages.lerna
    step-cli # Swiss army knife for x509, CAs, JWT, OAuth, etc.

    # Editors and IDEs
    # TODO: LunarVim...

    # LanguageServers, Formatters and Linters
    shellcheck
    vale

    # DBs & Co.
    sqlite
  ];
}
