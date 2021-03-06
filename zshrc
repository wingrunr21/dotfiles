#
# User configuration sourced by interactive shells
#

# Homebrew zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Custom zfunctions
fpath=( "$HOME/.zfunctions" $fpath )
source ~/.zfunctions/ruby.zsh

# Prompt setup
BLOX_CONF__ONELINE=true
BLOX_CONF__BLOCK_PREFIX='('
BLOX_CONF__BLOCK_SUFFIX=')'
BLOX_BLOCK__RUBY_SYMBOL=
BLOX_BLOCK__NODEJS_SYMBOL=
BLOX_BLOCK__GIT_CLEAN_SYMBOL=✔
BLOX_SEG__UPPER_LEFT=(host cwd git)
BLOX_SEG__UPPER_RIGHT=(blox_block__bgjobs blox_block__nodejs blox_block__ruby)
BLOX_BLOCK__CWD_TRUNC=100
BLOX_BLOCK__CWD_COLOR='green'

# Setup blox prompt
source ~/dotfiles/prompts/blox/blox.zsh
unset BLOX_CONF__PROMPT_PREFIX

# chruby
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# chnode
source /usr/local/opt/chnode/chnode.sh
source /usr/local/opt/chnode/auto.sh

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

# GPG setup
if [ -f ~/.gnupg/S.gpg-agent ]; then
  eval $(gpg-agent --daemon)
fi
