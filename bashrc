# Colors ----------------------------------------------------------
if [ "$PLATFORM" = 'Darwin' ]; then
  #export CC=/usr/bin/gcc-4.2
  export TERM=xterm-color
  export CLICOLOR=1
elif [ "$PLATFORM" = 'Linux' ]; then
  export TERM=xterm-color
  export CLICOLOR=1
else
  TERM=msys
fi

export GREP_OPTIONS='--color=auto'

# Setup some colors to use later in interactive shell or scripts
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'
alias colorslist="set | egrep 'COLOR_\w*'"  # Lists all the colors, uses vars in .bashrc_non-interactive


# Misc -------------------------------------------------------------
export HISTCONTROL=ignoredups
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# Prompts ----------------------------------------------------------
function prompt {
  previous_return_value=$?;
  prompt="\[${COLOR_GRAY}\]\u@\h \[${COLOR_GREEN}\]\w\[${COLOR_RED}\]$(__git_ps1)\[${COLOR_GREEN}\]"

  if test $previous_return_value -eq 0
  then
      PS1="${prompt}\[${COLOR_GREEN}\] > \[${COLOR_NC}\]"
  else
      PS1="${prompt}\[${COLOR_RED}\] > \[${COLOR_NC}\]"
  fi
}
PROMPT_COMMAND=prompt

export PS2='> ' # Secondary prompt
export PS3='#? ' # Prompt 3
export PS4='+' # Prompt 4

function xtitle {  # change the title of your xterm* window
  unset PROMPT_COMMAND
  echo -ne "\033]0;$1\007"
}

alias t=terminitor

# Navigation -------------------------------------------------------
alias ..='cd ..'
alias ...='cd .. ; cd ..'

if [ "$PLATFORM" = 'Darwin' ]; then
  alias sites='cd ~/Sites'
  alias proj='cd ~/Projects'
elif [ "$PLATFORM" = 'Linux' ]; then
  alias sites='cd ~/sites'
  alias proj='cd ~/projects'
else
  alias sites='cd /f/documents/sites'
  alias proj='cd /f/documents/projects'
  alias gvim='/c/Program\ Files\ \(x86\)/Vim/vim73/gvim'
  alias ls="ls --color=auto"
fi

# Other aliases ----------------------------------------------------
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -lah'

# Rails 2
alias ss='script/server' # rails: script/server
alias sc='script/console' # rails: script/console
alias sg='script/generate' # rails: script/generate
alias sgs='script/generate scaffold' # rails: script/generate
alias sgm='script/generate migration' # rails: script/generate
alias sgns='script/generate nifty_scaffold' # use nifty_scaffold
alias rdm='rake db:migrate'
alias rdp='rake db:populate' # assuming a populate task exists
alias rdr='rake db:reset' #reset db

# Rails 3
alias rn='rails new'
alias rs='rails server'
alias rc='rails console'
alias rdc='rails dbconsole'
alias rg='rails generate'
alias rgs='rails generate scaffold'
alias rgm='rails generate migration'
alias rgns='rails generate nifty:scaffold'

# Git
alias gs="git status" # status of files
alias ga="git add" # add a file to staging
alias gr="git rm" # remove a file
alias gc="git commit" # commit files to repo
alias gp="git push" # push to repo
alias gpl="git pull" # pull from repo
alias gpom="git push origin master" # typically to send to github
alias gco="git checkout" # checkout
alias gb="git branch" # for branching
alias gm="git merge" # for merging
alias gi="git instaweb --httpd webrick" # to visualize in browser
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

# Editors ----------------------------------------------------------
if [ "$PLATFORM" = 'Darwin' ]; then
  export EDITOR='mvim -f'
  export VISUAL='mvim -f'
elif [ "$PLATFORM" = 'Linux' ]; then
  export EDITOR='vim -w'
else
  export EDITOR='gvim -w'
fi

# Subversion & Diff ------------------------------------------------
export SV_USER='wingrunr21'  # Change this to your username that you normally use on subversion (only if it is different from your logged in name)
export SVN_EDITOR='${EDITOR}'

alias svshowcommands="echo -e '${COLOR_BROWN}Available commands:
   ${COLOR_GREEN}sv
   ${COLOR_GREEN}sv${COLOR_NC}help
   ${COLOR_GREEN}sv${COLOR_NC}import    ${COLOR_GRAY}Example: import ~/projects/my_local_folder http://svn.foo.com/bar
   ${COLOR_GREEN}sv${COLOR_NC}checkout  ${COLOR_GRAY}Example: svcheckout http://svn.foo.com/bar
   ${COLOR_GREEN}sv${COLOR_NC}status
   ${COLOR_GREEN}sv${COLOR_NC}status${COLOR_GREEN}on${COLOR_NC}server
   ${COLOR_GREEN}sv${COLOR_NC}add       ${COLOR_GRAY}Example: svadd your_file
   ${COLOR_GREEN}sv${COLOR_NC}add${COLOR_GREEN}all${COLOR_NC}    ${COLOR_GRAY}Note: adds all files not in repository [recursively]
   ${COLOR_GREEN}sv${COLOR_NC}delete    ${COLOR_GRAY}Example: svdelete your_file
   ${COLOR_GREEN}sv${COLOR_NC}diff      ${COLOR_GRAY}Example: svdiff your_file
   ${COLOR_GREEN}sv${COLOR_NC}commit    ${COLOR_GRAY}Example: svcommit
   ${COLOR_GREEN}sv${COLOR_NC}update    ${COLOR_GRAY}Example: svupdate
   ${COLOR_GREEN}sv${COLOR_NC}get${COLOR_GREEN}info${COLOR_NC}   ${COLOR_GRAY}Example: svgetinfo your_file
   ${COLOR_GREEN}sv${COLOR_NC}blame     ${COLOR_GRAY}Example: svblame your_file
'"

alias sv='svn --username ${SV_USER}'
alias svimport='sv import'
alias svcheckout='sv checkout'
alias svstatus='sv status'
alias svupdate='sv update'
alias svstatusonserver='sv status --show-updates' # Show status here and on the server
alias svcommit='sv commit'
alias svadd='svn add'
alias svaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add'
alias svdelete='sv delete'
alias svhelp='svn help'
alias svblame='sv blame'

svgetinfo (){
 	sv info $@
	sv log $@
}
