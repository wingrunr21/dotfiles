if [ -d ~/bin ]; then
	export PATH=:~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
fi

if [ hash brew 2>&- ]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
  fi
fi

export PLATFORM=`uname -s`

#For NodeJS
if [ $PLATFORM = 'Darwin' ]; then
  export NODE_PATH=/usr/local/lib/node_modules
fi

# Load in .bashrc
source ~/.bashrc

#Load git completion
if [ $PLATFORM = 'Darwin' ]; then
  VERSION=`git --version | cut -d' '  -f3 -`
  source /usr/local/Cellar/git/$VERSION/etc/bash_completion.d/git-completion.bash
elif [ $PLATFORM = 'Linux' ]; then
  if [[ -s /usr/share/bash-completion/git ]] ; then source /usr/share/bash-completion/git ; fi
else
  source /c/Program\ Files\ \(x86\)/Git/etc/git-completion.bash
fi

# Hello Messsage --------------------------------------------------
echo -e "Kernel Information: " `uname -smr`
#echo -e "`bash --version`"
echo -ne "Uptime: "; uptime
echo -ne "Server time is: "; date

# load rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
