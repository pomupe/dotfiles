# config.nu
#
# Installed by:
# version = "0.109.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

##########
# Aliases
##########
alias core-ls = ls
alias ls = eza

##########
# completions
##########
use nu_scripts/custom-completions/bat/bat-completions.nu *
use nu_scripts/custom-completions/cargo/cargo-completions.nu *
use nu_scripts/custom-completions/curl/curl-completions.nu *
use nu_scripts/custom-completions/eza/eza-completions.nu *
use nu_scripts/custom-completions/git/git-completions.nu *
use nu_scripts/custom-completions/just/just-completions.nu *
use nu_scripts/custom-completions/less/less-completions.nu *
use nu_scripts/custom-completions/rg/rg-completions.nu *
use nu_scripts/custom-completions/rustup/rustup-completions.nu *
use nu_scripts/custom-completions/scoop/scoop-completions.nu *
use nu_scripts/custom-completions/ssh/ssh-completions.nu *
use nu_scripts/custom-completions/uv/uv-completions.nu *
use nu_scripts/custom-completions/winget/winget-completions.nu *
use nu_scripts/custom-completions/zoxide/zoxide-completions.nu *
