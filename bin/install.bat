@echo off
: Vim
mklink /H %HOMEPATH%\_vimrc %HOMEPATH%\.dotfiles\config\vim\vimrc
mklink /H %HOMEPATH%\_gvimrc %HOMEPATH%\.dotfiles\config\vim\gvimrc
if not exist %HOMEPATH%\.vim\rc\ (
  mkdir %HOMEPATH%\.vim\rc
)
mklink /H %HOMEPATH%\.vim\rc\dein.toml %HOMEPATH%\.dotfiles\config\vim\rc\dein.toml

: Git
mklink /H %HOMEPATH%\.gitignore    %HOMEPATH%\.dotfiles\config\git\gitignore
mklink /H %HOMEPATH%\.gitconfig    %HOMEPATH%\.dotfiles\config\git\gitconfig
mklink /H %HOMEPATH%\.gitconfig.os %HOMEPATH%\.dotfiles\config\git\gitconfig.win
if not exist %HOMEPATH%\.gitconfig.user (
  copy %HOMEPATH%\.dotfiles\config\git\gitconfig.user.template %HOMEPATH%\.gitconfig.user
  echo "Create ~/.gitconfig.user"
  echo "Edit your name and email in ~/.gitconfig.user"
)

echo "Finish deployment"
