#!/bin/sh

ln -s dotfiles/.vimrc ~/.vimrc
ln -s dotfiles/dein.toml ~/dein.toml
ln -s dotfiles/.gitignore ~/.gitignore
ln -s dotfiles/.gitconfig ~/.gitconfig
ln -s dotfiles/.gitconfig.linux ~/.gitconfig.os
cp    .gitconfig.user.template ~/.gitconfig.user
echo "Finish deployment"
echo "Edit your name and email in ~/.gitconfig.user"
