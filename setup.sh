#!/bin/bash

DOTFILES=${HOME}/dotfiles

# git
ln -sf ${DOTFILES}/gitconfig ${HOME}/.gitconfig
ln -sf ${DOTFILES}/gitignore_global ${HOME}/.gitignore_global

# Ruby
ln -sf ${DOTFILES}/gemrc ${HOME}/.gemrc

# VIM
ln -sf ${DOTFILES}/vimrc ${HOME}/.vimrc

# zsh
ln -sf ${DOTFILES}/zlogin ${HOME}/.zlogin
ln -sf ${DOTFILES}/zshenv ${HOME}/.zshenv
touch ${HOME}/.zshrc
echo -e "BREW_PREFIX=$(brew --prefix)\nsource ${DOTFILES}/zshrc" >> ${HOME}/.zshrc

# zim
ln -sf ${DOTFILES}/zimrc ${HOME}/.zimrc
ZIM_HOME=${HOME}/.zim
mkdir -p ${ZIM_HOME}
curl -fsSL -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
zsh ${ZIM_HOME}/zimfw.zsh install
