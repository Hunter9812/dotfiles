#. Essential
bindkey -e
autoload -U compinit promptinit colors
compinit
promptinit
colors
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
setopt prompt_subst
setopt menucomplete
unsetopt BEEP

#. Variable
# fileManager='nautilus'
fileManager='dolphin'
export SHELL='zsh'
export EDITOR='nvim'
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export LANG=en_US.UTF-8
export FZF_CTRL_R_OPTS='--no-sort --exact'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export SBT_OPTS="-Dsbt.override.build.repos=true"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
#.. mirror
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
export NPM_CONFIG_REGISTRY=https://registry.npmmirror.com
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/
export COURSIER_REPOSITORIES=https://maven.aliyun.com/repository/public
export POETRY_PYPI_MIRROR_URL=https://pypi.tuna.tsinghua.edu.cn/simple
export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$HOME/.local/bin:$PATH

#. Alias
alias c='code .'
alias o='$fileManager . >/dev/null 2>&1 &'
alias jo='joshuto'
alias s='fastfetch'
alias fps='ps aux | fzf'
alias fzfinstall="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias fzfremove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias lzd='lazydocker'
alias cman='LANG=zh_CN.UTF-8 man'
alias dockerIPFetcher="docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
#.. modified commands
alias upoweri='upower -i $(upower -e | grep battery)'
alias ipa='ip addr show|grep "inet "'
alias ping='ping -c 5'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ls='ls -hF --color=auto'
alias ll='ls -alF'
#.. safety features
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
#.. Function
open() {
    $fileManager "$@" >/dev/null 2>&1 &
}
cpr() {
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
}
mvr() {
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}
proxy() {
    export http_proxy=http://127.0.0.1:11451
    export https_proxy=http://127.0.0.1:11451
    export socks_proxy=socks5://127.0.0.1:7898
    echo -e "终端代理已开启。"
}
unproxy() {
    unset http_proxy https_proxy socks_proxy
    echo -e "终端代理已关闭。"
}
#. Plugin
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#. MISC
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/opt/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/opt/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
