# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:module:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':omz:module:editor' dot-expansion 'no'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:module:terminal' auto-title 'yes'

# Set the Zsh modules to load (man zshmodules).
# zstyle ':omz:load' zmodule 'attr' 'stat'

# Set the Zsh functions to load (man zshcontrib).
# zstyle ':omz:load' zfunction 'zargs' 'zmv'

# Set the Oh My Zsh modules to load (browse modules).
# The order matters.
zstyle ':omz:load' omodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'completion' \
  'prompt' \
  'ruby' \
  'osx' \
  'git'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:module:prompt' theme 'ir_black'

# Init
source "$OMZ/init.zsh"

# Consular shortcut
alias t=consular

if [[ "$OSTYPE" == darwin* ]]; then
  function sites() { cd ~/Sites/$@; }
  function proj() { cd ~/Projects/$@; }
elif [[ "$OSTYPE" == linux* ]]; then
  function sites() { cd ~/sites/$@; }
  function proj() { cd ~/projects/$@; }
fi

# Git
# stomp on the ones made by oh-my-zsh
alias gs="git status" # status of files
alias gl="git gl" # pretty log (specs in .gitconfig)
alias gd="git diff" # diff a file

# Misc
alias g='grep -i'  # Case insensitive grep
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'
alias m='more'
alias df='df -h'

# Kill the interactive aliases
unalias rm
unalias mv
unalias cp
unalias ln

# Fix for ack being named ack-grep on Ubuntu
which ack-grep &> /dev/null
if [ $? -eq 0 ]; then
  alias ack='ack-grep'
fi

# Editors ----------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
  export EDITOR='mvim -f'
  export VISUAL='mvim -f'
elif [[ "$OSTYPE" == linux* ]]; then
  export EDITOR='vim'
fi

if [[ "$OSTYPE" == darwin* ]]; then
  export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"
fi
