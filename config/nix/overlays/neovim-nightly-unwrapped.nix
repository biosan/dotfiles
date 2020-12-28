self: super: {
  neovim-nightly-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: {
    version = "master";
    src = builtins.fetchTarball {
      # url = https://github.com/neovim/neovim.git;
      # ref = "nightly";
      # owner = "neovim";
      # repo = "neovim";
      # Nightly build as of 20/09/2020
      url = "https://github.com/neovim/neovim/archive/905c2eb359fc21995c6c0151b169b43c66b287fa.tar.gz";
      # ref = "905c2eb359fc21995c6c0151b169b43c66b287fa";
      # SHA-256 calculated with `nix-prefetch-url --unpack https://github.com/neovim/neovim/archive/905c2eb359fc21995c6c0151b169b43c66b287fa.tar.gz`
      sha256 = "191vc4qcwf10fwdhzhr9mxjpbvlz2905n4hgm89ciybx0lpkjvbk";
    };
  });
}
