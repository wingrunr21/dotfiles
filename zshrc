# Init
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Tree shortcut
alias tr=tree
alias c=consular

# Directory shortcuts with completion
# Thanks to http://blog.mavjs.org/2012/07/zsh-autocomplete-function-to-change-and.html
function sites() { cd ~/Sites/$1; }
_sites() { _files -W ~/Sites }
compdef _sites sites

function proj() { cd ~/Projects/$@; }
_proj() { _files -W ~/Projects }
compdef _proj proj

# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Git
# stomp on the ones made by oh-my-zsh
alias gs="git status" # status of files
alias gl="git gl" # pretty log (specs in .gitconfig)
alias gd="git diff" # diff a file

alias be="bundle exec"

alias npm-exec='PATH=$(npm bin):$PATH'

# Misc
alias g='grep -i'  # Case insensitive grep
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias top='top -o cpu'
alias systail='tail -f /var/log/system.log'
alias m='more'
alias df='df -h'
alias marked="open -a Marked" # add a marked command to open markdown files in Marked

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

if [[ "$OSTYPE" == darwin* ]]; then
  export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"
fi
