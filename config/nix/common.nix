{ config, pkgs, ... }:

let

  pkgsUnstable = import <nixpkgs-unstable> {};

in

{
  # Allow unfree packages (VSCode)
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (import ./overlays/neovim-nightly-unwrapped.nix)
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "biosan";
  home.homeDirectory = "/Users/biosan";

  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.gnupg/S.gpg-agent.ssh";
    PATH = "$HOME/bin:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.dotfiles/deps/npm/node_modules/.bin:$HOME/.nix-profile/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin:/Applications/Wireshark.app/Contents/MacOS";
  };

  home.packages = with pkgs; [
    # Essentials
    exa
    mosh
    ranger
    rclone
    ripgrep
    rsync
    cachix

    # Utilities
    curl
    neofetch
    pv
    watch
    tree

    # Programming languages
    nodejs-12_x
    python3Full

    # Package managers
    python3Packages.poetry
    yarn

    # Cryptography
    age
    bitwarden-cli
    magic-wormhole
    openssh
    openssl
    openvpn
    pwgen
    pwgen-secure
    pkgsUnstable.rage
    pkgsUnstable.yubikey-agent
    # yubikey-manager # TODO: Find a solution...
    wireguard-go
    wireguard-tools

    # Programming tools
    docker
    docker-compose
    lazydocker
    lazygit

    # LanguageServers, Formatters and Linters
    shellcheck
    vale

    # Compression utils
    lz4
    lzo
    p7zip
    unzip
    xz
    zip
    zstd

    # System and network tools
    aria2
    bandwhich
    htop
    httpie
    netcat
    nmap
    prettyping
    # tailscale # TODO: Not supported on macOS
    wget
    youtube-dl
    # zerotierone # TODO: deps not supported on macOS

    # Stupid stuff
    cmatrix
    cowsay
    fortune
    sl
  ];

  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "TwoDark";
    };
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    # Start starship as prompt and source NIX environment
    # To manually setup: `${pkgs.starship}/bin/starship init fish | source`
    promptInit = ''
      bass ". $HOME/.nix-profile/etc/profile.d/nix.sh"
    '';
    shellAliases = {
      ishm = "echo 'Yeah you are inside home-manager fish'";
      top-nix-pks = "du -hd 1 /nix/store | gsort -rh | head -25";
      cask = "brew cask";
      # https://github.com/appalaszynski/mac-setup
      brewup = "brew update; brew upgrade; brew prune; brew cleanup; brew doctor";
      ytdl2c = "youtube-dl --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M'";
      docker-clean="docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f";
    };
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      dotenv = ''
        for i in (cat $argv)
          set arr (echo $i | string match -r "([^=]+)=(.*)")
          set -gx $arr[2] $arr[3]
        end
      '';
    };
    plugins = [
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "7aae6a85c24660422ea3f3f4629bb4a8d30df3ba";
          sha256 = "03693ywczzr46dgpnbawcfv02v5l143dqlz1fzjbhpwwc2xpr42y";
        };
      }
    ];
  };

  programs.git = {
    enable = true;
    userName = "biosan";
    userEmail = "alessandro@biondi.me";
    lfs.enable = true;
    signing = {
      key = "A1E1E639E47467DBD89CA0678632E1D006B8EFB1";
      signByDefault = false;
    };
    aliases = {
      go = "checkout";
      d = "difftool";
      ignore = "!gi() { curl -sL https://www.gitignore.io/api/$@ ;}; gi";
    };
    delta = {
      enable = true;
      options = {
        theme = "OneHalfDark";
      };
    };
    extraConfig = {
      github.user = "biosan";
      url."git@bitbucket.org:" = {
        insteadOf = "https://bitbucket.org/";
      };
    };
    includes = [
      {
        condition = "gitdir:~/Work/moveax";
        # Contents follow the same format of `extraConfig`
        contents = {
          user = {
            name = "biosan";
            mail = "alessandro.biondi@moveax.it";
            signingKey = "A1E1E639E47467DBD89CA0678632E1D006B8EFB1";
          };
        };
      }
    ];
    ignores = [
      ### OS generated files
      ".DS_Store"
      ".DS_Store?"
      "._*"
      "ehthumbs.db"
      "Thumbs.db"
      ".AppleDouble"
      ".LSOverride"
      ## Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ## Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"
      ### Vim
      "*.swp"
      ### Nix
      "default.nix"
      "shell.nix"
      ### Direnv
      ".envrc"
    ];
  };

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "8632E1D006B8EFB1";
      no-comments = false;
      # Get rid of the copyright notice
      no-greeting = true;
      # Because some mailers change lines starting with "From " to ">From "
      # it is good to handle such lines in a special way when creating
      # cleartext signatures; all other PGP versions do it this way too.
      no-escape-from-lines = true;
      # Use a modern charset
      charset = "utf-8";
      ### Show keys settings
      # Always show long keyid
      keyid-format = "0xlong";
      # Always show the fingerprint
      with-fingerprint = true;
      # Automatic key location
      auto-key-locate = "cert pka ldap keyserver";
      ### Private keys password protection options
      # Cipher algorithm
      s2k-cipher-algo = "AES256";
      # Hashing algorithm
      s2k-digest-algo = "SHA512";
      # Add a 8-byte salt and iterate password hash
      s2k-mode = "3";
      # Number of password hashing iterations
      s2k-count = "65000000";
      ### Change defaults algorithms
      # Personal symmetric algos
      personal-cipher-preferences = "AES256 TWOFISH CAMELLIA256 AES192 CAMELLIA192 AES CAMELLIA128 BLOWFISH";
      # Personal hashing algos
      personal-digest-preferences = "SHA512 SHA384 SHA256 SHA224 SHA1 RIPEMD160 MD5";
      # Personal compression algos
      personal-compress-preferences = "ZLIB BZIP2 ZIP";
      # Default algorithms
      default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 TWOFISH CAMELLIA256 AES192 CAMELLIA192 AES CAMELLIA128 BLOWFISH ZLIB BZIP2 ZIP Uncompressed";
      # Certificate hashing algorithm
      cert-digest-algo = "SHA512";
      # Minimize some attacks on subkey signing (from gpg docs)
      require-cross-certification = true;
      # Get rid of version info in output files
      no-emit-version = true;
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      # prompt_order = [ "line_break" "package" "kubernetes" "line_break" "character" ];
      character.symbol = "➜";
      aws = {
        disabled = true;
      };
      kubernetes = {
        format = ''on [⛵ $context \\($namespace\\)](dimmed green) '';
        disabled = false;
        context_aliases = {
          "dev.local.cluster.k8s" = "dev";
          "ittaxi-sit" = "K8S SIT";
          "ittaxi-dev" = "K8S DEV";
        };
      };
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    newSession = true;
    sensibleOnTop = true;
    shortcut = "a";
    terminal = "xterm-256color";
    extraConfig = ''
      ###############
      ### General ###
      ###############

      set-option -g default-shell $HOME/.nix-profile/bin/fish

      # Enable mouse support
      set-option -g mouse on

      # Add terminal overrides for better TrueColor support
      set -as terminal-overrides ",xterm-256color*:Tc"

      ### Performance settings
      set -g focus-events off
      set -g escape-time 0
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      tmuxPlugins.yank
      tmuxPlugins.open
      tmuxPlugins.pain-control
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          # Configure plugin: 'tmux-prefix-highlight'
          set -g @prefix_highlight_output_prefix ' ﬿ '
          set -g @prefix_highlight_output_suffix ' '
          set -g @prefix_highlight_prefix_prompt 'Prfx'
          set -g @prefix_highlight_fg 'colour000'
          set -g @prefix_highlight_bg 'colour005'
          set -g @prefix_highlight_show_copy_mode 'on'
          set -g @prefix_highlight_copy_mode_prompt 'Copy'
          set -g @prefix_highlight_copy_mode_attr 'fg=colour000,bg=colour03'
          set -g @prefix_highlight_empty_prompt 'Tmux'
          set -g @prefix_highlight_empty_has_affixes 'on'
          set -g @prefix_highlight_empty_attr 'fg=colour000,bg=colour012'

          ###################
          ### Status Line ###
          ###################

          ### Windows line configuration 1
          # window segments in status line
          # set -g window-status-separator "  〉"
          set -g window-status-separator " "
          set-window-option -g window-status-current-format '#[fg=colour008,bg=colour000,noitalics]#[fg=colour010,bg=colour008]#I#[fg=colour008,bg=colour010,noitalics]#[fg=colour008,bg=colour010]▌#[fg=colour000,bg=colour010]#W#[fg=colour010,bg=colour000,noitalics]'
          set-window-option -g window-status-format "#[fg=colour007] #I #W "
          set-window-option -g window-status-current-style bg=colour010,fg=colour000

          # general status bar settings
          set -g status on
          set -g status-interval 5
          set -g status-position top
          set -g status-justify left
          set -g status-right-length 120
          set -g status-bg colour000
          set -g status-fg colour007

          # Widgets
          wg_is_zoomed="#[fg=$color_dark,bg=$color_secondary]#{?window_zoomed_flag,[Z],}#[default]"

          set -g status-left "#{prefix_highlight} $wg_is_zoomed $wg_session"
          set -g status-right "#(pyline --tmux cpu mem host time bat)#[default]"
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          # Tmux sessions and (Neo)Vim sessions integration
          # See: https://github.com/tmux-plugins/tmux-resurrect/blob/master/docs/restoring_vim_and_neovim_sessions.md
          # for vim
          set -g @resurrect-strategy-vim 'session'
          # for neovim
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
    ];
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython = true;
    withPython3 = true;
    withRuby = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      pkgsUnstable.fzf
    ];
    configure = {
      customRC = builtins.readFile ../common/neovim.vim;
      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          # Colorschemes
          onedark-vim
          onehalf
          vim-one
          # Essentials
          lightline-vim
          fzf-vim
          fzfWrapper
          editorconfig-vim
          vim-devicons
          nerdtree
          # Tim Pope Essentials
          fugitive
          surround
          commentary
          vim-obsession
          # Language Support
          polyglot
          vim-nix
        ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];
      };
    };
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (
      exts: [
        exts.pass-otp
      ]
    );
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.config/password-store";
      # Main GPG key secondary iOS devices key
      PASSWORD_STORE_KEY = "2926E552221A08E1 EF690D7D8A20B303";
      PASSWORD_STORE_CLIP_TIME = "60";
      # PASSWORD_STORE_GPG_OPTS = "";
      PASSWORD_STORE_GENERATED_LENGTH = "32";
      # PASSWORD_STORE_SIGNING_KEY
      # EDITOR The location of the text editor used by edit. # TODO: Set to a secure version of nvim
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "moveax bitbucket.org" = {
        hostname = "bitbucket.org";
        identityFile = "~/Work/moveax/setec/ssh-keys/moveax-ssh-ed25519.pub";
        identitiesOnly = true;
      };
    };
  };

  xdg.configFile."neofetch/config.conf".source = ../common/neofetch.conf;
  # xdg.configFile."rclone/rclone.conf".source = ./config/rclone.conf;
  # home.file.".ssh/id_rsa.pub".source = ./config/id_rsa.pub;
  home.file.".ssh/authorized_keys".source = ../common/authorized_keys;

  xdg.configFile."rclone/rclone.conf".text = ''
    [nas]
    type = sftp
    host = 192.168.1.122
    use_insecure_cipher = false
    user = root
    md5sum_command = md5sum
    sha1sum_command = sha1sum
  '';


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
