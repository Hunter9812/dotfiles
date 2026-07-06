#= Profile
#== Envirment
$env.HOME = $env.USERPROFILE

# Windows:XDG environment variables configured via Windows Environment Variables UI (sysdm.cpl)
# You can run this: rundll32.exe sysdm.cpl,EditEnvironmentVariables
$env.XDG_CONFIG_HOME = ($env.HOME | path join '.config')    # used by Nushell
$env.XDG_DATA_HOME   = ($env.HOME | path join '.local\share') # used by Nushell
$env.XDG_CACHE_HOME  = ($env.HOME | path join '.cache')
$env.XDG_STATE_HOME  = ($env.HOME | path join '.local\state')

$env.YAZI_CONFIG_HOME = ($env.HOME | path join '.config/yazi')
$env.YAZI_FILE_ONE = ($env.HOME | path join 'scoop/apps/git/current/usr/bin/file.exe')

#== Toolchain config
$env.JAVA_TOOL_OPTIONS = "-Dfile.encoding=UTF-8"

#= Alias & Function
#== Abbr
alias "scoop search" = ^scoop-search
def o [path: string = '.'] { ^explorer $path }
