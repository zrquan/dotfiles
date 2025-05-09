# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh  # load personal prompt config
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme || echo "Install powerlevel10k first (use yay)"

# Add .dotfiles/bin directory to $PATH.
export PATH=$HOME/.local/bin:$HOME/.dotfiles/bin:$HOME/.config/emacs/bin:$PATH

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
plugins=(git emacs fzf docker docker-compose)

source $ZSH/oh-my-zsh.sh

# User configuration

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
  COPY="xclip -sel clip"
elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  COPY="wl-copy"
else
  echo "Unknown graphical environment."
  COPY=""
fi

# Enhance fzf
export FZF_DEFAULT_OPTS="
  --color=bg+:#363a4f,bg:-1,spinner:#f4dbd6,hl:#ed8796
  --color=fg:-1,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
  --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
  --color=selected-bg:#494d64
  --marker ▏ --pointer » --prompt '$ '
  --highlight-line
  --layout reverse
  --info inline-right
  --border
  --multi"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --height 60%
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | $COPY)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

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
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'" # Pipe my public key to clipboard
alias listen="lsof -P -i -n | fzf" # 查看网络连接
alias psf="ps aux | fzf"
alias open="xdg-open"
alias magit='emacs -e "(magit-status \"$(git rev-parse --show-toplevel)\")"'
alias vv="source .venv/bin/activate"
alias cat="bat -p --theme=base16"
alias tldr="navi"

alias ll="eza -l --icons --group-directories-first"
alias la="eza -al --icons --group-directories-first"
alias lt="eza -lr --sort=modified --icons"
alias lf="eza -fl --icons"
alias lfa="eza -afl --icons"
alias ld="eza -Dl --icons"
alias lda="eza -aDl --icons"

alias dils="docker images | fzf --bind 'ctrl-d:become(docker rmi {3})' --header 'Press CTRL-D to delete the image'"
# alias dcls="docker ps | fzf --bind 'ctrl-d:become(docker rm -f {1})' --header 'Press CTRL-D to remove the container'"

eval "$(zoxide init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
