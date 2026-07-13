# config.nu
#
# Installed by:
# version = "0.114.0"
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

#= Profile
#== Envirment
$env.LANG   = 'en_US.UTF-8'
$env.EDITOR = 'nvim'
$env.SHELL  = 'nu'
$env.profile = $nu.config-path

#== Mirrors
$env.RUSTUP_DIST_SERVER   	= 'https://rsproxy.cn'
$env.RUSTUP_UPDATE_ROOT     = 'https://rsproxy.cn/rustup'
$env.NPM_CONFIG_REGISTRY    = 'https://registry.npmmirror.com'
$env.NVM_NODEJS_ORG_MIRROR  = 'https://npmmirror.com/mirrors/node/'
$env.POETRY_PYPI_MIRROR_URL = 'https://pypi.tuna.tsinghua.edu.cn/simple'
$env.NODE_MIRROR            = 'https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/'
$env.COURSIER_REPOSITORIES  = 'https://maven.aliyun.com/repository/public'

#== Platform config
# [Improvements to parse-time evaluation](https://www.nushell.sh/blog/2023-09-19-nushell_0_85_0.html#improvements-to-parse-time-evaluation)
# Conditional `source` and `use`
const WINDOWS_CONFIG = "config_windows.nu"
const UNIX_CONFIG = "config_unix.nu"
const ACTUAL_CONFIG = if $nu.os-info.name == "windows" {
    $WINDOWS_CONFIG
} else {
    $UNIX_CONFIG
}

source $ACTUAL_CONFIG

#= Variable
$env.GOPATH = ($env.HOME | path join '.local/share/go')
$env.FZF_DEFAULT_OPTS = "
    --layout=reverse
    --border
    --info=inline
    --pointer='▶'
    --marker='✓'
    --color='fg+:white,hl:yellow,hl+:yellow,prompt:blue,header:magenta'
"
$env.FZF_CTRL_T_OPTS = "
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

#= External Completers
# See https://www.nushell.sh/cookbook/external_completers.html
let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}
# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -o 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        _ => $carapace_completer
    } | do $in $spans
}

#== Options
$env.config.buffer_editor = $env.EDITOR
$env.config.show_banner = false
$env.config.rm.always_trash = true
$env.config.edit_mode = 'vi'
$env.config.cursor_shape = {
    vi_insert: blink_line
    vi_normal: block
}
$env.config.completions.external.completer = $external_completer
$env.config.keybindings ++= [
    {
        name: emacs_c-f
        modifier: control
        keycode: char_f
        mode: vi_insert
        event: {
            until: [
                { send: HistoryHintComplete }
                { send: MenuRight }
                { send: Right }
            ]
        }
    },
    {
        name: emacs_c-b
        modifier: control
        keycode: char_b
        mode: vi_insert
        event: {
            until: [
                { send: MenuLeft }
                { send: Left }
            ]
        }
    },
]

#= Alias & Function
# See https://www.nushell.sh/book/aliases.html
# See https://www.nushell.sh/book/custom_commands.html
#== Abbr
alias ni  = touch
alias vi  = ^nvim
alias c   = ^code .
alias s   = ^fastfetch
alias g   = ^lazygit
alias lzd = ^lazydocker
alias oc  = ^opencode

#== Utils
alias reload = exec nu
alias conf  = ^git --git-dir ($env.HOME | path join ".cfg") --work-tree $env.HOME
alias confg = ^lazygit -g ($env.HOME | path join ".cfg") -w $env.HOME
def --env proxy [] {
	$env.http_proxy  = 'http://127.0.0.1:11451'
	$env.https_proxy = 'http://127.0.0.1:11451'
	$env.all_proxy   = 'http://127.0.0.1:11451'
	$env.no_proxy    = 'localhost,127.0.0.1,::1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12'
	echo 'Terminal proxy enabled.'
}
def --env unproxy [] {
	hide-env http_proxy https_proxy all_proxy no_proxy
	echo 'Terminal proxy disabled.'
}
def --env cdw [cmd: string] {
    let cmd_path = (which $cmd | get path | first)

    if ($cmd_path | is-empty) {
        print $"Not found: ($cmd)"
        return
    }

    let cmd_dir = ($cmd_path | path dirname)

    print $"Changing to directory: ($cmd_dir)"
    cd $cmd_dir
}
def dos2lf [...files: string] {
    for f in $files {
        if ($f | path exists) {
            open $f
            | str replace -a "\r" ""
            | save -f $f
        }
    }
}

#= Officially recommended
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		cd $cwd
	}
	rm -fp $tmp
}

source $"($nu.cache-dir)/carapace.nu"

#== One-time setup
# Generates integration scripts
# Optional after installation; can be removed or commented out

# mkdir ($nu.data-dir | path join "vendor/autoload")
# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
# zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

# mkdir ($nu.default-config-dir | path join "autoload")
# fzf --nushell | save -f ($nu.default-config-dir | path join "autoload" "_fzf_integration.nu")
