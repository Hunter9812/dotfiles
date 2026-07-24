#= Envirment
export LANG="zh_CN.UTF-8"
export EDITOR="nvim"
export profile="$ZDOTDIR/.zshrc" # just like pwsh

#= Path
export GOPATH="$HOME/.local/share/go"
export PNPM_HOME="$HOME/.local/share/pnpm"
local TEXLIVE_ROOT="$HOME/opt/texlive/2026"

typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.local/share/coursier/bin"
  "$HOME/.local/share/JetBrains/Toolbox/scripts"
  "$PNPM_HOME/bin"
  "$TEXLIVE_ROOT/bin/x86_64-linux"
  $path
)
export PATH

typeset -U manpath MANPATH
manpath=(
  $TEXLIVE_ROOT/texmf-dist/doc/man
  $manpath
  ""
)
export MANPATH

typeset -U infopath INFOPATH
infopath=(
  $TEXLIVE_ROOT/texmf-dist/doc/info
  $infopath
  ""
)
export INFOPATH

#== App

#== Mirrors
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
export NPM_CONFIG_REGISTRY="https://registry.npmmirror.com"
export NVM_NODEJS_ORG_MIRROR="https://npmmirror.com/mirrors/node/"
export POETRY_PYPI_MIRROR_URL="https://pypi.tuna.tsinghua.edu.cn/simple"
export NODE_MIRROR="https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/"
export COURSIER_REPOSITORIES="https://maven.aliyun.com/repository/public"

#== Toolchain config
export SBT_OPTS="-Dsbt.override.build.repos=true"
