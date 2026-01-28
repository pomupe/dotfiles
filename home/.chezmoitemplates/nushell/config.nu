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

alias core-which = which
# Finds a program file, alias, or custom command.
#
# This is a wrapper around `core-which` to fix an issue where
# certain external commands (like rustup/bat) appear with an empty path.
def which [
    --all (-a)          # Output all matches, not just the first one
    --help (-h)         # Display the help message
    ...applications: string # The commands to search for
]: [ nothing -> table ] {
    if $help {
        return (core-which --help)
    }
    if $all {
        if ($applications | is-empty) {
            return (core-which --all)
        } else {
            return ($applications | each {|cmd| core-which --all $cmd} | flatten)
        }
    }
    if ($applications | is-empty) {
        return (core-which)
    }

    return ($applications
        | each {|cmd|
            let result = (core-which --all $cmd)
            if ($result | is-empty) or ($result | length) == 1 {
                $result
            } else if ($result | get 0.type) != "external" {
                ($result | select 0)
            } else if ($result | get 0.path | is-not-empty) {
                ($result | select 0)
            } else {
                ($result | select 1)
            }
        }
        | flatten
    )
}

##########
# completions
##########
use custom-completions/bat/bat-completions.nu *
use custom-completions/cargo/cargo-completions.nu *
use custom-completions/curl/curl-completions.nu *
use custom-completions/eza/eza-completions.nu *
use custom-completions/git/git-completions.nu *
use custom-completions/just/just-completions.nu *
use custom-completions/less/less-completions.nu *
use custom-completions/rg/rg-completions.nu *
use custom-completions/rustup/rustup-completions.nu *
use custom-completions/scoop/scoop-completions.nu *
use custom-completions/ssh/ssh-completions.nu *
use custom-completions/uv/uv-completions.nu *
use custom-completions/winget/winget-completions.nu *
use custom-completions/zoxide/zoxide-completions.nu *
