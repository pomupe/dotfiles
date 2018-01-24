#!/bin/bash
CONFIG_DIR=~/.dotfiles/config
VIM_DIR=${CONFIG_DIR}/vim
GIT_DIR=${CONFIG_DIR}/git
TMUX_DIR=${CONFIG_DIR}/tmux

# Vim and Neovim
ln -s ${VIM_DIR}/vimrc        ~/.vimrc
if [ ! -e ~/.config/nvim ]; then
  mkdir -p ~/.config/nvim
fi
ln -s ${VIM_DIR}/vimrc        ~/.config/nvim/init.vim
if [ ! -e ~/.vim/rc ]; then
  mkdir -p ~/.vim/rc
fi
ln -s ${VIM_DIR}/rc/dein.toml ~/.vim/rc/dein.toml

# Git
ln -s ${GIT_DIR}/gitignore               ~/.gitignore
ln -s ${GIT_DIR}/gitconfig               ~/.gitconfig
ln -s ${GIT_DIR}/gitconfig.linux         ~/.gitconfig.os
if [ ! -f ~/.gitconfig.user ]; then
  cp    ${GIT_DIR}/gitconfig.user.template ~/.gitconfig.user
  echo "Create ~/.gitconfig.user"
  echo "Edit your name and email in ~/.gitconfig.user"
fi

# tmux
ln -s ${TMUX_DIR}/tmux.conf ~/.tmux.conf

echo "Finish deployment"
