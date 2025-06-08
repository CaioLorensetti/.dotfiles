export ZSH="$HOME/.oh-my-zsh"
export DOTNET_ROOT=$HOME/.dotnet
export HOMEBREW_ROOT=$HOME/../linuxbrew/.linuxbrew/bin
export DOCKER_ROOT="/usr/bin/docker"
export BUN_ROOT="$HOME/.bun/bin"
export CHT_SH="$HOME/bin"
export CARGO="$HOME/.cargo/bin"
export PATH=$PATH:$DOTNET_ROOT:$HOMEBREW_ROOT:$CHT_SH:$DOCKER_ROOT:$BUN_ROOT:$CARGO
export ASPNETCORE_ENVIRONMENT=Development

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

alias code='code-insiders'
ZSH_THEME="robbyrussell"


export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=false

plugins=(
  git
  git-auto-fetch
  zsh-autosuggestions
  zsh-syntax-highlighting
  kubectl
  dotnet
  tmux
)

source $ZSH/oh-my-zsh.sh
source ~/.kubeuolrc


fpath+=${ZDOTDIR:-~}/.zsh_functions

