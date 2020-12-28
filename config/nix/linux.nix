{ config, lib, pkgs, nixpkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # yubikey-manager # TODO: Find a solution...
    tailscale
    zerotierone

    # Fonts
    # pkgsUnstable.nerdfonts.override {
    #   fonts = [ "FiraCode" "FantasqueSansMono" ];
    # }
  ];
}
