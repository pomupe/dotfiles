@echo off
: Vim
mklink %HOMEPATH%\_vimrc %HOMEPATH%\.dotfiles\config\vim\vimrc
mklink %HOMEPATH%\_gvimrc %HOMEPATH%\.dotfiles\config\vim\gvimrc
if not exist %HOMEPATH%\.vim\rc\ (
  mkdir %HOMEPATH%\.vim\rc
)
mklink %HOMEPATH%\.vim\rc\dein.toml %HOMEPATH%\.dotfiles\config\vim\rc\dein.toml

: Git
mklink %HOMEPATH%\.gitignore    %HOMEPATH%\.dotfiles\config\git\gitignore
mklink %HOMEPATH%\.gitconfig    %HOMEPATH%\.dotfiles\config\git\gitconfig
mklink %HOMEPATH%\.gitconfig.os %HOMEPATH%\.dotfiles\config\git\gitconfig.win
if not exist %HOMEPATH%\.gitconfig.user (
  copy %HOMEPATH%\.dotfiles\config\git\gitconfig.user.template %HOMEPATH%\.gitconfig.user
  echo "Create ~/.gitconfig.user"
  echo "Edit your name and email in ~/.gitconfig.user"
)

: VimFx
if not exist %HOMEPATH%\.config\vimfx\ (
  mkdir %HOMEPATH%\.config\vimfx
)
copy %HOMEPATH%\.dotfiles\config\vimfx\config.js %HOMEPATH%\.config\vimfx\config.js
copy %HOMEPATH%\.dotfiles\config\vimfx\frame.js %HOMEPATH%\.config\vimfx\frame.js

echo "Finish deployment"
