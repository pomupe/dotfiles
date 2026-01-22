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

# Path
use std/util "path add"
path add "~/.bun/bin"

# Editor
$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Modules
if $nu.os-info.name == "windows" {
    $env.NU_LIB_DIRS = "~/AppData/Roaming/nushell/nu_scripts"
} else {
    $env.NU_LIB_DIRS = "~/.config/nushell/nu_scripts"
}
