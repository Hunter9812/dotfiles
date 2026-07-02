#= Envirment
export LANG="zh_CN.UTF-8"
export EDITOR="nvim"
export profile="$ZDOTDIR/.zshrc" # just like pwsh

#= Path
export GOPATH="$HOME/.local/share/go"
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.local/share/coursier/bin"
  "$HOME/.local/share/JetBrains/Toolbox/scripts"
  $path
)
export PATH

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
