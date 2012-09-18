# Init
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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
