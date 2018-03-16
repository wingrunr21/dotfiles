#
# User configuration sourced by interactive shells
#

# Custom zfunctions
fpath=( "$HOME/.zfunctions" $fpath )
source ~/.zfunctions/ruby.zsh

# Prompt setup
BLOX_CONF__ONELINE=true
BLOX_CONF__NEWLINE=false
BLOX_CONF__BLOCK_PREFIX='('
BLOX_CONF__BLOCK_SUFFIX=')'
BLOX_BLOCK__RUBY_SYMBOL=
BLOX_BLOCK__NODEJS_SYMBOL=
BLOX_BLOCK__GIT_CLEAN_SYMBOL=✔
BLOX_SEG__UPPER_RIGHT=(blox_block__bgjobs blox_block__nodejs blox_block__ruby)
BLOX_BLOCK__CWD_TRUNC=0
BLOX_BLOCK__CWD_COLOR='green'

# Homebrew zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# Setup blox prompt
source ~/dotfiles/prompts/blox/blox.zsh

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# Setup zsh-iterm-touchbar
source ~/dotfiles/zsh-iterm-touchbar/zsh-iterm-touchbar.plugin.zsh

# Directory shortcuts with completion
# Thanks to http://blog.mavjs.org/2012/07/zsh-autocomplete-function-to-change-and.html
function sites() { cd ~/Sites/$1; }
_sites() { _files -W ~/Sites }
compdef _sites sites

function proj() { cd ~/Projects/$@; }
_proj() { _files -W ~/Projects }
compdef _proj proj

# Aliases

# Git
alias git=hub
alias gs="git status" # status of files
alias gl="git gl" # pretty log (specs in .gitconfig)
alias gd="git diff" # diff a file

# Bundler
alias be="bundle exec"

# Npm
alias npm-exec='PATH=$(npm bin):$PATH'

# GPG setup
if [ -f ~/.gnupg/S.gpg-agent ]; then
  eval $(gpg-agent --daemon)
fi
