# PIPENV VENV in projects
export PIPENV_VENV_IN_PROJECT=true

# Go projects
export GOPATH=/Users/$(whoami)/Projects/go

# Android Home
export ANDROID_HOME=/usr/local/opt/android-sdk

# Vagrant
export VAGRANT_DEFAULT_PROVIDER=parallels

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}
