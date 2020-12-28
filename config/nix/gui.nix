{ config, lib, pkgs, nixpkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  # Allow unfree packages (VSCode)
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ./overlays/jetbrains.nix)
  ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Editors and IDEs
    # jetbrains.idea-community
    # vscode
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "none";
        dynamic_title = true;
      };
      draw_bold_text_with_bright_colors = true;
      font = {
        normal = {
          family = "FuraCode Nerd Font";
          #style = "Retina";
        };
        bold = {
          family = "FuraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FantasqueSansMono Nerd Font";
          style = "Italic";
        };
        size = 12.0;
        glyph_offset = {
          x = 0;
          y = 0;
        };
        scale_with_dpi = true;
        use_thin_strokes = true;
      };
      shell.program = "fish";
      colors = {
        # Default colors
        primary = {
          background = "0x282c34";
          foreground = "0xabb2bf";
        };
        # Normal colors
        normal = {
          black =   "0x282c34";
          red =     "0xe06c75";
          green =   "0x98c379";
          yellow =  "0xd19a66";
          blue =    "0x61afef";
          magenta = "0xc678dd";
          cyan =    "0x56b6c2";
          white =   "0xabb2bf";
        };
        # Bright colors
        bright = {
          black =   "0x5c6370";
          red =     "0xe06c75";
          green =   "0x98c379";
          yellow =  "0xd19a66";
          blue =    "0x61afef";
          magenta = "0xc678dd";
          cyan =    "0x56b6c2";
          white =   "0xffffff";
        };
      };
    };
  };
}
