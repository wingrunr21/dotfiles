#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#


# Paths
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  /usr/local/share/npm/bin
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# Language
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

# Editors ----------------------------------------------------------
if [[ "$OSTYPE" == darwin* ]]; then
  export EDITOR='mvim -f'
  export VISUAL='mvim -f'
elif [[ "$OSTYPE" == linux* ]]; then
  export EDITOR='vim'
fi
export PAGER='less'

# Browser (Default)
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Less

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# Use homebrew python
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# Go projects
export GOPATH=/Users/wingrunr21/Projects/go

# Android Home
export ANDROID_HOME=/usr/local/opt/android-sdk

# Vagrant
export VAGRANT_DEFAULT_PROVIDER=parallels

# Docker
#export DOCKER_TLS_VERIFY="1"
#export DOCKER_HOST="tcp://10.211.55.44:2376"
#export DOCKER_CERT_PATH="/Users/wingrunr21/.docker/machine/machines/docker-dev"
#export DOCKER_MACHINE_NAME="docker-dev"

# Fix PATH being screwed up
export OLDPATH=$PATH && unset PATH && export PATH=$OLDPATH
