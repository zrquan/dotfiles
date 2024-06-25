# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add .dotfiles/bin directory to $PATH.
export PATH=$HOME/.dotfiles/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git emacs autojump fzf docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

# Proxy enable by default
export http_proxy=http://127.0.0.1:10809 https_proxy=http://127.0.0.1:10809 all_proxy=socks5://127.0.0.1:10808

# Enhance fzf
export FZF_DEFAULT_OPTS="--border --multi --info inline-right --layout reverse --marker ▏ --pointer ▌ --prompt '▌ ' --highlight-line --color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export GOPATH=~/.local/share/go
export PATH=$GOPATH/bin:$PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='emacs'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs, plugins, and themes.
alias clproxy="export https_proxy= http_proxy= all_proxy=" # clean proxy
alias setproxy="export http_proxy=http://127.0.0.1:10809 https_proxy=http://127.0.0.1:10809 all_proxy=socks5://127.0.0.1:10808"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'" # Pipe my public key to clipboard
alias listen="lsof -P -i -n | fzf" # 查看网络连接
alias psf="ps aux | fzf"
alias open="xdg-open"
alias unzip-zh="unzip -O CP936"
alias dils="docker images | fzf"
alias dcip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias pch="proxychains -q"

# Powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme || echo "Install powerlevel10k first (use yay)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# init pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# init jenv
eval "$(jenv init -)"
