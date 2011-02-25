# See following for more information: http://www.infinitered.com/blog/?p=19
export CLICOLOR=1

if [ -d ~/bin ]; then
	export PATH=:~/bin:$PATH  # add your bin folder to the path, if you have it.  It's a good place to add all your scripts
fi

PLATFORM=`uname -s`

#For NodeJS
export NODE_PATH=/usr/local/lib/node

# Load in .bashrc -------------------------------------------------
source ~/.bashrc

#Load git completion
if [ $PLATFORM = 'Darwin' ]; then
  VERSION=`git --version | cut -d' '  -f3 -`
  source /usr/local/Cellar/git/$VERSION/etc/bash_completion.d/git-completion.bash
else
  source /c/Program\ Files\ \(x86\)/Git/etc/git-completion.bash
fi


# Hello Messsage --------------------------------------------------
echo -e "Kernel Information: " `uname -smr`
echo -e "`bash --version`"
echo -ne "Uptime: "; uptime
echo -ne "Server time is: "; date

if [ $PLATFORM = 'Darwin' ]; then
  if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi
else
  if [[ -s $USERPROFILE/.pik/.pikrc ]]  ; then source $USERPROFILE/.pik/.pikrc ; fi
fi
