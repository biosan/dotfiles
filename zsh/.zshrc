export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Let zplug manage itself
zplug "zplug/zplug", hook-build:"zplug --self-manage"
# Plugins
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
# Oh-My-ZSH Plugins
zplug "plugins/git",                        from:oh-my-zsh
zplug "plugins/git-extra",                  from:oh-my-zsh
zplug "plugins/history",                    from:oh-my-zsh
zplug "plugins/history-substring-search",   from:oh-my-zsh
zplug "plugins/zsh-autosuggestions",        from:oh-my-zsh
zplug "plugins/pass",                       from:oh-my-zsh
# Personal Plugins
zplug "biosan/zsh-syntax-highlighting",     from:github

# Other plugins I used in the past:
# vi-mode catimg osx pass battery cp chucknorris history mosh torrent nmap nyan vagrant z


# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    zplug install
fi

zplug load


###########################
### Settings  (exports) ###
###########################
#
# History settings
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
# Ignore duplicate entries
export HISTCONTROL=ignoredups;
# Ignore some not very useful commands (ls, cd, cd -, pwd, exit, date, all --help)
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";
# History timestamp format
export HIST_STAMPS="yyyy.mm.dd"
# Preferred editor
export EDITOR='nvim'
# Set SSH key path
export SSH_KEY_PATH="~/.ssh/id_rsa.pub"
# Homebrew GitHub API token
source "$HOME/.brewghtoken"


###############
### Aliases ###
###############
#
# Shell
alias refresh="source ~/.zshrc"
alias q="exit"
alias cl=clear
# Editor
alias e="$EDITOR"
# Homebrew & Cask
alias cask="brew cask"
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'  # From https://github.com/appalaszynski/mac-setup


###################################
### For GPG and SSH integration ###
###################################
#
# Set gpg-agent as the ssh-agent
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi
export GPG_TTY=$(tty)


#############
### Other ###
#############
#
# HIGHLIGHT "rm -rf" to prevent me from cutting my hands off and smashing my head on my keyboard!
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')
# Enable command auto-correction.
ENABLE_CORRECTION="true"
# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"


############
### PATH ###
############
#
# Set PATH
PATH=${PATH}:/usr/local/sbin
PATH=${PATH}:/usr/local/bin
PATH=${PATH}:/usr/sbin
PATH=${PATH}:/usr/bin
PATH=${PATH}:/sbin
PATH=${PATH}:/bin
PATH=${PATH}:$HOME/bin
PATH=${PATH}:/usr/libexec
export PATH=${PATH}
# Set MANPATH
export MANPATH="/usr/local/man:$MANPATH"

# added by travis gem
[ -f /Users/biosan/.travis/travis.sh ] && source /Users/biosan/.travis/travis.sh
