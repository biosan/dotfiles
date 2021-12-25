{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in {
  # Allow unfree packages (VSCode)
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "biosan";
  home.homeDirectory = "/Users/biosan";

  home.sessionVariables = {
    NIX_PATH = "$HOME/.nix-defexpr/channels:nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs:/nix/var/nix/profiles/per-user/root/channels";
    SSH_AUTH_SOCK = "$HOME/.gnupg/S.gpg-agent.ssh";
    PATH = "$HOME/bin:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.dotfiles/deps/npm/node_modules/.bin:$HOME/.nix-profile/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin:/Applications/Wireshark.app/Contents/MacOS";
  };

  home.packages = with pkgs; [
    # Essentials
    exa
    fd
    lsof
    mosh
    ranger
    rclone
    ripgrep
    rsync
    cachix
    zellij
    fishPlugins.foreign-env

    # Utilities
    curl
    neofetch
    pv
    watch
    tree

    # Programming languages
    nodejs
    python3Full
    rustc

    # Package managers
    cargo
    pipenv
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
    rage
    yubikey-agent
    # yubikey-manager # TODO: Find a solution...
    wireguard-go
    wireguard-tools

    # Programming tools
    awscli
    buildkit
    cmake
    docker
    docker-compose
    kubectl
    kubectx
    kubetail
    lazydocker
    lazygit
    nodePackages.lerna
    tokei

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

    # Media
    image_optim
    nodePackages.svgo

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
  };

  programs.git = {
    enable = true;
    userName = "biosan";
    userEmail = "alessandro@biondi.me";
    lfs.enable = true;
    aliases = {
      go = "checkout";
      d = "difftool";
      ignore = "!gi() { curl -sL https://www.gitignore.io/api/$@ ;}; gi";
      unstage = "reset HEAD --";
      uncommit = "reset --soft HEAD~1";
      recommit = "commit --amend --no-edit";
      amend = "commit --amend";
      get = "pull origin master";
      save = "!git add . && git commit --no-verify -m \"WIP: auto save at $(date '+%Y%m%d %H:%M:%S')\"";
      mine = "log --author='biosan'";
    };
    delta = {
      enable = true;
      options = {
        theme = "OneHalfDark";
      };
    };
    extraConfig = {
      github.user = "biosan";
      url."git@github.com:biosan/" = {
        insteadOf = [
          "me:"
          "https://github.com/biosan/"
        ];
      };
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
    shell = "${pkgs.fish}/bin/fish";
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
    ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      " My NeoVim config

      let mapleader = "<space>"

      set lazyredraw
      set ttyfast

      set mouse+=a
      set ignorecase
      set smartcase

      " ========= Swap, Backup & Undo directories =========
      set swapfile " Defaults to $XDG_DATA_HOME/nvim/swap
      set undofile " Defaults to $XDG_DATA_HOME/nvim/undo
      " Enable backup file and set directory
      " set backup
      " set backupdir='$XDG_DATA_HOME/nvim/back/'


      " Enable 24bit true color
      if (has("termguicolors"))
       set termguicolors
      endif

      set background=dark
      let g:one_allow_italics = 1 " Enable Vim-One colorscheme italics support
      let g:onedark_terminal_italics = 1

      try
          colorscheme one "dark
      catch /.*/
          colorscheme default
      endtry

      " Non-printable character
      " Good UTF-8 chars: ↩ ⠿↯■⌻†‖‡⍀⌇∲⊙∫
      set listchars=tab:‣\ ,trail:∬,extends:⇉,precedes:⇇
      set list

      set showbreak=↪\    " Show wrapped lines

      set number          " Lines numbers
      set relativenumber  " Lines numbers relative to cursor

      set cursorcolumn    " Show cursor column
      set cursorline      " Show cursor line
      " Text folding
      set foldmethod=indent
      set foldlevel=12
      " --- Indentation settings ---
      set tabstop=4    " (ts) width (in spaces) that a <tab> is displayed as
      set expandtab    " (et) expand tabs to spaces (use :retab to redo entire file)
      set shiftwidth=4 " (sw) width (in spaces) used in each step of autoindent (or << and >>)

      " always show signcolumns
      set signcolumn=yes

      " Close buffer
      nnoremap <Leader>q :Bwipeout<CR>

      """ EditorConfig
      let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

      " Performance settings
      set norelativenumber
      set nocursorline
      set nocursorcolumn

    '';
    # builtins.readFile ./neovim.vim;
    plugins = with pkgs.vimPlugins; [
      # Colorschemes
      onedark-vim
      onehalf
      vim-one
      # Essentials
      vim-devicons
      # Tim Pope Essentials
      surround
      commentary
      # Language Support
      polyglot
      vim-nix
      # Git
      gitsigns-nvim
    ];
  };

  programs.ssh = {
    enable = true;
  };

  xdg.configFile."neofetch/config.conf".text = ''
    # See this wiki page for more info:
    # https://github.com/dylanaraps/neofetch/wiki/Customizing-Info
    print_info() {
      prin
      prin
      info title
      info underline
      info line_break
      info "OS\t" distro
      info "Host\t" model
      prin
      info "Shell\t" shell
      info "Term\t" term
      # info "Font\t" term_font
      prin "Font\t" "Fira Code NF & Fantasque"
      info "WM\t" wm
      prin
      info "CPU\t" cpu
      info "GPU\t" gpu
      prin "Memory\t" "$(($(sysctl -n hw.memsize)/2**30)) GiB"
      #prin "Disk\t" disk
      prin
      prin
    }
  ''

  xdg.configFile."rclone/rclone.conf".text = ''
    [nas]
    type = sftp
    host = 192.168.1.122
    use_insecure_cipher = false
    user = root
    md5sum_command = md5sum
    sha1sum_command = sha1sum
  '';

  programs.go = {
    enable = true;
    goPath = ".local/go";
  };

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
          family = "FiraCode Nerd Font";
          #style = "Retina";
        };
        bold = {
          family = "FiraCode Nerd Font";
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
