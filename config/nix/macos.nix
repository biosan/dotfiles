{ config, lib, pkgs, nixpkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # yubikey-manager # TODO: Find a solution...

    # Fonts
    # pkgsUnstable.nerdfonts.override {
    #   fonts = [ "FiraCode" "FantasqueSansMono" ];
    # }
  ];
}
