# env.nu
#
# Installed by:
# version = "0.109.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

# Nushell
$env.config.show_banner = false

# Path
use std/util "path add"
path add "~/.bun/bin"
if $nu.os-info.name == "linux" {
    path add "~/.asdf/shims"
}

# XDG Base Directory
if $nu.os-info.name == "linux" {
    $env.XDG_CONFIG_HOME = ("~/.config" | path expand)
    $env.XDG_CACHE_HOME = ("~/.cache" | path expand)
    $env.XDG_DATA_HOME = ("~/.local/share" | path expand)
    $env.XDG_STATE_HOME = ("~/.local/state" | path expand)
}

# Editor
$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Modules
if $nu.os-info.name == "windows" {
    $env.NU_LIB_DIRS ++= [($env.APPDATA | path join "nushell" "nu_scripts")]
} else {
    $env.NU_LIB_DIRS ++= [($env.XDG_DATA_HOME | path join "nushell" "nu_scripts")]
}

# For WSL
if $nu.os-info.name == "linux" {
    # Use system default certificates
    $env.SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"
    # Enable wsl2-ssh-agent
    $env.SSH_AUTH_SOCK = ($env.XDG_RUNTIME_DIR | path join "wsl2-ssh-agent.sock")

    # Enable hoembrew
    let brew_home = "/home/linuxbrew/.linuxbrew"
    $env.HOMEBREW_PREFIX = $brew_home
    $env.HOMEBREW_CELLAR = ($brew_home | path join "Cellar")
    $env.HOMEBREW_REPOSITORY = ($brew_home | path join "Homebrew")
    path add ($brew_home | path join "sbin")
    path add ($brew_home | path join "bin")
    let brew_man = ($brew_home | path join "share" "man")
    $env.MANPATH = (
        $env.MANPATH? 
        | default "" 
        | split row (char esep) 
        | where $it != ""
        | prepend $brew_man
    )
    let brew_info = ($brew_home | path join "share" "info")
    $env.INFOPATH = (
        $env.INFOPATH? 
        | default "" 
        | split row (char esep) 
        | where $it != ""
        | prepend $brew_info
    )
}
