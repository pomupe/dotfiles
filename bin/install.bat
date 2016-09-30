@echo off
: Vim
mklink /H %HOME%\.vim\rc\dein.toml %HOME%\.dotfiles\config\vim\rc\dein.toml
mklink /H %HOME%\_vimrc            %HOME%\.dotfiles\config\vim\vimrc

: Git
mklink /H %HOME%\.gitignore %HOME%\.dotfiles\config\git\gitignore
mklink /H %HOME%\.gitconfig %HOME%\.dotfiles\config\git\gitconfig
mklink /H %HOME%\.gitconfig.os %HOME%\.dotfiles\config\git\gitconfig.win
if not exist %HOME%\.gitconfig.user (
  copy %HOME%\.dotfiles\config\git\gitconfig.user.template %HOME%\.gitconfig.user
)
