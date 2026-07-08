bindkey -e
unsetopt BEEP
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
setopt prompt_subst
setopt menucomplete
setopt CORRECT

export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_IGNORE_SPACE

#= Variable
fileManager='nautilus' # or use dolphin
export LANG='en_US.UTF-8'
export FZF_DEFAULT_OPTS="
    --layout=reverse
    --border
    --info=inline
    --pointer='▶'
    --marker='✓'
    --color='fg+:white,hl:yellow,hl+:yellow,prompt:blue,header:magenta'
"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

#= Alias & Function

#== Abbr
alias ni='touch'
alias se='sudoedit'
alias s='fastfetch'
alias o='$fileManager . >/dev/null 2>&1 &'
alias g='lazygit'
alias c='code .'
alias oc='opencode'
alias cmd='command'

#== Enhance
_has() { command -v "$1" >/dev/null 2>&1 }
# zoxide, eza, bat, ripgrep
if _has zoxide; then
  alias cd='z'
fi
if _has eza; then
  alias ls="eza --icons --group-directories-first --time-style '+%Y-%m-%d %H:%M:%S'"
  alias ll='ls --long --header --git'
  alias tree='ls --tree --level=3'
else
  alias ls='ls --color=auto --classify --group-directories-first'
  alias ll='ls -l --human-readable'
fi
if _has bat; then
  # See https://github.com/sharkdp/bat
  alias cat='bat --paging=never --style=plain'
  # https://github.com/sharkdp/bat#fzf
  alias ff="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  # https://github.com/sharkdp/bat#man
  export MANPAGER='bat -plman'
  # https://github.com/sharkdp/bat#highlighting---help-messages
  bathelp() { bat --plain --language=help }
  help() { "$@" --help 2>&1 | bathelp }
  alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
  export BAT_PAGER='builtin'
  alias view='bat'
else
  alias ff="fzf --preview 'less {}'"
  alias view='less'
fi
export LESS='--RAW-CONTROL-CHARS --ignore-case --quit-if-one-screen'
if _has rg; then
  alias rg='rg --smart-case'
fi
alias grep='grep --color=auto'
alias rm='rm -i'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias df='df -h'
alias du='du -c -h'
alias cpr='rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1'
alias mvr='rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files'
tldr() { [[ "$1" == "-u" ]] && { proxy; command tldr "$@"; unproxy; } || command tldr "$@"; }

#== Utils
alias reload='exec zsh'
alias cman='LANG=zh_CN.UTF-8 man'
alias ipa="ip addr show | grep 'inet '"
alias fps='ps aux | fzf'
alias battery='upower -i $(upower -e | grep battery)'
alias bat-rate='upower -i $(upower -e | grep battery) | awk "/History \(rate\):/{f=1;print;next}/History \(voltage\):/{f=0}f"'
alias bat-volt='upower -i $(upower -e | grep battery) | awk "/History \(voltage\):/{f=1;print;next}/^  [a-zA-Z]/{f=0}f"'
alias bat-history='upower -i $(upower -e | grep battery) | awk "/History \(rate\):/{r=1;print;next}/History \(voltage\):/{r=0;v=1;print;next}/^  [a-zA-Z]/{v=0} r||v"'
alias docker_ip_fetcher='docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias conf='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
compdef conf=git
# See https://github.com/jesseduffield/lazygit/issues/5469#issuecomment-4213154549
alias confg='lazygit -g $HOME/.cfg -w $HOME'

open() { $fileManager "$@" >/dev/null 2>&1 & }
dos2lf() { sed -i 's/\r$//' "$@" }
runbg() { nohup "$@" >/dev/null 2>&1 </dev/null & disown }
edit() {
    mkdir -p "$(dirname "$1")"
    $EDITOR "$1"
}
proxy() {
  export http_proxy=http://127.0.0.1:11451
  export https_proxy=http://127.0.0.1:11451
  export all_proxy=http://127.0.0.1:11451
  echo 'Terminal proxy enabled.'
}
unproxy() {
  unset http_proxy https_proxy all_proxy
  echo 'Terminal proxy disabled.'
}
cdw() {
  if (( $# == 0 )); then
    echo "Usage: $0 <command>"
    return 1
  fi

  local cmd_path="${1:c}"
  [[ -z "$cmd_path" ]] && cmd_path=$(whence -p "$1")

  if [[ -z "$cmd_path" ]]; then
    echo "Command not found: $1"
    return 1
  fi

  local cmd_dir="${cmd_path:h}"

  echo "Changing to directory: $cmd_dir"
  cd "$cmd_dir" || echo 'Failed to change directory'
}
compdef _command_names cdw
printfiles() {
  local lines=${1:-10}
  if ! [[ "$lines" =~ ^[0-9]+$ ]]; then
    echo 'Error: lines must be a positive integer.'
    return 1
  fi

  for f in *; do
    [ -f "$f" ] || continue

    if file "$f" | grep -q text; then
      echo "==== $f ===="
      head -n "$lines" "$f"
      echo
    fi
  done
}
#=== Neovim
vidiff() {
  if [ $# -lt 2 ]; then
    echo "Usage: ndiff file1 file2 [l|h]"
    return 1
  fi

  local f1="$1"
  local f2="$2"
  local focus="${3:-l}"

  if [ "$focus" = "h" ]; then
    nvim -d "$f1" "$f2" -c "wincmd h"
  else
    nvim -d "$f1" "$f2" -c "wincmd l"
  fi
}

#= Distro
alias upmirror='sudo reflector --country China --protocol https --latest 20 --sort rate --save /etc/pacman.d/mirrorlist'
alias pkgadd="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pkgrm="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias pkgclr='sudo pacman -Rns $(pacman -Qdtq)'

#= Officially recommended
alias lzd='lazydocker'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# fzf's [key bindings](https://github.com/junegunn/fzf#key-bindings-for-command-line)
# CTRL-R  : search command history (fzf reverse history search)
# CTRL-T  : search files and directories (insert selected path into command line)
# ALT-C   : search directories and cd into selected directory
source <(fzf --zsh)

#== Check and load something
export NVM_DIR="$HOME/.nvm"
ZSH_PLUGIN_DIR='/usr/share/zsh/plugins'

plugins=(
  "$NVM_DIR/nvm.sh"
  "$NVM_DIR/bash_completion"
  '/opt/miniforge/etc/profile.d/conda.sh'
  "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  "$ZSH_PLUGIN_DIR/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
)

for p in $plugins; do
  if [[ -f "$p" ]]; then
    source "$p"
  fi
done

if (( ${+functions[_zsh_autosuggest_start]} )); then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=245' # dark terminal
  # ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=237' # light terminal
fi

# zsh-vi-mode overwrites keybindings of other zsh plugins, [link](https://github.com/jeffreytse/zsh-vi-mode/issues/127#issuecomment-930104572)
# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  zvm_bindkey viins '^R' fzf-history-widget
  zvm_bindkey vicmd '/'  fzf-history-widget
}
