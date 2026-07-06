#= Profile
#== Path
use std/util "path add"
path add ($env.HOME | path join '.local/bin')
path add ($env.HOME | path join '.local/share/coursier/bin')
path add ($env.HOME | path join '.local/share/JetBrains/Toolbox/scripts')

#== Toolchain config
$env.SBT_OPTS = "-Dsbt.override.build.repos=true"

#= Alias & Function
#== Abbr
alias se = ^sudoedit

#= Officially recommended
