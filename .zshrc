# Essential
bindkey -e
autoload -U compinit promptinit # autocomplete
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
compinit
promptinit
unsetopt BEEP
# setopt CORRECT                  # 启用纠错
# setopt CORRECT_ALL              # 对于所有命令都进行纠错

# Enviroment
PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
PATH=~/.local/bin:$PATH

# Alias
## app alias
alias c='code .'
alias o='nautilus . >/dev/null 2>&1 &'
alias s='fastfetch'
alias lzd='lazydocker'
alias jo='joshuto'
alias cman='LANG=zh_CN.UTF-8 man'
alias dockerIPFetcher="docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
## modified commands
alias proxy='export all_proxy=http://127.0.0.1:11451'
alias unproxy='unset all_proxy'
alias ipa='ip addr show|grep "inet "'
alias ping='ping -c 5'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ls='ls -hF --color=auto'
alias ll='ls -alF'
### safety features
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Function
open() {
    nautilus "$@" >/dev/null 2>&1 &
}
cpr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
} 
mvr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}

# Variable
export SHELL='zsh'
export EDITOR='nvim'
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export LANG=en_US.UTF-8
export SBT_OPTS="-Dsbt.override.build.repos=true"
## mirror
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node/
export COURSIER_REPOSITORIES=https://maven.aliyun.com/repository/public
export POETRY_PYPI_MIRROR_URL=https://pypi.tuna.tsinghua.edu.cn/simple
export PATH

# Theme
prompt walters
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg[yellow]%}%?%{$reset_color%}]"
export PS1='%F{13}%~ %F{50}%B%# %f%b'

# Plugin
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# MISC
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
