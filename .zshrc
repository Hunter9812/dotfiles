# Created by newuser for 5.8.1
#
# * Variable
export SHELL='zsh'
export EDITOR='nvim'
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

#* Alias
#- App alias
alias open="explorer.exe"
alias o='explorer.exe .'
alias c='code .'
alias s='neofetch'
alias jo='joshuto'
alias cman='LANG=zh_CN.UTF-8 LANG_ALL=zh_CN.UTF-8 man'
alias vi='nvim'

#- Modified commands
alias ipa='ip addr show|grep "inet "'
alias ping='ping -c 5'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'

## ls
alias ls='ls -hF --color=auto'
alias ll='ls -alF'

## Safety features
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'


# * Base
bindkey -e
autoload -U compinit promptinit # autocomplete
#zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
compinit
promptinit
unsetopt BEEP
setopt CORRECT                  # 启用纠错
setopt CORRECT_ALL              # 对于所有命令都进行纠错

# * Theme
prompt walters
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg[yellow]%}%?%{$reset_color%}]"

# * Function
# - 目录栈（dirstack）
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

export PS1='%F{13}%~ %F{50}%B%# %f%b'


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/Hunter/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/Hunter/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/Hunter/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/Hunter/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

